# ----------------
# Stage 1: builder
# ----------------
FROM inwt/r-batch:4.5.1.non-root AS shiny-builder

# 1. User and Enviroment Setup
ARG USER_NAME=user

# 2. System Dependencies
COPY installAutomake.sh /tmp/installAutomake.sh
USER root
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    wget \
    libudunits2-dev \
    libgdal-dev \
    xdg-utils \
    # installAutomake
    && chmod +x /tmp/installAutomake.sh \
    && /tmp/installAutomake.sh 1.16.1 \
    # Cleanup
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/installAutomake.sh

# 3. Install R Packages Installation
USER ${USER_NAME}
RUN installPackage \
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
    plotly \
    && rm -rf /tmp/downloaded_packages/*

# --------------
# Stage 2: final
# --------------
FROM inwt/r-batch:4.5.1.non-root

# 1. Enviroment, Ports & User Setup
ARG USER_NAME=user
EXPOSE 3838
ENV HOME=/app

# 2. Copy Artifacts from builder stage
COPY --from=shiny-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR /app

CMD ["R"]

# FROM inwt/r-batch:4.5.1.non-root
# 
# EXPOSE 3838
# 
# RUN installAutomake 1.16.1 \
#     && apt-get update \
#     && apt-get install -y \
#     libudunits2-dev \
#     libgdal-dev \
#     xdg-utils \
#     && apt-get autoremove -y \
#     && apt-get autoclean -y \
#     && rm -rf /var/lib/apt/lists/* \
#     && installPackage \
#     DT \
#     htmlwidgets \
#     leaflet \
#     sf \
#     shiny \
#     shinyalert \
#     shinybusy \
#     shinydashboard \
#     shinyjs \
#     shinythemes \
#     plotly
