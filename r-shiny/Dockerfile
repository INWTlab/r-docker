FROM inwt/r-batch:4.1.1

EXPOSE 3838

RUN installAutomake 1.16.1 \
    && installPackage \
    htmlwidgets \
    DT \
    shiny \
    shinydashboard \
    shinyjs \
    shinythemes \
    plotly
