#!/usr/bin/env python3
"""Local check: every skills/<slug>/SKILL.md starts with parseable YAML frontmatter."""

from __future__ import annotations

import pathlib
import re
import sys

try:
    import yaml  # type: ignore
except ImportError:
    print("skills/check-frontmatter.py: FAIL")
    print("  ❌ PyYAML is required. Install it with: python3 -m pip install pyyaml")
    sys.exit(1)

ROOT = pathlib.Path(__file__).resolve().parent
NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
STRING_FIELDS = ("name", "description")


def parse_frontmatter(text: str) -> dict[str, object]:
    if text.startswith("\ufeff"):
        text = text[1:]
    if not text.startswith("---"):
        raise ValueError("file does not start with YAML frontmatter (---)")
    rest = text[3:]
    if rest.startswith("\r\n"):
        rest = rest[2:]
    elif rest.startswith("\n"):
        rest = rest[1:]
    else:
        raise ValueError("opening --- is not followed by a newline")

    end = None
    raw = ""
    for marker in ("\n---\n", "\n---\r\n", "\r\n---\r\n", "\r\n---\n"):
        idx = rest.find(marker)
        if idx != -1:
            raw = rest[:idx]
            end = idx
            break
    if end is None:
        raise ValueError("closing --- not found")

    data = yaml.safe_load(raw)
    if not isinstance(data, dict):
        raise ValueError("frontmatter did not parse as a mapping")

    out: dict[str, object] = {}
    for key, value in data.items():
        key_s = key if isinstance(key, str) else str(key)
        if value is None:
            raise ValueError(f"frontmatter key {key_s!r} is empty")
        if key_s in STRING_FIELDS and not isinstance(value, str):
            raise ValueError(
                f"frontmatter key {key_s!r} must be a string, got {type(value).__name__}"
            )
        out[key_s] = value
    return out


def main() -> int:
    skills = sorted(p for p in ROOT.iterdir() if p.is_dir())
    errors: list[str] = []
    checked = 0

    for folder in skills:
        path = folder / "SKILL.md"
        if not path.is_file():
            errors.append(f"{folder.name}/: missing SKILL.md")
            continue
        checked += 1
        slug = folder.name
        try:
            text = path.read_text(encoding="utf-8")
            fm = parse_frontmatter(text)
        except Exception as exc:  # noqa: BLE001 — report parse failures as check errors
            errors.append(f"{path.relative_to(ROOT.parent)}: {exc}")
            continue
        if "name" not in fm:
            errors.append(f"{path.relative_to(ROOT.parent)}: missing name")
        else:
            name_val = fm["name"]
            if not isinstance(name_val, str):
                errors.append(
                    f"{path.relative_to(ROOT.parent)}: name must be a string, "
                    f"got {type(name_val).__name__}"
                )
            else:
                name = name_val.strip()
                if name != slug:
                    errors.append(
                        f"{path.relative_to(ROOT.parent)}: name {name!r} does not match folder {slug!r}"
                    )
                elif not NAME_RE.match(name):
                    errors.append(f"{path.relative_to(ROOT.parent)}: name {name!r} is not a slug")
        if "description" not in fm:
            errors.append(f"{path.relative_to(ROOT.parent)}: missing description")
        else:
            desc_val = fm["description"]
            if not isinstance(desc_val, str):
                errors.append(
                    f"{path.relative_to(ROOT.parent)}: description must be a string, "
                    f"got {type(desc_val).__name__}"
                )
            elif not desc_val.strip():
                errors.append(f"{path.relative_to(ROOT.parent)}: missing description")

    if checked < 1:
        errors.append(f"expected at least 1 SKILL.md file, found {checked}")

    if errors:
        print("skills/check-frontmatter.py: FAIL")
        for err in errors:
            print(f"  ❌ {err}")
        return 1

    print(f"skills/check-frontmatter.py: PASS ({checked} SKILL.md files, YAML frontmatter clean)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
