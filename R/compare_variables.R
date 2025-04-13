#' compare_variables
#'
#' @param script1 
#' @param script2 
#'
#' @returns a vector of numericals corresponding to points assigned to each variable (1 each if no weights given)
#' @export
compare_variables <- function(script1, script2, variables_to_compare, variable_weights) {
  env1 <- source_script_into_env(script1)
  env2 <- source_script_into_env(script2)
  
  vars1 <- ls(env1)
  vars2 <- ls(env2)
  
  if(missing(variables_to_compare)) {
    variables_to_compare <- intersect(vars1, vars2)
  } # TODO: check names exist
  
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
      return(variable_weights[var])
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
  eval(parse(text = lines), envir = env)
  return(env)
}

normalize_df <- function(df) {
  df <- as.data.frame(df)           # Convert to data frame to remove tibble class
  row.names(df) <- NULL             # Remove row names for comparison
  return(df)
}

