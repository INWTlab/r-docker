FROM inwt/r-base:3.5.1

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        libbz2-dev \
        liblzma-dev \
        libpcre3-dev \
        libmariadb-client-lgpl-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf \
    && installPackage \
        rJava \
        RMySQL \
        dplyr \
        data.table \
        futile.logger \
        gbm \
        ggplot2 \
        gridExtra \
        lme4 \
        mgcv \
        tidyr \
    && installGithub \
        INWT/dbtools \
        INWT/mctools \
    && rm -rf /tmp/downloaded_packages/*
