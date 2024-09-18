FROM inwt/r-batch:4.4.1

RUN apt-get -y update \
   && apt-get install -y --no-install-recommends \
   libnode-dev \
   && apt-get autoremove -y \
   && apt-get autoclean -y \
   && rm -rf /var/lib/apt/lists/* \
   && installPackage rstan \
   && installPackage prophet \
   && rm -rf /tmp/downloaded_packages/*
