#!/usr/bin/env python3
"""
zk Weekly Summary Generator
Uses LiteLLM + Gemini 2.5 Flash-Lite to generate AI-powered weekly summaries
Categorizes tasks into: governance, project, support
"""

import sys
import re
import argparse
from datetime import datetime, timedelta
from pathlib import Path

try:
    from litellm import completion
except ImportError:
    print("Error: litellm not installed. Run: pip install litellm", file=sys.stderr)
    sys.exit(1)


def parse_week_argument(week_arg):
    """
    Parse week argument and return datetime for that week's Monday

    Formats supported:
    - None: current week
    - "06": week 06 of current year
    - "2025-W52": specific year and week
    - "last" or "prev": previous week
    - "next": next week

    Returns:
        datetime: A date within the specified week
    """
    now = datetime.now()

    if week_arg is None:
        # Current week
        return now

    week_arg = week_arg.strip()
    week_arg_lower = week_arg.lower()

    # Relative weeks
    if week_arg_lower in ["last", "prev", "previous"]:
        return now - timedelta(weeks=1)
    elif week_arg_lower == "next":
        return now + timedelta(weeks=1)

    # Parse week number formats
    if "-W" in week_arg or "-w" in week_arg:
        # Format: "2025-W52" or "2025-w52"
        try:
            parts = week_arg.upper().split("-W")
            year = int(parts[0])
            week = int(parts[1])
        except (ValueError, IndexError):
            print(
                f"Error: Invalid week format '{week_arg}'. Use '2025-W52'",
                file=sys.stderr,
            )
            sys.exit(1)
    else:
        # Format: "06" (current year)
        try:
            year = now.year
            week = int(week_arg)
        except ValueError:
            print(f"Error: Invalid week number '{week_arg}'", file=sys.stderr)
            sys.exit(1)

    # Validate week number
    if not (1 <= week <= 53):
        print(
            f"Error: Week number must be between 1 and 53, got {week}", file=sys.stderr
        )
        sys.exit(1)

    # Calculate Monday of that week using ISO week date
    # ISO week 1 is the first week with Thursday in the new year
    jan_4 = datetime(year, 1, 4)  # Jan 4 is always in week 1
    week_1_monday = jan_4 - timedelta(days=jan_4.weekday())
    target_monday = week_1_monday + timedelta(weeks=week - 1)

    return target_monday


def get_week_info(reference_date=None):
    """Get week number and date range for a given date"""
    if reference_date is None:
        reference_date = datetime.now()

    # Use ISO calendar for consistent week numbering
    iso_year, iso_week, iso_weekday = reference_date.isocalendar()
    week_num = f"{iso_week:02d}"
    year = str(iso_year)

    # Get Monday of the week
    monday = reference_date - timedelta(days=reference_date.weekday())
    # Get Sunday of the week
    sunday = monday + timedelta(days=6)

    return {
        "year": year,
        "week": week_num,
        "filename": f"{year}-W{week_num}",
        "monday": monday,
        "sunday": sunday,
        "title": f"{year}-W{week_num} -- {monday.strftime('%A, %B %d, %Y')} - {sunday.strftime('%A, %B %d, %Y')}",
    }


def extract_hashtags(text):
    """Extract hashtags from text"""
    # Match #word but not #word# (to avoid multi-word tags)
    # Require hashtags to start with a letter (not numbers or underscores)
    return set(re.findall(r"#([a-zA-Z]\w*)(?!\w)", text))


