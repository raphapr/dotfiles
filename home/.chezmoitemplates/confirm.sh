confirm() {
  local -r prompt={{ . | shellQuote }}
  local reply=""

  # Without a TTY, exit 1 so chezmoi doesn't record this run_onchange script
  # and asks again on the next apply. Answering N exits 0: chezmoi records the
  # skip and asks again only when this script's rendered content changes.
  if ! (: </dev/tty) 2>/dev/null; then
    echo "No TTY to confirm \"$prompt\"; rerun chezmoi apply from a terminal." >&2
    exit 1
  fi

  read -r -p "$prompt [y/N] " reply </dev/tty

  case "${reply,,}" in
  y | yes) ;;
  *)
    echo "Skipped: $prompt"
    exit 0
    ;;
  esac
}

confirm
