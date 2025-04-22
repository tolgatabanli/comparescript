#' env_from_script
#'
#' @param path_to_script 
#'
#' @returns An environment consisting of variables created from evaluation of
#' the script provided
#' @export
#'
#' @examples
env_from_script <- function(path_to_script) {
  lines <- readLines(path_to_script)
  
  # Remove installs
  disabled_calls <- c("install.packages", "BiocManager::install", "drive_auth", "drive_download")
  patterns_to_disable <- paste0("^\\s*", gsub("\\.", "\\\\.", disabled_calls), "\\s*\\(")
  
  for (pattern in patterns_to_disable) {
    lines <- gsub(pattern, "# \\0", lines, perl = TRUE)
  }
  
  env <- new.env()
  eval_quiet(lines, envir = env)
  return(env)
}

# HELPERS ---

eval_quiet <- function(code_lines, envir) {
  suppressMessages(
    suppressWarnings(
      invisible(
        capture.output(
          eval(parse(text = code_lines), envir = envir),
          type = "output"
        )
      )
    )
  )
}