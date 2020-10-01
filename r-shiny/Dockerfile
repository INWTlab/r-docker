FROM inwt/r-batch:3.6.0

EXPOSE 3838

RUN installAutomake 1.16 \
    && Rscript -e "options(warn = 2); install.packages('httpuv')" \ 
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
