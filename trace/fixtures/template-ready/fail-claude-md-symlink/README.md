# Template-ready fail fixture: dangling CLAUDE.md symlink

README is clean. trace/test-fixtures.sh copies this directory to a temp dir
and adds a dangling CLAUDE.md symlink there, which must be rejected, not
skipped. The symlink is never tracked: tracked unreadable paths abort
scripts/check-denylist.py.
