#' compare_variables
#'
#' @param script1 A path to a script (reference)
#' @param script2 A path to another script (to test)
#'
#' @returns A vector of numericals corresponding to points assigned to each variable (1 each if no weights given)
#' @examples
#'   compare_variables("reference.R", "student_assignment.R")
#'   compare_variables("reference.R", "student_assignment.R", c("var1, var2"), c(2, 1))
#' @export
compare_variables <- function(script1, script2, variables_to_compare, variable_weights) {
  env1 <- source_script_into_env(script1)
  env2 <- source_script_into_env(script2)
  
  vars1 <- ls(env1)
  vars2 <- ls(env2)
  
  if(missing(variables_to_compare)) {
    variables_to_compare <- intersect(vars1, vars2)
  } else if(!all(variables_to_compare %in% vars1) || !all(variables_to_compare %in% vars1)) {
    stop("Given variables should exist in both scripts.")
  }
  
  if(missing(variable_weights)) {
    variable_weights <- rep(1, length(variables_to_compare))
  } # TODO: check lengths are same
  
  names(variable_weights) <- variables_to_compare
  
  comparison_results <- sapply(variables_to_compare,
                               function(var) {
    var1_value <- get(var, envir = env1)
    var2_value <- get(var, envir = env2)
    
    # If like data frame, cast as df and remove row names
    if (inherits(var1_value, "data.frame") || inherits(var1_value, "tbl_df")){
      var1_value <- normalize_df(var1_value)
      var2_value <- normalize_df(var2_value)
    }
    
    if (identical(var1_value, var2_value)) {
      unname(variable_weights[var])
    } else {
      0
    }
  })
  return(comparison_results)
}


# HELPERS ---

source_script_into_env <- function(path_to_script) {
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

normalize_df <- function(df) {
  df <- as.data.frame(df)           # Convert to data frame to remove tibble class
  row.names(df) <- NULL             # Remove row names for comparison
  return(df)
}

