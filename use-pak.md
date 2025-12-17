# Install pak in rbase

better instpak need to be pinned to a specific version (0.9.0)

```
&& Rscript -e "options(warn = 2); install.packages(c('devtools', 'drat', modules', 'pak'))"\
```

doctop is aleready installed in rocker/r-base

## Utility Scripts

### installPackages

- validate-settings
- register-dependencies
- `install.packages()`

### installGithub

- validate-settings
- register-dependencies
- `devtools::install_github`

### build

- `source("/includes/validate-settings.R")`
- `source("/includes/register-dependencies.R")`
- `devtools::install(dependencies = TRUE)`
- `devtools::build(".", ".")`

### check

- `source("/includes/validate-settings.R")`
- `source("/includes/register-dependencies.R")`
- `devtools::install(PKG, dependencies = TRUE)`
- `devtools::check(PKG, error_on = "never")`

### test

- `source("/includes/validate-settings.R")`
- `source("/includes/register-dependencies.R")`
- `devtools::install()`
- `devtools::test()`

### validate-settings

### register-dependencies
