# Test file with conflict markers

This file contains merge conflict markers that should cause the check to fail.

<<<<<<< HEAD
This is the version from HEAD
=======
This is the version from the merge branch
>>>>>>> feature-branch

The above conflict markers should be detected and fail the check.
