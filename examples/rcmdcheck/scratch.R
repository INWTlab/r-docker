
devtools::document()
res <- devtools::check(".", error_on = "never")
LIB <- modules::use("../../r-base/check-lib")

LIB$errors$check(res)
LIB$warnings$check(res)
LIB$notes$check(res)
str(res)
