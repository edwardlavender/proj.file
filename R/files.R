#' @title File helpers: file vectors
#' @description These are simple file helpers for dealing with multiple files. 
#' @param .sink,.folder Character strings that specify the directory and sub-folder within which to list files.
#' @param ...,pattern,recursive Arguments passed to [`list.files()`].
#' @details 
#' * [`files_source`] sources files.
#' * [`files_source_r()`] sources `R` scripts.
#' * [`files_list_numbered_types()`] creates an ordered `list` of numbered files. This function expects files to be named `1.{.ext}`, `2.{.ext}`, ..., `N.{.ext}`. All listed files must share the same file extension.
#' 
#' @example man/examples/example-files.R
#' @author Edward Lavender
#' @name files
NULL

#' @rdname files
#' @export

files_source <- function(.sink, .folder = NULL, 
                         recursive = TRUE, ...) {
  if (!is.null(.folder)) {
    .sink <- file.path(.sink, .folder)
  }
  files <- list.files(.sink, full.names = TRUE, 
                      pattern = "\\.R$", recursive = recursive, ...)
  if (length(files) > 0L) {
    lapply(files, source)
  }
  invisible(TRUE)
}

#' @rdname files
#' @export

files_source_r <- function(.sink = here_src(), .folder = NULL, 
                           pattern = "\\.R$", recursive = TRUE, ...) {
  if (!is.null(.folder)) {
    .sink <- file.path(.sink, .folder)
  }
  files <- list.files(.sink, full.names = TRUE, 
                      pattern = pattern, recursive = recursive, ...)
  if (length(files) > 0L) {
    lapply(files, source)
  }
  invisible(TRUE)
}

#' @rdname files
#' @export

files_list_numbered_types <- function(.sink, .folder = NULL, ...) {
  
  #### List files & validate
  # check_dots_used:  list.files() used
  check_dots_allowed("full.names", ...)
  check_dots_for_missing_period(formals(), list(...))
  .sink <- file_path_validated(.sink, .folder)
  files <- list.files(.sink, full.names = TRUE, ...)
  if (length(files) == 0L) {
    abort("No files identified in `.sink`.")
  }
  exts  <- tools::file_ext(files)
  ext   <- exts[1]
  if (length(unique(exts)) != 1L) {
    abort("Multiple file types (extensions) identified in `.sink`. Do you need to pass `pattern` to `list.files()`?")
  }
  
  #### Define ordered vector of files
  # Define file names
  names   <- as.integer(tools::file_path_sans_ext(basename(files)))
  # Check file names are integers (1, 2, etc.) by coercion
  if (any(is.na(names))) {
    abort("File names should be '1.{{extension}}', '2.{{extension}}', ..., 'N.{{extension}}'.")
  }
  # Order file paths by number
  out <-
    data.table(file = files,
               name = names,
               ext = exts) |>
    lazy_dt(immutable = TRUE) |>
    mutate(name = as.integer(.data$name)) |>
    arrange(.data$name) |>
    as.data.table()
  # Validate ordered list (e.g., to check there are no gaps)
  if (!isTRUE(all.equal(paste0(seq_len(nrow(out)), ".", ext),
                        basename(out$file)))) {
    abort("File names should be '1.{ext}', '2.{ext}', etc.",
          .envir = environment())
  }
  out$file
}
