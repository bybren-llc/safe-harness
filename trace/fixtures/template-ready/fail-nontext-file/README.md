# Template-ready fail fixture: non-text file with denied term

This fixture has a denylist with example-owner, and that term
appears in an SVG file in templates/, so it should fail.
The check must scan binary/non-text files with grep -a.
