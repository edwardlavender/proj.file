# Set up example
temp <- tempdir()
sink <- file.path(temp, "proj.file")
dir.create(sink, recursive = TRUE)
write.table("", file = file.path(sink, "1.csv"))
write.table("", file = file.path(sink, "2.csv"))

# Use `file_list_numbered_types()` to list files
files_list_numbered_types(temp, "proj.file", pattern = "*.csv$")

dir_cleanup(sink)
