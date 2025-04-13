# comparescript
**comparescript** is an R package designed to **compare variables** across two R scripts — when those scripts define **variables with the same names**.
It is built to detect whether variables (e.g., data frames, vectors, lists) are identical between the scripts evaluated dynamically.

---

## ✅ Current Features

- 📂 **Scripts loaded and evaluated in separate environments**  
  Same-named variables do not overwrite.

- 🔍 **Compare variables across environments**  
  Supports `identical()` comparison across a user-defined set of variables (regardless of type).

- 🤫 **Silent script evaluation**  
  Messages, warnings, and console output from user scripts are suppressed for a clean experience.

- 🚫 **Script preprocessing**  
  Strips installation-related calls like `install.packages()` before evaluation.
  This way, the evaluation of scripts presumes the required packages are already installed.
  If not, an expected error is thrown from the respective library call.

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
TO BE ADDED