def categorize_task(task_text, hashtags):
    """
    Categorize task based on hashtags or content inference
    Categories: governance, project, support
    """
    # Check hashtags first
    if "governance" in hashtags:
        return "governance"
    if "project" in hashtags:
        return "project"
    if "support" in hashtags:
        return "support"

    # Inference based on keywords (case-insensitive)
    task_lower = task_text.lower()

    # Governance indicators
    governance_keywords = [
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

    # Support indicators
    support_keywords = [
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

    # Project indicators
    project_keywords = [
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

    # Count matches
    governance_score = sum(1 for kw in governance_keywords if kw in task_lower)
    support_score = sum(1 for kw in support_keywords if kw in task_lower)
    project_score = sum(1 for kw in project_keywords if kw in task_lower)

    # Return category with highest score, default to project
    if governance_score > support_score and governance_score > project_score:
        return "governance"
    elif support_score > project_score:
        return "support"
    else:
        return "project"


def parse_daily_note(content):
    """Parse daily note and extract categorized tasks"""
    lines = content.split("\n")
    tasks = {"governance": [], "project": [], "support": []}

    # Extract all hashtags from the note
    note_hashtags = extract_hashtags(content)

    for line in lines:
        # Match task lines: - [x], - [-], - [ ]
        if re.match(r"^\s*-\s*\[[x\-\s]\]", line):
            # Extract hashtags from this specific line
            line_hashtags = extract_hashtags(line)
            all_hashtags = note_hashtags | line_hashtags

            # Clean the task text (remove checkbox and hashtags for display)
            task_text = re.sub(r"^\s*-\s*\[[x\-\s]\]\s*", "", line)
            task_text = re.sub(r"\s*#\w+", "", task_text).strip()

            if task_text:
                category = categorize_task(line, all_hashtags)
                tasks[category].append(task_text)

    return tasks


def get_daily_notes(week_info):
    """Get all daily notes for current week by checking filenames in date range"""
    import os

    # Allow notebook directory to be configured via environment variable
    notebook_path = os.getenv(
        "ZK_NOTEBOOK_DIR", str(Path.home() / "Cloud" / "Sync" / "notebook")
    )
    notebook_dir = Path(notebook_path)
    daily_dir = notebook_dir / "journal" / "daily"

    # Generate list of expected daily note filenames for the week
    daily_notes = []
    current_date = week_info["monday"]

    for day_offset in range(7):  # Monday to Sunday
        date = current_date + timedelta(days=day_offset)
        filename = date.strftime("%Y-%m-%d") + ".md"
        note_path = daily_dir / filename

        if note_path.exists():
            try:
                content = note_path.read_text()
                tasks = parse_daily_note(content)

                # Extract title from frontmatter or use date
                title_match = re.search(r"^title:\s*(.+)$", content, re.MULTILINE)
                title = (
                    title_match.group(1).strip()
                    if title_match
                    else date.strftime("%Y/%m/%d")
                )

                daily_notes.append(
                    {
                        "date": title,
                        "path": f"journal/daily/{filename}",
                        "content": content,
                        "tasks": tasks,
                    }
                )
            except Exception as e:
                print(f"Warning: Could not read {note_path}: {e}", file=sys.stderr)

    return sorted(daily_notes, key=lambda x: x["date"])


def aggregate_tasks(daily_notes):
    """Aggregate all tasks by category across the week"""
    aggregated = {"governance": [], "project": [], "support": []}

    for note in daily_notes:
        for category in ["governance", "project", "support"]:
            aggregated[category].extend(note["tasks"][category])

    return aggregated


def generate_summary(daily_notes, aggregated_tasks):
    """Generate AI summary using LiteLLM + Gemini 2.5 Flash-Lite"""
    import os

    # Validate API key is set
    if not os.getenv("GEMINI_API_KEY"):
        print("Error: GEMINI_API_KEY environment variable not set", file=sys.stderr)
        print(
            "Please set your API key: export GEMINI_API_KEY='your-key-here'",
            file=sys.stderr,
        )
        sys.exit(1)

    if not daily_notes:
        return {
            "overview": "No daily notes found for this week.",
            "governance": [],
            "project": [],
            "support": [],
        }

    # Prepare categorized context for LLM
    governance_text = (
        "\n".join([f"- {task}" for task in aggregated_tasks["governance"]]) or "None"
    )
    project_text = (
        "\n".join([f"- {task}" for task in aggregated_tasks["project"]]) or "None"
    )
    support_text = (
        "\n".join([f"- {task}" for task in aggregated_tasks["support"]]) or "None"
    )

    prompt = f"""You are summarizing a week of work notes for an SRE/Platform Engineer.

The tasks have been categorized into three areas:

**GOVERNANCE** (access management, onboarding/offboarding, security, compliance, documentation):
{governance_text}

**PROJECT** (feature development, infrastructure improvements, deployments, migrations):
{project_text}

**SUPPORT** (bug fixes, troubleshooting, incidents, urgent requests):
{support_text}

Generate a professional weekly summary in English with:

1. **Overview**: A brief 2-3 sentence summary of the week's focus and key accomplishments

2. **Governance Highlights**: 3-5 bullet points summarizing governance work (or "None" if empty)

3. **Project Highlights**: 3-5 bullet points summarizing project work (or "None" if empty)

4. **Support Highlights**: 3-5 bullet points summarizing support work (or "None" if empty)

Keep it concise, technical, and professional. Focus on outcomes and impact.

Format your response EXACTLY as:
OVERVIEW:
[your overview text]

GOVERNANCE:
- [bullet point]
- [bullet point]

PROJECT:
- [bullet point]
- [bullet point]

SUPPORT:
- [bullet point]
- [bullet point]"""

    try:
        response = completion(
            model="gemini/gemini-2.5-flash-lite",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.3,
            max_tokens=1500,
        )

        summary_text = response.choices[0].message.content.strip()

        # Parse the response
        parsed = parse_ai_response(summary_text)
        return parsed

    except Exception as e:
        print(f"Error generating summary: {e}", file=sys.stderr)
        return {
            "overview": "Error: Could not generate AI summary. Check your GEMINI_API_KEY environment variable.",
            "governance": [],
            "project": [],
            "support": [],
        }


def parse_ai_response(text):
    """Parse AI response into structured format"""
    result = {"overview": "", "governance": [], "project": [], "support": []}

    # Extract overview
    overview_match = re.search(r"OVERVIEW:\s*\n(.*?)\n\n", text, re.DOTALL)
    if overview_match:
        result["overview"] = overview_match.group(1).strip()

    # Extract governance (more forgiving regex for end-of-string)
    governance_match = re.search(
        r"GOVERNANCE:\s*\n(.*?)(?:\n\n(?=[A-Z]+:)|$)", text, re.DOTALL
    )
    if governance_match:
        result["governance"] = [
            line.strip("- ").strip()
            for line in governance_match.group(1).strip().split("\n")
            if line.strip() and line.strip() != "None"
        ]

    # Extract project (more forgiving regex for end-of-string)
    project_match = re.search(
        r"PROJECT:\s*\n(.*?)(?:\n\n(?=[A-Z]+:)|$)", text, re.DOTALL
    )
    if project_match:
        result["project"] = [
            line.strip("- ").strip()
            for line in project_match.group(1).strip().split("\n")
            if line.strip() and line.strip() != "None"
        ]

    # Extract support (more forgiving regex for end-of-string)
    support_match = re.search(
        r"SUPPORT:\s*\n(.*?)(?:\n\n(?=[A-Z]+:)|$)", text, re.DOTALL
    )
    if support_match:
        result["support"] = [
            line.strip("- ").strip()
            for line in support_match.group(1).strip().split("\n")
            if line.strip() and line.strip() != "None"
        ]

    return result


def create_weekly_note(week_info, daily_notes, summary, dry_run=False):
    """Create or update weekly note with AI summary and daily links"""
    import os

    # Allow notebook directory to be configured via environment variable
    notebook_path = os.getenv(
        "ZK_NOTEBOOK_DIR", str(Path.home() / "Cloud" / "Sync" / "notebook")
    )
    notebook_dir = Path(notebook_path)
    weekly_path = notebook_dir / "journal" / "weekly" / f"{week_info['filename']}.md"

    # Build daily links section
    daily_links = []
    for note in daily_notes:
        # Extract date from path (e.g., journal/daily/2026-02-18.md -> 2026-02-18)
        date_str = Path(note["path"]).stem
        daily_links.append(f"- [[{note['path']}|{date_str}]]")

    daily_links_text = (
        "\n".join(daily_links) if daily_links else "- No daily notes this week"
    )

    # Build categorized sections
    governance_section = (
        "\n".join([f"- {item}" for item in summary["governance"]])
        if summary["governance"]
        else "- None"
    )
    project_section = (
        "\n".join([f"- {item}" for item in summary["project"]])
        if summary["project"]
        else "- None"
    )
    support_section = (
        "\n".join([f"- {item}" for item in summary["support"]])
        if summary["support"]
        else "- None"
    )

    # Build weekly note content
    content = f"""---
title: {week_info["title"]}
date: {datetime.now().strftime("%d/%m/%Y %H:%M:%S")}
tags: [journal, weekly]
---

# Weekly Summary

{summary["overview"]}

## Governance

{governance_section}

## Project Work

{project_section}

## Support

{support_section}

---

# Daily Notes

{daily_links_text}
"""

    # Dry-run mode: print content instead of writing
    if dry_run:
        print(f"\n📄 Would create: {weekly_path}\n")
        print("=" * 80)
        print(content)
        print("=" * 80)
        print(f"\n💡 Run without --dry-run to create the file")
        return weekly_path

    # Write the file
    weekly_path.parent.mkdir(parents=True, exist_ok=True)
    weekly_path.write_text(content)

    return weekly_path


def main():
    """Main execution"""
    # Parse command-line arguments
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
    args = parser.parse_args()

    # Show dry-run mode indicator
    if args.dry_run:
        print("\n🔍 DRY RUN MODE - No files will be modified\n")

    # Parse week argument
    reference_date = parse_week_argument(args.week)

    # Show which week we're processing
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
        summary = {
            "overview": "No daily notes recorded this week.",
            "governance": [],
            "project": [],
            "support": [],
        }
    else:
        # Aggregate tasks by category
        aggregated_tasks = aggregate_tasks(daily_notes)
        print(f"\n📊 Task breakdown:")
        print(f"   Governance: {len(aggregated_tasks['governance'])} tasks")
        print(f"   Project: {len(aggregated_tasks['project'])} tasks")
        print(f"   Support: {len(aggregated_tasks['support'])} tasks")

        print("\n🤖 Generating AI summary with Gemini 2.5 Flash-Lite...")
        summary = generate_summary(daily_notes, aggregated_tasks)

    if args.dry_run:
        print("\n✍️  Preview of weekly note...")
    else:
        print("\n✍️  Creating weekly note...")

    weekly_path = create_weekly_note(
        week_info, daily_notes, summary, dry_run=args.dry_run
    )

    if not args.dry_run:
        print(f"\n✅ Weekly note created: {weekly_path}")
        print(f"\n📝 Open with: zk edit {week_info['filename']}")


if __name__ == "__main__":
    main()
