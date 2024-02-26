#!/usr/bin/env Rscript
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

local({
  cat("Validate Settings ...")
  if (file.exists("./.Rprofile")) {
    cat("\n")
    cat("Detected local .Rprofile. This is potentially messing up the local config:\n")
    cat("MRAN:", reposRemote <- getOption("repos")["CRAN"], "\n")
    cat("LOCAL:", reposLocal <- getOption("repos")["LOCAL"], "\n")
    if (!grepl("r-repo", reposLocal)) warning("Local repos is not set correctly.")
  } else if (!is.null(repos <- getOption("repos"))) {
    ind <- lapply(repos, function(r) {
      on.exit(try(close(con), silent = TRUE))
      path <- paste0(r, "/src/contrib/PACKAGES")
      con <- suppressWarnings(try(url(path, open = "r")))
      con
    })
    ind <- lapply(ind, inherits, what = "try-error")
    ind <- unlist(ind)
    if (any(ind)) {
      cat("\n")
      cat("Clearing repositories; now using:\n")
      for (entry in repos[!ind]) cat(entry, "\n")
      options(repos = repos[!ind])
    } else {
      cat(" OK\n")
    }
  } else {
    Sys.sleep(1)
    cat(" OK\n")
  }
})


