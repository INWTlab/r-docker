modules::export("check")

check <- function(res) {
  globalsInCode <- any(grepl("global variable", res$notes))
  if (globalsInCode) stop("Check discovered GLOBAL variables.")
}
