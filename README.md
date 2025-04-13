# comparescript 📄🔍
A small utility package for comparing two scripts' variables that have same names

**scriptVarCompare** is an R package designed to **compare variables** across two R scripts — when those scripts define **variables with the same names**. It is built for use cases where user-provided scripts are evaluated dynamically, and the goal is to detect whether variables (e.g., data frames, vectors, lists) are identical between the scripts.

---

## ✅ Current Features

- 📂 **Load and isolate scripts in separate environments**  
  Scripts are evaluated into independent environments, so same-named variables do not overwrite each other.

- 🔍 **Compare variables across environments**  
  Supports `identical()` comparison across a user-defined set of variables (regardless of type).

- 🤫 **Silent script evaluation**  
  Messages, warnings, and console output from user scripts are suppressed for a clean experience.

- 🚫 **Script preprocessing**  
  Optionally strips installation-related calls like `install.packages()` and `remotes::install_*()` before evaluation.

- 🧪 **Testing-friendly**  
  Evaluation is skipped during `R CMD check` to avoid failures caused by `library()` calls to undeclared packages.

---

## 🚧 To Be Developed / Considered

- 📦 **Runtime package handling**  
  Currently assumes all packages used in user scripts are pre-installed. A future version may offer dynamic checks or prompts.

- 📜 **Better script diagnostics**  
  Add options to log which variables were found, skipped, or mismatched — possibly with type or structure info.

- 🔧 **Partial or fuzzy variable comparison**  
  Add support for comparing structure or summary statistics, not just `identical()` equality.

- 👀 **UI/visualization tools**  
  Potential Shiny app or HTML report to visualize the variable differences more clearly.

- 🧹 **Stronger script sanitization**  
  Strip or sandbox other unsafe side effects (file writes, drive downloads, etc.).

---

## 🔄 Example Workflow

```r
library(scriptVarCompare)

env1 <- load_script("script_a.R")
env2 <- load_script("script_b.R")

compare_variables(c("data", "results"), env1, env2)
