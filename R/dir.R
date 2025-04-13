#' @title Directory helpers: individual directories
#' @description These are simple directory helpers. 
#'
#' @param .sink A `character` string that defines the directory in which files are located.
#' @param .folder (optional) A `character` string that defines the name of a sub-folder for which to list files (via [`files_list_numbered_types()`]) or summarise file sizes (via [`dir_size()`]).
#' @param ... is a placeholder for additional arguments passed to [`list.files()`], such as `pattern`, excluding `full.names`.
#' @param .unit For [`dir_size()`], `.unit` is a `character` string that defines the units of the output (`MB`, `GB`, `TB`).
#'
#' @details
#' * [`dir_size()`] calculates the total size of files in a directory.
#' * [`dir_cleanup()`] deletes temporary files and or directories recursively;
#' 
#' @return
#' * [`dir_size()`] returns a `double`;
#' * [`dir_cleanup()`] returns `invisible(NULL)`
#'
#' @example man/examples/example-dir.R
#' @author Edward Lavender
#' @name dir

#' @rdname dir
#' @export

dir_size <- function(.sink,
                      .folder = NULL, ...,
                      .unit = c("MB", "GB", "TB")) {
  # Check inputs
  # check_dots_used:  list.files() used
  check_dots_allowed("full.names", ...)
  check_dots_for_missing_period(formals(), list(...))
  # Get units
  .unit <- match.arg(.unit)
  # Define size in MB
  .sink <- file_path_validated(.sink, .folder)
  size <-
    .sink |>
    list.files(..., full.names = TRUE) |>
    unlist() |>
    file.size() |>
    sum() / 1e6
  # Convert size as requested
  if (.unit == "GB") {
    size <- size / 1e3
  }
  if (.unit == "TB") {
    size <- size / 1e6
  }
  size
}

#' @rdname dir
#' @export

dir_cleanup <- function(.sink) {
  unlink(.sink, recursive = TRUE)
  nothing()
}
