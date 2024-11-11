# parse command line arguments
parse_args <- function(args) {
  arg_list <- list()
  for (arg in args) {
    if (grepl("^--", arg)) {
      arg_name_value <- sub("^--", "", arg)
      if (grepl("=", arg_name_value)) {
        splits <- strsplit(arg_name_value, "=")[[1]]
        arg_list[[splits[1]]] <- splits[2]
      } else {
        arg_list[[arg_name_value]] <- TRUE
      }
    }
  }
  return(arg_list)
}

usage <- function() {
  cat("Usage: check [--cran=TRUE|FALSE]\n")
}

# set default value
cran_arg <- TRUE

args <- commandArgs(trailingOnly = TRUE)
arg_list <- parse_args(args)

# check command line argument
if (length(args) > 0 && !is.null(arg_list$cran)) {
  cran_arg <- as.logical(arg_list$cran)
} elseif (length(args) > 0) {
  usage_message()
  quit(status = 1)
}
