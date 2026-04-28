#!/usr/bin/env python3
"""Save an approved Markdown note to disk using a slugified title."""

from __future__ import annotations

import argparse
import pathlib
import re
import sys
import unicodedata
from urllib.parse import urlparse


def slugify(value: str) -> str:
    normalized = unicodedata.normalize("NFKD", value)
    ascii_only = normalized.encode("ascii", "ignore").decode("ascii")
    lowered = ascii_only.lower()
    cleaned = re.sub(r"[^a-z0-9\s-]", "", lowered)
    compact = re.sub(r"[-\s]+", "-", cleaned).strip("-")
    return compact or "nota"


def extract_title(markdown: str) -> str:
    for line in markdown.splitlines():
        stripped = line.strip()
        if stripped.startswith("# "):
            return stripped[2:].strip()
    raise SystemExit("Could not find a Markdown H1 title in note content.")


def extract_source(markdown: str) -> str | None:
    lines = markdown.splitlines()
    for index, line in enumerate(lines):
        if line.strip().lower() == "## fonte":
            for candidate in lines[index + 1 :]:
                stripped = candidate.strip()
                if stripped:
                    return stripped
            return None
    return None


def filename_from_source(source: str | None) -> str | None:
    if not source or source.upper() == "N/A":
        return None

    parsed = urlparse(source)
    if not parsed.scheme or not parsed.netloc:
        return None

    parts = [part for part in parsed.path.split("/") if part]
    if not parts:
        return None

    return slugify(parts[-1]) or None


def main() -> int:
    parser = argparse.ArgumentParser(description="Save an approved knowledge note.")
    parser.add_argument("--dir", required=True, help="Target directory for the note")
    parser.add_argument(
        "--title",
        help="Optional explicit title. If omitted, extract it from the Markdown H1.",
    )
    parser.add_argument(
        "--input",
        help="Optional path to a Markdown file. If omitted, read from stdin.",
    )
    args = parser.parse_args()

    if args.input:
        markdown = pathlib.Path(args.input).read_text(encoding="utf-8")
    else:
        markdown = sys.stdin.read()

    if not markdown.strip():
        raise SystemExit("Note content is empty.")

    title = args.title or extract_title(markdown)
    source = extract_source(markdown)
    basename = filename_from_source(source) or slugify(title)
    filename = f"{basename}.md"

    target_dir = pathlib.Path(args.dir)
    target_dir.mkdir(parents=True, exist_ok=True)
    target_path = target_dir / filename
    target_path.write_text(markdown.rstrip() + "\n", encoding="utf-8")

    print(target_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
