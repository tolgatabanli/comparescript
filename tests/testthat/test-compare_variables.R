test_that("A fully correct assignment assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                 "../example_scripts/student_full_correct.R")),
               rep(T, 9))
})

test_that("An assignment with mistakes assessed correctly with respective vars", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_with_mistakes.R")),
               c(F, T, T, T, T, T, F, T, T))
})

test_that("A fullly wrong assignment (except data-reading and example manual_tbl) assessed correctly", {
  expect_equal(unname(compare_variables("../example_scripts/reference.R",
                                        "../example_scripts/student_full_wrong.R")),
               c(F, T, rep(F, 5), T, F))
})
