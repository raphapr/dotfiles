#!/usr/bin/env python3
"""
zk Weekly Summary Generator
Uses LiteLLM + Gemini 2.5 Flash-Lite to generate AI-powered weekly summaries
Categorizes tasks into: core, governance, project, support
"""

import os
import sys
import re
import argparse
from datetime import date, datetime, timedelta
from pathlib import Path

try:
    from litellm import completion
except ImportError:
    print("Error: litellm not installed. Run: pip install litellm", file=sys.stderr)
    sys.exit(1)


# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

CATEGORIES = ["core", "governance", "project", "support"]

CATEGORY_DESCRIPTIONS = {
    "core": "core platform work, foundational improvements, internal tooling, reliability",
    "governance": "access management, onboarding/offboarding, security, compliance, documentation",
    "project": "feature development, infrastructure improvements, deployments, migrations",
    "support": "bug fixes, troubleshooting, incidents, urgent requests",
}

# Keywords used for heuristic categorisation when no hashtag is present.
# Each value is a frozenset for O(1) membership tests.
KEYWORD_MAP = {
    "governance": frozenset(
        [
            "offboard",
            "onboard",
            "access",
            "permission",
            "grant",
            "security",
            "compliance",
            "audit",
            "policy",
            "review",
            "documentation",
            "runbook",
            "process",
            "standard",
        ]
    ),
    "support": frozenset(
        [
            "fix",
            "bug",
            "issue",
            "troubleshoot",
            "investigate",
            "resolve",
            "debug",
            "hotfix",
            "incident",
            "urgent",
            "help",
            "assist",
            "support",
        ]
    ),
    "project": frozenset(
        [
            "implement",
            "deploy",
            "create",
            "build",
            "develop",
            "migrate",
            "upgrade",
            "refactor",
            "feature",
            "enhancement",
            "module",
            "infrastructure",
            "pipeline",
        ]
    ),
}

TASK_CHECKBOX_RE = re.compile(r"^\s*-\s*\[[x\-\s]\]")
JIRA_LINK_RE = re.compile(r"\[([A-Z][A-Z0-9]*-\d+)\]\(https?://[^\)]+\)")
JIRA_BARE_RE = re.compile(r"\b([A-Z][A-Z0-9]*-\d+)\b")
CHECKBOX_STRIP_RE = re.compile(r"^\s*-\s*\[[x\-\s]\]\s*")
MD_LINK_RE = re.compile(r"\[([^\]]+)\]\([^\)]+\)")
HASHTAG_STRIP_RE = re.compile(r"\s*#\w+")
HASHTAG_RE = re.compile(r"#([a-zA-Z]\w*)(?!\w)")
FRONTMATTER_TITLE_RE = re.compile(r"^title:\s*(.+)$", re.MULTILINE)

EMPTY_SUMMARY = {cat: [] for cat in CATEGORIES}

DEFAULT_NOTEBOOK = str(Path.home() / "Cloud" / "Sync" / "notebook")


# ---------------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------------


def _die(message: str) -> None:
    """Print an error message to stderr and exit."""
    print(f"Error: {message}", file=sys.stderr)
    sys.exit(1)


# ---------------------------------------------------------------------------
# Week utilities
# ---------------------------------------------------------------------------


def _monday_of_week_W(year: int, week: int) -> datetime:
    """Return the Monday of a given strftime %W week number.

    %W week 1 starts on the first Monday of the year; week 0 is the
    (possibly partial) week before that first Monday.
    """
    jan1 = date(year, 1, 1)
    first_monday = jan1 + timedelta(days=(7 - jan1.weekday()) % 7)
    if week == 0:
        return datetime.combine(first_monday - timedelta(weeks=1), datetime.min.time())
    return datetime.combine(
        first_monday + timedelta(weeks=week - 1), datetime.min.time()
    )


