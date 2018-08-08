modules::export("check")

check <- function(res) {
  if (length(res$errors) > 0) {
    errorLogs <- findLogs(res)
    printLogEntries(errorLogs)
    throwException()
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

throwException <- function() {
  stop("Check produced errors.")
}

