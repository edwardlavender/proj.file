#### Example (1): Valid paths are returned unchanged
path_repair(tempdir())
file.create(file.path(tempdir(), "tmp.txt"))
path_repair(file.path(tempdir(), "tmp.txt"))

#### Example (2): If `path` is invalid, the valid portion of the path is returned
# Path broken at the 'top level'
path_repair("temp")
# Path broken after tempdir()
path_repair(file.path(tempdir(), "temp"))

#### Example (3): Examples with longer directories and files
# Generate new directory
dir.create(file.path(tempdir(), "temporary"), showWarnings = FALSE)
# Path broken after temporary/
path_repair(file.path(tempdir(), "temporary", "tmp2"))
# Create new file
file.create(file.path(tempdir(), "temporary", "file.txt"))
# File path is returned unchanged:
path_repair(file.path(tempdir(), "temporary", "file.txt"))
# Incorrectly specified path is broken after temporary/
path_repair(file.path(tempdir(), "temporary", "blah.txt"))