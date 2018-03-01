FROM rocker/r-ver:3.4.3

WORKDIR /app
ENV HOME /app
ENV	DEBIAN_FRONTEND noninteractive
ENV OPENBLAS_NUM_THREADS 1

COPY INWT-CA.crt /app/
RUN mv INWT-CA.crt /usr/local/share/ca-certificates/ && \
    dpkg-reconfigure ca-certificates 

RUN apt-get -y update \
    && apt-get -y install \
    libssl-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && install2.r \
    drat

# local r-repos
RUN ln -s /usr/local/lib/R/site-library/littler/examples/dratInsert.r /usr/local/bin/dratInsert.r \
    && mkdir -p /app/deps/src/contrib \
    && echo "options(repos = c(getOption('repos'), LOCAL = 'file:////app/deps/'))" >> /usr/local/lib/R/etc/Rprofile.site

