# comparescript
**comparescript** is an R package designed to **compare variables** across two R scripts — when those scripts define **variables with the same names**.
It is built to detect whether variables (e.g., data frames, vectors, lists) are identical between the scripts evaluated dynamically.

---

## ✅ Current Features

- 📂 **Scripts loaded and evaluated in separate environments**  
  Same-named variables do not overwrite.

- 🔍 **Compare variables across environments**  
  Supports `identical()` comparison across a user-defined set of variables (regardless of type).

- 🤫 **Silent evaluation**  
  Messages, warnings, and console output from user scripts are suppressed for a clean experience.

- 🚫 **Script preprocess**  
  Strips off installation-related calls like `install.packages()` and google drive downloads like `drive_download` before evaluation.
  This way, the evaluation of scripts presumes the required packages are already installed.
  If not, an expected error is thrown from the respective library call.

---

## 🚧 To be considered in the future

- 📦 **Runtime package handling**  
  Currently assumes all packages used in user scripts are pre-installed. A future version may offer dynamic checks or prompts.

- 📜 **Better script diagnostics**
  Add options to log which variables were found, skipped, or mismatched — possibly with type or structure info.

- 🔧 **Partial or fuzzy variable comparison**  
  Add support for comparing structure or summary statistics, not just `identical()` equality.
    ✅ ADDED, needs to be checked rigorously!

- 🧹 **Stronger script sanitization**  
  Could add more preprocessing details for avoiding unwanted side effects such as downloads, file writes etc.

---
## 🪄 Install

To use the package, we'll install it from GitHub. For this, use:

```r
devtools::install_github("tolgatabanli/comparescript")
library(comparescript)
```

## Example Workflow
Assuming we have a solution sheet (`reference.R`) and a student assignment (`student_assignment.R`), we can compare the values of the variable after a dynamic evaluation of both scripts.
The assessor can also select variables to compare and assign so-called weigths, scores, for each variable.
If both given, these vectors should be of same length and its elements correspond to each other in the same order.
```r
compare_variables("reference.R", "student_assignment.R")
compare_variables("reference.R", "student_assignment.R", c("var1, var2"), c(2, 1)) # var1 gives 2 points and var2 1 points if correct.
```

