test_that("A fully correct assignment assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_correct.R")),
               rep(1, 9))
})

test_that("An assignment with mistakes assessed correctly with respective vars", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_with_mistakes.R")),
               c(0, 1, 1, 1, 1, 1, 0, 1, 1))
})

test_that("A fully wrong assignment (except data-reading and example manual_tbl) assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_wrong.R")),
               c(0, 1, rep(0, 5), 1, 0))
})

# Weights and names given
test_that("A fully correct assignment assessed correctly with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_correct.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               c(2, 1, 2))
})

test_that("An assignment with mistakes assessed correctly with respective vars with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_with_mistakes.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               c(2, 1, 0))
})

test_that("A fully wrong assignment (except data-reading and example manual_tbl) assessed correctly with given var names and weights", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_wrong.R",
                                        c("summarized_income", "length_chick_dataset", "chick_summarized"),
                                        c(2, 1, 2))),
               c(0, 0, 0))
})

# Error messages
test_that("A variable that does not exist can be detected", {
          expect_error(compare_variables("../example_scripts/reference.R",
                                         "../example_scripts/student_full_wrong.R",
                                         c("wrong_variable")),
                       regexp = "Given variables should exist")
  }
)
