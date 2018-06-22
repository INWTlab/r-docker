#!/usr/bin/env Rscript
# author: Sebastian Warnholz
# email: sebastian.warnholz@inwt-statistics.de

# source("/includes/validate-settings.R")
# source("/includes/register-dependencies.R")

if (file.exists("DESCRIPTION")) {
  invisible(devtools::install())
} else if ((pkg <- Sys.getenv("PKG")) != "") {
  invisible(install.packages(pkg))
} else {
  invisible(install.packages(opt$PKGS))
}
