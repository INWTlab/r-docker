# -------------------
# Setup (Global Args)
# -------------------
ARG R_VERSION=4.5.1
ARG USER_NAME=user
ARG USER_UID=1000
ARG USER_GID=1000
ARG GLOBAL_TZ="Europe/Berlin"
ARG GLOBAL_LANG="en_US.UTF-8"

# ----------------
# Stage 1: builder
# ----------------
FROM rocker/r-ver:${R_VERSION} AS builder

# 1. User & Environment Setup
ARG USER_NAME
ARG USER_UID
ARG USER_GID
ARG GLOBAL_TZ
ARG GLOBAL_LANG

ENV DEBIAN_FRONTEND=noninteractive
ENV OPENBLAS_NUM_THREADS=1
ENV _R_CHECK_TESTS_NLINES_=0
ENV TZ=${GLOBAL_TZ}
ENV LANG=${GLOBAL_LANG}

# Create the non-root user (UID 1000:GID 1000)
RUN groupadd --gid ${USER_GID} ${USER_NAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -G staff ${USER_NAME}

WORKDIR /app
COPY . /includes/

# 2. System Dependencies, Timezone, and CA Certificates
    # CA Certificates and Timezone Setup
RUN mv -v /includes/*.crt /usr/local/share/ca-certificates/ \
    && dpkg-reconfigure ca-certificates \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && echo "Europe/Berlin" > /etc/timezone \
    # Install System Dependencies
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    autoconf \
    cmake \
    less \
    libssl-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    nano \
    rsync \
    tzdata \
    qpdf \
    wget \
    zlib1g-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# 3. R Environment Setup and Package Installation
    # Link scripts
RUN chmod +x /includes/*.R \
    && ln -s /usr/local/lib/R/site-library/littler/examples/dratInsert.r /usr/local/bin/dratInsert.r \
    && ln -s /includes/check.R /usr/local/bin/check \
    && ln -s /includes/test.R /usr/local/bin/test \
    && ln -s /includes/build.R /usr/local/bin/build \
    && ln -s /includes/main.R /usr/local/bin/main \
    && ln -s /includes/installGithub.R /usr/local/bin/installGithub \
    && ln -s /includes/installPackage.R /usr/local/bin/installPackage \
    # Set Posit Package Manager as CRAN Mirror
    && echo "options(repos = c(CRAN = '$(Rscript /includes/get_mirror_date.R)'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site \
    # Install R Packages (stringi needs to be recompiled)
    && Rscript -e "options(warn = 2); install.packages('https://github.com/gagolews/stringi/releases/download/v1.8.7/stringi_1.8.7.tar.gz', repos = NULL, type = 'source')" \
    && Rscript -e "options(warn = 2); install.packages(c('devtools', 'docopt', 'drat', 'modules'), Ncpus = parallel::detectCores())" \
    && rm -rf /tmp/downloaded_packages/* \
    # Setup local repository
    && mkdir -p /r-repo/src/contrib \
    && touch /r-repo/src/contrib/PACKAGES \
    && echo "options(repos = c(getOption('repos'), LOCAL = 'file:////r-repo/'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(repos = c(getOption('repos'), INWT = 'https://r-repo.core.cld.htz.int.inwt.de'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(repos = c(getOption('repos'), INWTLab = 'https://inwtlab.github.io/drat/'))" >> /usr/local/lib/R/etc/Rprofile.site \
    && echo "options(dratRepo = '/r-repo/')" >> /usr/local/lib/R/etc/Rprofile.site  \
    # Set ownership for site-library, local r-repo & R scriüts
    && chown -R ${USER_NAME}:${USER_NAME} /usr/local/lib/R/site-library/ \
    && chown -R ${USER_NAME}:${USER_NAME} /r-repo \
    && chown -R ${USER_NAME}:${USER_NAME} /includes

# --------------
# Stage 2: final
# --------------
FROM rocker/r-ver:${R_VERSION}

LABEL org.opencontainers.image.authors="Sebastian Warnholz, Jan Abel" \
      org.opencontainers.image.created="BUILD_DATE_TIME_PLACEHOLDER" \
      org.opencontainers.image.description="Multi-stage R environment based on Rocker" \
      org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.revision="GIT_SHA_PLACEHOLDER" \
      org.opencontainers.image.source="https://github.com/INWTlab/r-docker" \
      org.opencontainers.image.title="inwt/r-base" \
      org.opencontainers.image.vendor="INWT Statistics" \
      org.opencontainers.image.version="${R_VERSION}"

# 1. User Setup
ARG USER_NAME
ARG USER_UID
ARG USER_GID
ARG GLOBAL_TZ
ARG GLOBAL_LANG

# Re-create the non-root user in the final stage (since this is a new base layer)
RUN groupadd --gid ${USER_GID} ${USER_NAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -G staff ${USER_NAME}

# Set runtime environment variables
ENV HOME=/app
ENV TZ=${GLOBAL_TZ}
ENV LANG=${GLOBAL_LANG}

# 2. Copy Artifacts from the builder stage
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/
COPY --from=builder /usr/local/lib/R/etc/Rprofile.site /usr/local/lib/R/etc/Rprofile.site
COPY --from=builder /r-repo/ /r-repo/

# 3. Add utility scripts
RUN mkdir -p /includes/check-lib

COPY --from=builder /includes/build.R /includes/build.R
COPY --from=builder /includes/check.R /includes/check.R
COPY --from=builder /includes/installPackage.R /includes/installPackage.R
COPY --from=builder /includes/installGithub.R /includes/installGithub.R
COPY --from=builder /includes/register-dependencies.R /includes/register-dependencies.R
COPY --from=builder /includes/validate-settings.R /includes/validate-settings.R
COPY --from=builder /includes/check-lib/ /includes/check-lib/

RUN chown -R ${USER_NAME}:${USER_NAME} /includes

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR ${HOME}

CMD ["R"]
