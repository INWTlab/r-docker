modules::export("check")

check <- function(res) {
  if (length(res$errors) > 0) {
    errorLogs <- findLogs(res)
    printLogEntries(errorLogs)
    stop("Check produced errors.")
  }
  if (res$status != 0) {
    stop(sprintf("Check failed with status: %s", res$status))
  }
}

findLogs <- function(res) {
  list.files(
    dirname(attr(res, "path")),
    pattern = ".*Rout.fail",
    full.names = TRUE,
    recursive = TRUE
  )
}

printLogEntries <- function(logFiles) {
  for (file in logFiles) {
    cat("\n\n----", file, "----\n")
    for (line in readLines(file)) {
      cat(line, "\n")
    }
  }
}
