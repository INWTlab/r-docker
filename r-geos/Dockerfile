FROM inwt/r-batch:4.2.3

RUN apt-get -y update \
   && apt-get install -y --no-install-recommends \
   libgdal-dev \
   libgeos-dev \
   libproj-dev \
   libudunits2-dev \
   && apt-get autoremove -y \
   && apt-get autoclean -y \
   && rm -rf /var/lib/apt/lists/* \
   && installPackage \
    geojsonsf \
    raster \
    R.utils \
    sf \
    stars \
    terra \
    unix \
   && rm -rf /tmp/downloaded_packages/*

