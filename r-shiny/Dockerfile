FROM inwt/r-batch:4.4.0

EXPOSE 3838

RUN installAutomake 1.16.1 \
    && apt-get update \
    && apt-get install -y \
    libudunits2-dev \
    libgdal-dev \
    xdg-utils \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && installPackage \
    DT \
    htmlwidgets \
    leaflet \
    sf \
    shiny \
    shinyalert \
    shinybusy \
    shinydashboard \
    shinyjs \
    shinythemes \
    plotly
