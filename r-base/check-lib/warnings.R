modules::export("check")

check <- function(res) {
  if (length(res$warnings) > 0) {
    relevantWarnings <- res$warnings[
      !grepl("Non-standard license specification", res$warnings)]
    if (length(relevantWarnings) > 0) stop("Check produced warnings.")
  }
}