def parse_week_argument(week_arg: str | None) -> datetime:
    """Parse week argument and return a datetime within that week.

    Formats supported:
    - None: current week
    - "06": week 06 of current year
    - "2025-W52": specific year and week
    - "last" / "prev" / "previous": previous week
    - "next": next week
    """
    now = datetime.now()

    if week_arg is None:
        return now

    token = week_arg.strip()
    token_lower = token.lower()

    if token_lower in {"last", "prev", "previous"}:
        return now - timedelta(weeks=1)
    if token_lower == "next":
        return now + timedelta(weeks=1)

    year: int
    week: int

    if "-W" in token or "-w" in token:
        try:
            year_str, week_str = token.upper().split("-W")
            year, week = int(year_str), int(week_str)
        except (ValueError, IndexError):
            _die(f"Invalid week format '{week_arg}'. Use '2025-W52'")
            return now  # unreachable; satisfies type checker
    else:
        try:
            year, week = now.year, int(token)
        except ValueError:
            _die(f"Invalid week number '{week_arg}'")
            return now  # unreachable; satisfies type checker

    if not (1 <= week <= 53):
        _die(f"Week number must be between 1 and 53, got {week}")

    return _monday_of_week_W(year, week)


def get_week_info(reference_date: datetime | None = None) -> dict:
    """Return week metadata dict for the week containing *reference_date*."""
    if reference_date is None:
        reference_date = datetime.now()

    week_num = reference_date.strftime("%W")
    year = reference_date.strftime("%Y")
    monday = _monday_of_week_W(int(year), int(week_num))
    sunday = monday + timedelta(days=6)

    return {
        "year": year,
        "week": week_num,
        "filename": f"{year}-W{week_num}",
        "monday": monday,
        "sunday": sunday,
        "title": (
            f"{year}-W{week_num} -- "
            f"{monday.strftime('%A, %B %d, %Y')} - "
            f"{sunday.strftime('%A, %B %d, %Y')}"
        ),
    }


# ---------------------------------------------------------------------------
# Task parsing & categorisation
# ---------------------------------------------------------------------------


def extract_hashtags(text: str) -> set[str]:
    """Return the set of hashtag names found in *text* (without the '#')."""
    return set(HASHTAG_RE.findall(text))


def categorize_task(task_text: str, hashtags: set[str]) -> str:
    """Return the category for a task, preferring explicit hashtags.

    Falls back to keyword scoring when no category hashtag is present.
    Default category when scores are tied: 'project'.
    """
    for cat in CATEGORIES:
        if cat in hashtags:
            return cat

    task_lower = task_text.lower()
    scores = {
        cat: sum(1 for kw in keywords if kw in task_lower)
        for cat, keywords in KEYWORD_MAP.items()
    }
    best = max(scores, key=lambda c: scores[c])
    return best if scores[best] > 0 else "project"


def _clean_task_text(line: str) -> tuple[str, list[str]]:
    """Strip checkbox, markdown links, and hashtags from a task line.

    Returns (cleaned_text, jira_keys).
    """
    jira_keys = JIRA_LINK_RE.findall(line) or JIRA_BARE_RE.findall(line)
    text = CHECKBOX_STRIP_RE.sub("", line)
    text = MD_LINK_RE.sub(r"\1", text)
    text = HASHTAG_STRIP_RE.sub("", text).strip()

    for key in jira_keys:
        if key not in text:
            text = f"{key}: {text}"

    return text, jira_keys


def parse_daily_note(content: str) -> dict[str, list[str]]:
    """Parse a daily note and return tasks grouped by category."""
    tasks = {cat: [] for cat in CATEGORIES}

    for line in content.splitlines():
        if not TASK_CHECKBOX_RE.match(line):
            continue

        task_text, _ = _clean_task_text(line)
        if not task_text:
            continue

        category = categorize_task(line, extract_hashtags(line))
        tasks[category].append(task_text)

    return tasks


# ---------------------------------------------------------------------------
# Daily note loading
# ---------------------------------------------------------------------------


def get_daily_notes(week_info: dict) -> list[dict]:
    """Load and return daily notes for the week described by *week_info*."""
    notebook_dir = Path(os.getenv("ZK_NOTEBOOK_DIR", DEFAULT_NOTEBOOK))
    daily_dir = notebook_dir / "journal" / "daily"

    notes = []
    for day_offset in range(7):
        note_date = week_info["monday"] + timedelta(days=day_offset)
        filename = note_date.strftime("%Y-%m-%d") + ".md"
        note_path = daily_dir / filename

        if not note_path.exists():
            continue
        try:
            content = note_path.read_text()
        except Exception as exc:
            print(f"Warning: Could not read {note_path}: {exc}", file=sys.stderr)
            continue

        title_match = FRONTMATTER_TITLE_RE.search(content)
        title = (
            title_match.group(1).strip()
            if title_match
            else note_date.strftime("%Y/%m/%d")
        )

        notes.append(
            {
                "date": note_date,  # real datetime — used for sorting
                "title": title,  # display title
                "path": f"journal/daily/{filename}",
                "content": content,
                "tasks": parse_daily_note(content),
            }
        )

    return sorted(notes, key=lambda n: n["date"])


