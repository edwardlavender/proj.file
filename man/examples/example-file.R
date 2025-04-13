# Set up example
temp <- tempdir()
sink <- file.path(temp, "proj.file")
dir.create(sink, recursive = TRUE)
write.table("", file = file.path(sink, "1.csv"))
write.table("", file = file.path(sink, "2.csv"))

# Use `file_path_validated()` to construct & validate file paths
file_path_validated(temp, "proj.file")

dir_cleanup(sink)
