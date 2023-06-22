FROM inwt/r-batch:3.6.3

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        libnode-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && Rscript -e "install.packages(c('rstan', 'prophet'), repos = 'https://packagemanager.posit.co/cran/2020-07-27')" \
    && rm -rf /tmp/downloaded_packages/*