def aggregate_tasks(daily_notes: list[dict]) -> dict[str, list[str]]:
    """Merge per-day task lists into a single dict keyed by category."""
    aggregated = {cat: [] for cat in CATEGORIES}
    for note in daily_notes:
        for cat in CATEGORIES:
            aggregated[cat].extend(note["tasks"][cat])
    return aggregated


# ---------------------------------------------------------------------------
# AI summary generation
# ---------------------------------------------------------------------------


def _tasks_to_text(tasks: list[str]) -> str:
    """Format a task list as bullet points, or 'None' when empty."""
    return "\n".join(f"- {t}" for t in tasks) if tasks else "None"


def _build_prompt(aggregated_tasks: dict[str, list[str]]) -> str:
    """Build the LLM prompt from categorised tasks."""
    category_blocks = "\n\n".join(
        f"**{cat.upper()}** ({CATEGORY_DESCRIPTIONS[cat]}):\n{_tasks_to_text(aggregated_tasks[cat])}"
        for cat in CATEGORIES
    )

    section_instructions = "\n".join(
        f"{i + 2}. **{cat.capitalize()} Highlights**: 3-5 bullet points summarizing "
        f'{cat} work (or "None" if empty)'
        for i, cat in enumerate(CATEGORIES)
    )

    response_sections = "\n\n".join(
        f"{cat.upper()}:\n- [bullet point]\n- [bullet point]" for cat in CATEGORIES
    )

    return f"""You are summarizing a week of work notes for an SRE/Platform Engineer.

The tasks have been categorized into {len(CATEGORIES)} areas:

{category_blocks}

Generate a professional weekly summary in English with:

1. **Overview**: A brief 2-3 sentence summary of the week's focus and key accomplishments

{section_instructions}

Keep it concise, technical, and professional. Focus on outcomes and impact.
IMPORTANT: Whenever a task includes a Jira issue key (e.g. PLATFORM-1234), always include that key in the corresponding bullet point.

Format your response EXACTLY as:
OVERVIEW:
[your overview text]

{response_sections}"""


def _parse_section(text: str, label: str) -> list[str]:
    """Extract bullet points under *label*: from an AI response string."""
    match = re.search(
        rf"{re.escape(label)}:\s*\n(.*?)(?:\n\n(?=[A-Z]+:)|$)", text, re.DOTALL
    )
    if not match:
        return []
    return [
        line.lstrip("- ").strip()
        for line in match.group(1).strip().splitlines()
        if line.strip() and line.strip() != "None"
    ]


def parse_ai_response(text: str) -> dict:
    """Parse a structured AI response into a summary dict."""
    overview_match = re.search(r"OVERVIEW:\s*\n(.*?)\n\n", text, re.DOTALL)
    return {
        "overview": overview_match.group(1).strip() if overview_match else "",
        **{cat: _parse_section(text, cat.upper()) for cat in CATEGORIES},
    }


def _call_llm(prompt: str) -> str:
    """Call Gemini via LiteLLM and return the raw response text."""
    response = completion(
        model="gemini/gemini-2.5-flash-lite",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
        max_tokens=1500,
    )
    return response.choices[0].message.content.strip()


def generate_summary(daily_notes: list[dict], aggregated_tasks: dict) -> dict:
    """Generate an AI summary dict from aggregated weekly tasks."""
    if not os.getenv("GEMINI_API_KEY"):
        print("Error: GEMINI_API_KEY environment variable not set", file=sys.stderr)
        print(
            "Please set your API key: export GEMINI_API_KEY='your-key-here'",
            file=sys.stderr,
        )
        sys.exit(1)

    if not daily_notes:
        return {"overview": "No daily notes found for this week.", **EMPTY_SUMMARY}

    try:
        raw = _call_llm(_build_prompt(aggregated_tasks))
        return parse_ai_response(raw)
    except Exception as exc:
        print(f"Error generating summary: {exc}", file=sys.stderr)
        return {
            "overview": "Error: Could not generate AI summary. Check your GEMINI_API_KEY environment variable.",
            **EMPTY_SUMMARY,
        }


