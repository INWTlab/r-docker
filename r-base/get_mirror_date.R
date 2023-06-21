create_mirror_url <- function(date) {
  sprintf("https://packagemanager.posit.co/cran/%s", format(date, "%Y-%m-%d"))
}

check_if_mirror_is_available <- function(date) {
  url <- create_mirror_url(date)
  stat <- attr(curlGetHeaders(paste0(url, "/src/contrib/PACKAGES")), "status")
  stat == 200
}

get_mirror_date <- function() {
  r_version_date <- as.Date(paste(utils::sessionInfo()[["R.version"]][c("year", "month", "day")], collapse = "-"))

  for (date in as.list(seq(r_version_date, by = -1, length.out = 5))) {
    if (check_if_mirror_is_available(date)) {
      return(date)
    }
  }
}

mirror_date <- get_mirror_date()

if (is.null(mirror_date)) {
  q(status = 1)
}

cat(create_mirror_url(mirror_date))

q(status = 0)
