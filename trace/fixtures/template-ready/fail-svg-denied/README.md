# Template-ready fail fixture: non-text file with denied term

This fixture has a denylist term that appears only in an SVG file
in templates/, so it should fail. The check must scan binary and
non-text files with grep -a, not just files the `file` command
classifies as text.
