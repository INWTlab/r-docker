# -------------------
# Setup (Global Args)
# -------------------
ARG R_VERSION=4.5.1.non-root
ARG USER_NAME=user
ARG AUTOMAKE_VERSION=1.16.1

LABEL org.opencontainers.image.title="INWT - R Shiny Image" \
      org.opencontainers.image.description="Build upon inwt/r-batch with Shiny & deps for web applications" \
      org.opencontainers.image.vendor="INWT Statistics" \
      org.opencontainers.image.authors="Sebastian Warnholz, Jan Abel" \
      org.opencontainers.image.version="${R_VERSION}" \
      org.opencontainers.image.url="https://github.com/INWTlab/r-docker" \
      org.opencontainers.image.source="https://github.com/INWTlab/r-docker"

# ----------------
# Stage 1: builder
# ----------------
FROM inwt/r-batch:${R_VERSION} AS shiny-builder

# 1. User and Enviroment Setup
ARG USER_NAME
ARG AUTOMAKE_VERSION

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
    && /tmp/installAutomake.sh ${AUTOMAKE_VERSION} \
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
FROM inwt/r-batch:${R_VERSION}

# 1. Enviroment, Ports & User Setup
ARG USER_NAME
EXPOSE 3838
ENV HOME=/app

# 2. Copy Artifacts from builder stage
COPY --from=shiny-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR /app

CMD ["R"]
