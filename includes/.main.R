#!/usr/bin/env r
#
# Author: Sebastian Warnholz
# Email: Sebastian.Warnholz@inwt-statistics.de

suppressMessages({
  library(drat)
  library(devtools)
  library(stringr)
})

getArgument <- function(name, default) {
  val <- Sys.getenv(name)
  if (val == "") default else as(val, class(default))
}

opts <- list(
  check = getArgument("r_check", FALSE),
  test = getArgument("r_test", FALSE),
  install = getArgument("r_install", TRUE),
  main = getArgument("r_main", FALSE),
  depsStatic = getArgument("r_deps_static", ""),
  depsRepos = getArgument("r_deps_repos", "https://inwt-vmeh2.inwt.de/r-repo/")
)

depsRegister <- function() {
  depsPkg <- ""
  if (dir.exists("./deps")) depsPkg <- c(
    depsPkg,
    list.files("./deps", full.names = TRUE, pattern = "^.*\\.tar\\.gz$")
  )

  if (dir.exists(".deps/src/contrib")) depsPkg <- c(
    depsPkg,
    list.files("./deps/src/contrib", full.names = TRUE, pattern = "^.*\\.tar\\.gz$")
  )

  if (opts$depsStatic != "") depsPkg <- c(
    depsPkg,
    downloadPackages(opts$depsStatic)
  )

  for (pkg in depsPkg) drat::insertPackage(pkg)

}

downloadPackages <- function(depsStatic) {
  unlist(lapply(depsStatic, function(pkg) {
    repos <- opts$depsRepos
    repoSub <- "src/contrib/"
    pkgName <- readLines(paste0(repos, repoSub))
    pkgName <- stringr::str_extract(pkgName, sprintf(">%s_.*tar\\.gz", pkg))
    pkgName <- pkgName[Negate(is.na)(pkgName)]
    pkgName <- sub("^>", "", pkgName)
    download.file(
      paste0(repo, repoSub, pkgName),
      fname <- paste(tempdir(), pkgName, sep = "/")
    )
    fname
  }))
}

caseCheck <- function() {
  if (!devtools::is.package(".")) return(cat("Can't do check: not a package\n"))
  cat("Looks like a package...\n"); Sys.sleep(1)
  if (opt$check) devtools::check()
}

caseTest <- function() {
  if (!dir.exists("./tests")) return(cat("No tests found\n"))
  cat("Found tests in ./tests...\n"); Sys.sleep(1)
  tfiles <- list.files("./tests", full.names = TRUE)
  for (file in tfiles) source(file, local = new.env(parent = baseenv()))
}

caseMain <- function() {
  if (file.exists("./main.R")) source("./main.R", local = new.env(parent = baseenv()))
  else if (devtools::is.package(".")) {
    library(devtools::as.package("")$package, character.only = TRUE)
    if (exists("main")) main()
    else cat("Can't find main method")
  }
  else cat("No main-script or package detected")
}

help <- function() "help me!"

if (dir.exists("./deps") | opts$depsStatic != "") depsRegister()
if (opts$install && devtools::is.package(".")) devtools::install()

if (opts$check) {
  caseCheck()
} else if (opts$test) {
  caseProject()
} else if (opts$main) {
  caseMain()
} else cat(help())
