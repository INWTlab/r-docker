#!/usr/bin/env r
# author: Sebastian Warnholz
# email: sebastian.warnholz@inwt-statistics.de
# started from littler/installGithub.R - however experienced problems while
# using 'remotes' instead of 'devtools'.

suppressMessages({
  library(docopt)
  library(devtools)
})

## configuration for docopt
doc <- "Usage: installGithub.R [-h] [-x] [REPOS...]
-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)

if (opt$usage) {
    cat(doc, "\n\n")
    cat("where REPOS... is one or more GitHub repositories.
Examples:
  installGithub.R INWT/dbtools\n")
    q("no")
}

invisible(sapply(opt$REPOS, install_github))
