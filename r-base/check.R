#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

source("/includes/validate-settings.R")
source("/includes/register-dependencies.R")

suppressPackageStartupMessages(stopifnot(require(devtools)))
suppressPackageStartupMessages(stopifnot(require(roxygen2)))
suppressPackageStartupMessages(stopifnot(require(codetools)))

if (!file.exists("DESCRIPTION")) {
  stop("Can't do check: not a package\n")
}

cat("Looks like a package...\n"); Sys.sleep(1)
devtools::install(dependencies = TRUE)
res <- devtools::check(pkg = ".", force_suggests = TRUE)

# Dealing with errors
if (length(res$errors) > 0) {
  logsWithErrors <- list.files(
    dirname(attr(res, "path")),
    pattern = ".*Rout.fail",
    full.names = TRUE,
    recursive = TRUE
  )
  for (file in logsWithErrors) {
    cat("\n\n----", file, "----\n")
    for (line in readLines(file)) {
      cat(line, "\n")
    }
  }
}

# Warnings
relevantWarnings <- res$warnings[
  !grepl("Non-standard license specification", res$warnings)]

# Notes
globalsInCode <- any(grepl("global variable", res$notes))

# 1 Figure out status code
if (length(res$errors) > 0) stop("Check produced errors.")
if (length(relevantWarnings) > 0) stop("Check produced warnings.")
if (globalsInCode) stop("Check discovered GLOBAL variables.")
