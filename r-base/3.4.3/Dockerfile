FROM rocker/r-ver:3.4.3

WORKDIR /app
ENV HOME /app
ENV	DEBIAN_FRONTEND noninteractive
ENV OPENBLAS_NUM_THREADS 1

ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/INWT-CA.crt /app/
RUN mv INWT-CA.crt /usr/local/share/ca-certificates/ && \
    dpkg-reconfigure ca-certificates 

RUN apt-get -y update \
    && apt-get -y install \
        less \
        libssl-dev \
        libssh2-1-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        nano \
        rsync \
        wget \
    && apt-get autoremove -y \
    && apt-get autoclean -y

# local r-repos
RUN install2.r \
        drat \
        docopt \
    && rm -rf /tmp/downloaded_packages/* \
    && ln -s /usr/local/lib/R/site-library/littler/examples/dratInsert.r /usr/local/bin/dratInsert.r \
    && mkdir -p /app/deps/src/contrib \
    && touch /app/deps/src/contrib/PACKAGES \
    && echo "options(repos = c(getOption('repos'), LOCAL = 'file:////app/deps/'))" >> /usr/local/lib/R/etc/Rprofile.site

