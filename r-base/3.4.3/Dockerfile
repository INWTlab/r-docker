FROM rocker/r-ver:3.4.3

WORKDIR /app
ENV HOME /app
ENV	DEBIAN_FRONTEND noninteractive
ENV OPENBLAS_NUM_THREADS 1

ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/INWT-CA.crt /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/check.R /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/test.R /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/main.R /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/validate-settings.R /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/register-dependencies.R /includes/
ADD https://raw.githubusercontent.com/INWTlab/r-docker/master/includes/README.plain /includes/

RUN mv /includes/INWT-CA.crt /usr/local/share/ca-certificates/ \
    && dpkg-reconfigure ca-certificates

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
        less \
        libssl-dev \
        libssh2-1-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        nano \
        rsync \
        wget \
        zlib1g-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y

# local r-repos
RUN install2.r \
        devtools \
        docopt \
        drat \
        remotes \
        testthat \
    && rm -rf /tmp/downloaded_packages/* \
    && chmod +x /includes/*.R \
    && ln -s /usr/local/lib/R/site-library/littler/examples/dratInsert.r /usr/local/bin/dratInsert.r \
    && ln -s /includes/check.R /usr/local/bin/check \
    && ln -s /includes/test.R /usr/local/bin/test \
    && ln -s /includes/main.R /usr/local/bin/main \
    && mkdir -p /r-repo/src/contrib \
    && touch /r-repo/src/contrib/PACKAGES \
    && echo "options(repos = c(getOption('repos'), LOCAL = 'file:////r-repo/'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(dratRepo = '/r-repo/')" >> /usr/local/lib/R/etc/Rprofile.site 

CMD ["main"]