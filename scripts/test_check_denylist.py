#!/usr/bin/env python3
"""Local tests for check-denylist.py. Fake terms only."""

from __future__ import annotations

import importlib.util
import io
import os
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


def _capture_run(path: Path, **kwargs: object) -> tuple[int, str, str]:
    stdout = io.StringIO()
    stderr = io.StringIO()
    with unittest.mock.patch("sys.stdout", stdout), unittest.mock.patch("sys.stderr", stderr):
        code = cd.run(local_path=path, **kwargs)
    return code, stdout.getvalue(), stderr.getvalue()


class LoadTermsTests(unittest.TestCase):
    def _write(self, directory: str, text: str) -> Path:
        path = Path(directory) / "denylist.local"
        path.write_text(text, encoding="utf-8")
        return path

    def test_empty_file_has_no_terms(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(cd.load_terms(self._write(tmp, "")), [])

    def test_comments_only_has_no_terms(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = self._write(tmp, "# comment only\n\n# another\n")
            self.assertEqual(cd.load_terms(path), [])

    def test_unknown_category_is_error_with_line_number_only(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = self._write(tmp, f"# header\n{FAKE_TERM}\t{UNKNOWN_LABEL}\n")
            with self.assertRaises(cd.UnknownCategoryError) as raised:
                cd.load_terms(path)
            self.assertEqual(raised.exception.line_numbers, [2])

    def test_known_category_and_default(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = self._write(tmp, f"{FAKE_TERM}\thardware-hostname\nexample-volume\n")
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
        with tempfile.TemporaryDirectory() as tmp:
            missing = Path(tmp) / "absent.local"
            code, out, err = _capture_run(missing)
            self.assertEqual(code, 0)
            self.assertEqual(out, "no local denylist, skipped\n")
            self.assertEqual(err, "")
            self.assertFalse(missing.exists())

    def test_directory_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.mkdir()
            code, _out, err = _capture_run(path)
            self.assertEqual(code, 2)
            self.assertIn("is not a readable regular file", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_broken_symlink_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.symlink_to(Path(tmp) / "missing-target")
            code, _out, err = _capture_run(path)
            self.assertEqual(code, 2)
            self.assertIn("is not a readable regular file", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_empty_file_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.write_text("# comments only\n\n", encoding="utf-8")
            code, _out, err = _capture_run(path)
            self.assertEqual(code, 2)
            self.assertIn("has no active terms", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_unknown_category_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.write_text(f"{FAKE_TERM}\t{UNKNOWN_LABEL}\n", encoding="utf-8")
            code, _out, err = _capture_run(path)
            self.assertEqual(code, 2)
            self.assertIn(f"{path.name}:1: unknown category", err)
            self.assertNotIn(UNKNOWN_LABEL, err)
            self.assertNotIn(FAKE_TERM, err)

    def test_unreadable_denylist_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.write_text(f"{FAKE_TERM}\thardware-hostname\n", encoding="utf-8")
            path.chmod(0)
            try:
                if os.access(path, os.R_OK):
                    self.skipTest("process can still read a chmod-0 file")
                code, _out, err = _capture_run(path)
            finally:
                path.chmod(0o644)
            self.assertEqual(code, 2)
            self.assertIn("cannot be read", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_undecodable_denylist_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.write_bytes(b"\xff\xfe")
            code, _out, err = _capture_run(path)
            self.assertEqual(code, 2)
            self.assertIn("is not valid UTF-8", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_undecodable_tracked_file_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            local = root / "denylist.local"
            local.write_text(f"{FAKE_TERM}\thardware-hostname\n", encoding="utf-8")
            tracked = root / "tracked.bin"
            tracked.write_bytes(b"\xff\xfe")
            code, _out, err = _capture_run(
                local,
                repo_root=root,
                list_files=lambda: ["tracked.bin"],
            )
            self.assertEqual(code, 2)
            self.assertIn("is not valid UTF-8", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_unreadable_tracked_file_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            local = root / "denylist.local"
            local.write_text(f"{FAKE_TERM}\thardware-hostname\n", encoding="utf-8")
            tracked = root / "tracked.txt"
            tracked.write_text("ok\n", encoding="utf-8")
            tracked.chmod(0)
            try:
                if os.access(tracked, os.R_OK):
                    self.skipTest("process can still read a chmod-0 file")
                code, _out, err = _capture_run(
                    local,
                    repo_root=root,
                    list_files=lambda: ["tracked.txt"],
                )
            finally:
                tracked.chmod(0o644)
            self.assertEqual(code, 2)
            self.assertIn("cannot be read", err)
            self.assertNotIn(FAKE_TERM, err)

    def test_tracked_listing_failure_is_config_error(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "denylist.local"
            path.write_text(f"{FAKE_TERM}\thardware-hostname\n", encoding="utf-8")

            def boom() -> list[str]:
                raise cd.ConfigError("ERROR: cannot list tracked files")

            code, _out, err = _capture_run(path, list_files=boom)
            self.assertEqual(code, 2)
            self.assertIn("cannot list tracked files", err)
            self.assertNotIn(FAKE_TERM, err)


if __name__ == "__main__":
    unittest.main()
