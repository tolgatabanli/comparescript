test_that("A fully correct assignment assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_correct.R")),
               as.list(rep(1, 9)))
})

test_that("An assignment with mistakes assessed correctly with respective vars", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_with_mistakes.R")),
               as.list(c(0, 1, 1, 1, 1, 1, 0, 1, 1)))
})

test_that("A fully wrong assignment (except data-reading and example manual_tbl) assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_wrong.R")),
               as.list(c(0, 1, rep(0, 5), 1, 0)))
})

# Weights and names given
test_that("A fully correct assignment assessed correctly with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_correct.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               as.list(c(2, 1, 2)))
})

test_that("An assignment with mistakes assessed correctly with respective vars with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_with_mistakes.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               as.list(c(2, 1, 0)))
})

test_that("A fully wrong assignment (except data-reading and example manual_tbl) assessed correctly with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_wrong.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               as.list(c(0, 0, 0)))
})

# Error messages
test_that("Error: Given variables should exist in both scripts.", {
          expect_error(compare_variables("../example_scripts/reference.R",
                                         "../example_scripts/student_full_wrong.R",
                                         c("wrong_variable")),
                       regexp = "Given variables should exist")
  }
)

test_that("Error: Number of variables and weights are not equal!", {
  expect_error(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_wrong.R",
                                 c("summarized_income"), c(1,2,3)),
               regexp = "Number of variables and weights")
  }
)

test_that("Warning: There is a zero point assigned", {
  expect_warning(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_wrong.R",
                                 c("summarized_income"), c(0)),
               regexp = "zero point")
}
)

# return_expected
test_that("Argument: return_expected, basic", {
  expected <- matrix(c(71, 6, 0), ncol = 3)
  colnames(expected) <- c("student", "expected", "score")
  rownames(expected) <- c("length_chick_dataset")
  expected <- as.data.frame(expected)
  expect_equal(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_wrong.R",
                                 c("length_chick_dataset"), return_expected = T),
               expected)
}
)
