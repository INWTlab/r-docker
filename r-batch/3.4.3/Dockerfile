FROM inwt/r-base:3.4.3

RUN apt-get -y update \
    && apt-get -y install \
        libmariadb-client-lgpl-dev \
        default-jdk \
        rsync \
        ed \
        wget \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && install2.r \
        dplyr \
        data.table \
        futile.logger \
        gbm \
        ggplot2 \
        gridExtra \
        lme4 \
        mgcv \
        RMySQL \
        tidyr \
    && rm -rf /tmp/downloaded_packages/*
