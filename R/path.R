#' @title Path helpers
#' @description Helper functions related to system paths for files/directories. 
#' @param path A character string defining the file/directory path.
#'
#' @details 
#' * [`path_repair()`] identifies whether or not a file or directory path is valid and, if not, determines the valid portion of the path. This function is designed to facilitate quick identification of the valid/invalid components of manually specified paths (i.e., the point in the string at which the path becomes invalid).
#'
#' @return The function returns a character string. If `path`, as inputted, is valid, it is returned unchanged. If `path` is invalid, the portion of the path that is valid is returned.
#'
#' @example man/examples/example-path.R
#' 
#' @author Edward Lavender
#' @name path

#' @rdname path
#' @export

path_repair <- function(path) {
  valid <- any(dir.exists(path) | file.exists(path))
  if (valid) {
    cat("`path` as inputted is valid. Full `path` returned.\n")
  } else {
    cat("`path` as inputted is not valid. Valid portion of `path` returned.\n")
  }
  while (!valid && path != ".") {
    path <- dirname(path)
    valid <- dir.exists(path)
  }
  path
}