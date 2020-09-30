FROM inwt/r-batch:3.6.3

EXPOSE 3838

RUN apt-get -y update && apt-get install -y --no-install-recommends \ 
        automake-1.16 \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && installPackage \
        htmlwidgets \
        DT \
        shiny \
        shinydashboard \
        shinyjs \
        shinythemes \
        plotly

# We don't use array syntax because we want to use the ENV varialbe
# PKG is expected to be configured in the Dockerfile of the app.
CMD Rscript -e "library(shiny);$PKG::startApplication()" || main
