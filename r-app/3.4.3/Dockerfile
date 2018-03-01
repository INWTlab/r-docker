FROM inwt/r-ver:3.4.3

RUN apt-get -y update \
    && apt-get -y install \
    libssl-dev \
    libmariadb-client-lgpl-dev \
    default-jdk \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && install2.R \
    RMySQL
