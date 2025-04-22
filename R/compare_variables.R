#' compare_variables
#'
#' @param reference A path to a script (reference)
#' @param student A path to another script (to test)
#' @param variables_to_compare Optional, selected variables to compare
#' @param variable_weights Weights to assess the variables. 1 point by default for each variable.
#' @param return_expected If a summary table with expected and actual scores should be returned. (See Value)
#'
#' @returns
#'  If `return_expected = FALSE` A list of numerics corresponding to points assigned to each variable (1 each if no weights given).
#'  If `return_expected = TRUE` A data frame with colnames "student", "expected" and "score";
 # complex data structures are wrapped in lists to enable easy referencing, hence they might lose data.frame class.
#' 
#' @examples
#'   compare_variables("reference.R", "student_assignment.R")
#'   compare_variables("reference.R", "student_assignment.R", c("var1, var2"), c(2, 1))
#' @export
compare_variables <- function(reference, student, variables_to_compare, variable_weights,
                              ..., return_expected = FALSE) {
  wrapr::stop_if_dot_args(substitute(list(...)), "compare_variables, dot args")
  
  # Check type of reference and student
  if(is.character(reference)) {
    ref_env <- env_from_script(reference)
  } else if(is.environment(reference)) {
    ref_env <- reference
  } else {
    stop("Reference should be either a string showing to an R script,
         or an environment.")
  }
  if(is.character(student)) {
    student_env <- env_from_script(student)
  } else {
    stop("Student should be a string showing to an R script.")
  }
  
  vars_ref <- ls(ref_env)
  vars_student <- ls(student_env)
  
  if(missing(variables_to_compare)) {
    variables_to_compare <- intersect(vars_ref, vars_student)
  } else if(!all(variables_to_compare %in% vars_ref)) {
    stop("Given variables should exist in reference.")
  }
  
  if(missing(variable_weights)) {
    variable_weights <- rep(1, length(variables_to_compare))
  } else if(length(variable_weights) != length(variables_to_compare)) {
    stop("Number of variables and weights are not equal!")
  } else if (0 %in% variable_weights) {
    warning("There is a zero point assigned.")
  }
  
  names(variable_weights) <- variables_to_compare
  
  comparison_results <- lapply(variables_to_compare,
                               function(var) {
    ref_val <- rlang::env_get(ref_env, var)
    student_val <- rlang::env_get(student_env, var, default = NULL)
    
    # If like data frame, cast as df and remove row names
    if (inherits(ref_val, "data.frame")){
      ref_val <- normalize_df(ref_val)
      student_val <- normalize_df(student_val)
    }
    
    if (identical(ref_val, student_val)) {
      if (return_expected) {
        list(student = student_val, expected = ref_val, score = unname(variable_weights[var]))
      } else {
        unname(variable_weights[var])
      }
    } else {
      if (return_expected) {
        list(student = student_val, expected = ref_val, score = 0)
      } else {
        0
      }
    }
  })
  if (return_expected) {# cols as student, expected, score
    df <- data.frame()
    comparison_results <- purrr::reduce(comparison_results, rbind, .init = df)
    rownames(comparison_results) <- variables_to_compare
  } else {
    names(comparison_results) <- variables_to_compare
  }
  return(comparison_results)
}


# strips off rownames and wraps in a list for easy reference
normalize_df <- function(df) {
  df <- as.data.frame(df) # remove tibble and similar
  row.names(df) <- NULL
  return(list(df))
}

