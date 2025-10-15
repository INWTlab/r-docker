FROM inwt/r-base:4.5.1.non-root

COPY aws.config /app/.aws/config

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        curl \
        openjdk-8-jdk \
        libbz2-dev \
        liblzma-dev \
        libpcre3-dev \
        libpcre2-dev \
        libmysqlclient-dev \
        libpq-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.25.13.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# R things
RUN R CMD javareconf \
    && installPackage \
        arrow \
        codetools \
        data.table \
        dplyr \
        futile.logger \
        gbm \
        ggplot2 \
        gridExtra \
        lintr \
        lme4 \
        mgcv \
        RClickhouse \
        rJava \
        RMySQL \
        roxygen2 \
        RPostgres \
        testthat \
        tidyr \
        dbtools \
        mctools \
    && rm -rf /tmp/downloaded_packages/*
