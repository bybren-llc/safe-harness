#!/usr/bin/env python3
"""Local tests for check-denylist.py. Fake terms only."""

from __future__ import annotations

import importlib.util
import io
import tempfile
import unittest
import unittest.mock
from pathlib import Path

_SPEC = importlib.util.spec_from_file_location(
    "check_denylist",
    Path(__file__).resolve().parent / "check-denylist.py",
)
assert _SPEC is not None and _SPEC.loader is not None
cd = importlib.util.module_from_spec(_SPEC)
_SPEC.loader.exec_module(cd)

FAKE_TERM = "example-host-01"
FAKE_TERM_FOLDED = "Example-Host-01"
UNKNOWN_LABEL = "not-a-known-label"


class LoadTermsTests(unittest.TestCase):
    def _write(self, text: str) -> Path:
        handle = tempfile.NamedTemporaryFile("w", encoding="utf-8", delete=False)
        handle.write(text)
        handle.close()
        return Path(handle.name)

    def test_empty_file_has_no_terms(self) -> None:
        path = self._write("")
        self.assertEqual(cd.load_terms(path), [])

    def test_comments_only_has_no_terms(self) -> None:
        path = self._write("# comment only\n\n# another\n")
        self.assertEqual(cd.load_terms(path), [])

    def test_unknown_category_is_error_with_line_number_only(self) -> None:
        path = self._write(
            f"# header\n{FAKE_TERM}\t{UNKNOWN_LABEL}\n"
        )
        with self.assertRaises(cd.UnknownCategoryError) as raised:
            cd.load_terms(path)
        self.assertEqual(raised.exception.line_numbers, [2])

    def test_known_category_and_default(self) -> None:
        path = self._write(f"{FAKE_TERM}\thardware-hostname\nexample-volume\n")
        terms = cd.load_terms(path)
        self.assertEqual(
            terms,
            [
                (FAKE_TERM.casefold(), "hardware-hostname"),
                ("example-volume".casefold(), "denied-term"),
            ],
        )


class ScanCasefoldTests(unittest.TestCase):
    def test_casefold_match(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            rel = "haystack.txt"
            (root / rel).write_text(f"prefix {FAKE_TERM_FOLDED} suffix\n", encoding="utf-8")
            hits = cd.scan_file(rel, [(FAKE_TERM.casefold(), "hardware-hostname")], root=root)
            self.assertEqual(hits, [(1, "hardware-hostname")])


class RunConfigTests(unittest.TestCase):
    def test_missing_file_skips(self) -> None:
        missing = Path(tempfile.gettempdir()) / "denylist-missing-example.local"
        if missing.exists():
            missing.unlink()
        stdout = io.StringIO()
        with unittest.mock.patch("sys.stdout", stdout):
            code = cd.run(local_path=missing)
        self.assertEqual(code, 0)
        self.assertEqual(stdout.getvalue(), "no local denylist, skipped\n")

    def test_empty_file_is_config_error(self) -> None:
        handle = tempfile.NamedTemporaryFile("w", encoding="utf-8", delete=False)
        handle.write("# comments only\n\n")
        handle.close()
        path = Path(handle.name)
        stderr = io.StringIO()
        with unittest.mock.patch("sys.stderr", stderr):
            code = cd.run(local_path=path)
        self.assertEqual(code, 2)
        err = stderr.getvalue()
        self.assertIn("has no active terms", err)
        self.assertNotIn(FAKE_TERM, err)

    def test_unknown_category_is_config_error(self) -> None:
        handle = tempfile.NamedTemporaryFile("w", encoding="utf-8", delete=False)
        handle.write(f"{FAKE_TERM}\t{UNKNOWN_LABEL}\n")
        handle.close()
        path = Path(handle.name)
        stderr = io.StringIO()
        with unittest.mock.patch("sys.stderr", stderr):
            code = cd.run(local_path=path)
        self.assertEqual(code, 2)
        err = stderr.getvalue()
        self.assertIn(f"{path.name}:1: unknown category", err)
        self.assertNotIn(UNKNOWN_LABEL, err)
        self.assertNotIn(FAKE_TERM, err)


if __name__ == "__main__":
    unittest.main()
