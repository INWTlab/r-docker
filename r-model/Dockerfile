FROM inwt/r-batch:4.0.1

RUN apt-get -y update \
   && apt-get install -y --no-install-recommends \
   libnode-dev \
   && apt-get autoremove -y \
   && apt-get autoclean -y \
   && rm -rf /var/lib/apt/lists/* \
   && Rscript -e "install.packages(c('rstan', 'prophet'), repos = 'https://mran.microsoft.com/snapshot/2020-07-28')" \
   && rm -rf /tmp/downloaded_packages/*
