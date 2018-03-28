FROM inwt/r-batch:3.4.3

EXPOSE 3838

RUN install2.r \
        htmlwidgets \
        shiny \
        shinydashboards \
        shinyjs \
        shinythemes \
        plotly

# We don't use array syntax because we want to use the ENV varialbe:
CMD Rscript -e "library(shiny);$PKG::startApplication()" || main