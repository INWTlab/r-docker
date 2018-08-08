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
ARGS <- commandArgs(TRUE)
PKG <- "."

if (!file.exists("DESCRIPTION")) {
  stop("Can't do check: not a package\n")
}

cat("Looks like a package...\n"); Sys.sleep(1)
devtools::install(PKG, dependencies = TRUE)
res <- devtools::check(PKG, args = ARGS)

LIB$errors$check(res)
LIB$warnings$check(res)
LIB$notes$check(res)
