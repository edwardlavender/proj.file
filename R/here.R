#' @title Directory helpers: paths
#' @description These functions are simple wrappers for [`here::here()`] for standard RStudio Project directories.
#' @param ... Character vectors (see [`here::here()`]).
#' @return The functions return a file path.
#' @example man/examples/example-heres.R
#' @author Edward Lavender
#' @name heres

#' @rdname heres
#' @export

here_data_raw <- function(...) here::here("data-raw", ...)

#' @rdname heres
#' @export

here_data <- function(...) here::here("data", ...)

#' @rdname heres
#' @export

here_r <- function(...) here::here("R", ...)

#' @rdname heres
#' @export

here_src <- function(...) here::here("src", ...)

#' @rdname heres
#' @export

here_dev <- function(...) here::here("dev", ...)

#' @rdname heres
#' @export

here_fig <- function(...) here::here("fig", ...)

#' @rdname heres
#' @export

here_doc <- function(...) here::here("doc", ...)