test_that("files_*() functions work", {
  
  con <- file.path(tempdir(), "tmp")
  dir.create(con)
  
  # files_list_numbered_types() lists files
  files_list_numbered_types(con) |>
    expect_error("No files identified in `.sink`.")
  file.create(file.path(con, "1.txt"))
  file.create(file.path(con, "2.txt"))
  expect_equal(basename(files_list_numbered_types(con)),
               c("1.txt", "2.txt"))
  expect_equal(files_list_numbered_types(con),
               files_list_numbered_types(tempdir(), .folder = "tmp"))
  csv <- file.path(con, "1.csv")
  file.create(csv)
  files_list_numbered_types(con) |>
    expect_error("Multiple file types (extensions) identified in `.sink`. Do you need to pass `pattern` to `list.files()`?", fixed = TRUE)
  file.remove(csv)
  blah <- file.path(con, "blah.txt")
  file.create(blah)
  files_list_numbered_types(con) |>
    suppressWarnings() |>
    expect_error("File names should be '1.{extension}', '2.{extension}', ..., 'N.{extension}'.", fixed = TRUE)
  unlink(blah)
  unlink(file.path(con, "2.txt"))
  file.create(file.path(con, "3.txt"))
  files_list_numbered_types(con) |>
    expect_error("File names should be '1.txt', '2.txt', etc.", fixed = TRUE)

  dir_cleanup(con)
  
  
  # dir_size() calculates file sizes
  con <- system.file(package = "proj.file")
  mb <- dir_size(con, recursive = TRUE)
  gb <- dir_size(con, recursive = TRUE, .unit = "GB")
  tb <- dir_size(con, recursive = TRUE, .unit = "TB")
  mb_true <-
    con |>
    list.files(recursive = TRUE, full.names = TRUE) |>
    file.size() |>
    sum() / 1e6
  expect_equal(mb, mb_true)
  expect_equal(gb, mb_true / 1e3)
  expect_equal(tb, mb_true / 1e6)
  
})