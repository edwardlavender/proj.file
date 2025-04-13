# Set up example
temp <- tempdir()
sink <- file.path(temp, "proj.file")
dir.create(sink, recursive = TRUE)
write.table("", file = file.path(sink, "1.csv"))
write.table("", file = file.path(sink, "2.csv"))

# Use `file_size()` to summarise file sizes
dir_size(temp, "proj.file")
dir_size(temp, "proj.file", .unit = "GB")
dir_size(temp, "proj.file", .unit = "TB")

# Use `dir_cleanup()` to cleanup directories
dir_cleanup(sink)
stopifnot(isFALSE(dir.exists(sink)))