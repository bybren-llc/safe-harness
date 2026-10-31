# Template-ready fail fixture: denylist term starting with dash

This fixture has a denylist term starting with `-`, and that term
appears in templates/harness.yml, so it should fail.
The check must use `grep -F -e` or `--` to handle terms starting with `-`.
