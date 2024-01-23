FROM inwt/r-base:4.3.2

COPY aws.config /app/.aws/config

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        libbz2-dev \
        liblzma-dev \
        libpcre3-dev \
        libpcre2-dev \
        libmysqlclient-dev \
        libpq-dev \
        awscli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf \
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
