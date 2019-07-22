#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

source("/includes/validate-settings.R")
source("/includes/register-dependencies.R")

suppressPackageStartupMessages(stopifnot(require(devtools)))
suppressPackageStartupMessages(stopifnot(require(roxygen2)))
suppressPackageStartupMessages(stopifnot(require(codetools)))
suppressPackageStartupMessages(stopifnot(require(modules)))

LIB <- modules::use("/includes/check-lib/")

PKG_FOLDER <- getArgument("PKG_FOLDER", ".")

if (!file.exists(paste0(PKG_FOLDER, "/", "DESCRIPTION"))) {
  stop("Can't do check: not a package\n")
}

cat("Looks like a package...\n"); Sys.sleep(1)
devtools::install(PKG_FOLDER, dependencies = TRUE)
res <- devtools::check(PKG_FOLDER, error_on = "never")

LIB$errors$check(res)
LIB$warnings$check(res)
LIB$notes$check(res)