# ---------------------------------------------------------------------------
# Weekly note rendering
# ---------------------------------------------------------------------------


def _section_bullets(items: list[str]) -> str:
    """Render a list of items as markdown bullets, or '- None'."""
    return "\n".join(f"- {item}" for item in items) if items else "- None"


def _render_weekly_note(week_info: dict, daily_notes: list[dict], summary: dict) -> str:
    """Render the full weekly note markdown string."""
    daily_links = (
        "\n".join(
            f"- [[{note['path']}|{Path(note['path']).stem}]]" for note in daily_notes
        )
        or "- No daily notes this week"
    )

    category_sections = "\n\n".join(
        f"## {cat.capitalize()}\n\n{_section_bullets(summary[cat])}"
        for cat in CATEGORIES
    )

    return (
        f"---\n"
        f"title: {week_info['title']}\n"
        f"date: {datetime.now().strftime('%d/%m/%Y %H:%M:%S')}\n"
        f"tags: [journal, weekly]\n"
        f"---\n"
        f"\n"
        f"# Weekly Summary\n"
        f"\n"
        f"{category_sections}\n"
        f"\n"
        f"---\n"
        f"\n"
        f"# Daily Notes\n"
        f"\n"
        f"{daily_links}\n"
    )


def create_weekly_note(
    week_info: dict,
    daily_notes: list[dict],
    summary: dict,
    dry_run: bool = False,
) -> Path:
    """Write (or preview) the weekly note file and return its path."""
    notebook_dir = Path(os.getenv("ZK_NOTEBOOK_DIR", DEFAULT_NOTEBOOK))
    weekly_path = notebook_dir / "journal" / "weekly" / f"{week_info['filename']}.md"
    content = _render_weekly_note(week_info, daily_notes, summary)

    if dry_run:
        print(f"\n📄 Would create: {weekly_path}\n")
        print("=" * 80)
        print(content)
        print("=" * 80)
        print("\n💡 Run without --dry-run to create the file")
        return weekly_path

    weekly_path.parent.mkdir(parents=True, exist_ok=True)
    weekly_path.write_text(content)
    return weekly_path


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def _build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Generate AI-powered weekly summaries for zk notes"
    )
    parser.add_argument(
        "--dry-run",
        "-n",
        action="store_true",
        help="Preview output without writing file",
    )
    parser.add_argument(
        "--week",
        "-w",
        type=str,
        default=None,
        help="Specify week: '06', '2025-W52', 'last', 'prev', 'next' (default: current week)",
    )
    return parser


def main() -> None:
    args = _build_arg_parser().parse_args()

    if args.dry_run:
        print("\n🔍 DRY RUN MODE - No files will be modified\n")

    reference_date = parse_week_argument(args.week)

    if args.week:
        print(f"📆 Processing week: {args.week}\n")

    print("🔍 Gathering week information...")
    week_info = get_week_info(reference_date)
    print(
        f"📅 Week {week_info['filename']}: {week_info['monday'].strftime('%Y-%m-%d')} to {week_info['sunday'].strftime('%Y-%m-%d')}"
    )

    print("\n📖 Reading daily notes...")
    daily_notes = get_daily_notes(week_info)
    print(f"   Found {len(daily_notes)} daily notes")

    if not daily_notes:
        print("\n⚠️  No daily notes found for this week. Creating empty weekly note...")
        summary = {"overview": "No daily notes recorded this week.", **EMPTY_SUMMARY}
    else:
        aggregated_tasks = aggregate_tasks(daily_notes)
        print("\n📊 Task breakdown:")
        for cat in CATEGORIES:
            print(f"   {cat.capitalize()}: {len(aggregated_tasks[cat])} tasks")

        print("\n🤖 Generating AI summary with Gemini 2.5 Flash-Lite...")
        summary = generate_summary(daily_notes, aggregated_tasks)

    print(
        "\n✍️  Preview of weekly note..."
        if args.dry_run
        else "\n✍️  Creating weekly note..."
    )
    weekly_path = create_weekly_note(
        week_info, daily_notes, summary, dry_run=args.dry_run
    )

    if not args.dry_run:
        print(f"\n✅ Weekly note created: {weekly_path}")
        print(f"\n📝 Open with: zk edit {week_info['filename']}")


if __name__ == "__main__":
    main()
