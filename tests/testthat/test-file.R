test_that("file_*() functions work", {

  # file_path_validated() returns the path, if valid
  con <- tempdir()
  expect_equal(file_path_validated(con), con)

  # as above
  con <- file.path(tempdir(), "tmp")
  dir.create(con)
  expect_equal(file_path_validated(con), con)

  # file_path_validated() returns an error otherwise
  file_path_validated(file.path(tempdir(), "blah")) |>
    expect_error("Path doesn't exist.", fixed = TRUE)
  
  # dir_cleanup() removes directories
  dir_cleanup(con)
  expect_false(dir.exists(con))
})