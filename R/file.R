#' @title File helpers: individual files
#' @description These are simple file helpers.
#'
#' @param ... `character` vectors passed to [`file.path()`].
#'
#' @details
#' * [`file_path_validated()`] is a simple wrapper for [`file.path()`] constructs a file path and verifies that it exists.
#'
#' @return
#' * [`file_path_validated()`] returns a `character` string that defines the file path.
#'
#' @example man/examples/example-file.R
#' @author Edward Lavender
#' @name file

#' @rdname file
#' @export

file_path_validated <- function(...) {
  .sink <- do.call(file.path, list_compact(list(...)))
  if (!dir.exists(.sink) | !file.exists(.sink)) {
    abort("Path doesn't exist.")
  }
  .sink
}

