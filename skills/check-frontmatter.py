#!/usr/bin/env python3
"""Local check: every skills/<slug>/SKILL.md starts with parseable YAML frontmatter."""

from __future__ import annotations

import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent
NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")


def parse_frontmatter(text: str) -> dict[str, str]:
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
    for marker in ("\n---\n", "\n---\r\n", "\r\n---\r\n", "\r\n---\n"):
        idx = rest.find(marker)
        if idx != -1:
            raw = rest[:idx]
            end = idx
            break
    if end is None:
        raise ValueError("closing --- not found")

    try:
        import yaml  # type: ignore
    except ImportError:
        yaml = None

    if yaml is not None:
        data = yaml.safe_load(raw)
        if not isinstance(data, dict):
            raise ValueError("frontmatter did not parse as a mapping")
        out = {str(k): data[k] for k in data}
        for key, value in out.items():
            if value is None:
                raise ValueError(f"frontmatter key {key!r} is empty")
            if not isinstance(value, str):
                out[key] = str(value)
        return out

    data: dict[str, str] = {}
    for line in raw.splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if ":" not in line:
            raise ValueError(f"unparseable frontmatter line: {line!r}")
        key, value = line.split(":", 1)
        key = key.strip()
        value = value.strip()
        if not key:
            raise ValueError(f"empty frontmatter key in {line!r}")
        if not value:
            raise ValueError(f"empty frontmatter value for {key!r}")
        data[key] = value
    return data


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
        name = str(fm.get("name", "")).strip()
        description = str(fm.get("description", "")).strip()
        if "name" not in fm:
            errors.append(f"{path.relative_to(ROOT.parent)}: missing name")
        elif name != slug:
            errors.append(
                f"{path.relative_to(ROOT.parent)}: name {name!r} does not match folder {slug!r}"
            )
        elif not NAME_RE.match(name):
            errors.append(f"{path.relative_to(ROOT.parent)}: name {name!r} is not a slug")
        if "description" not in fm or not description:
            errors.append(f"{path.relative_to(ROOT.parent)}: missing description")

    if checked != 38:
        errors.append(f"expected 38 SKILL.md files, found {checked}")

    if errors:
        print("skills/check-frontmatter.py: FAIL")
        for err in errors:
            print(f"  ❌ {err}")
        return 1

    print(f"skills/check-frontmatter.py: PASS ({checked} SKILL.md files, YAML frontmatter clean)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
