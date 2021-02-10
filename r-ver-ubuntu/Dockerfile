FROM ubuntu:focal

## This is a fork of;
##   https://github.com/rocker-org/rocker-versioned
## Author: Carl Boettiger <cboettig@ropensci.org>
## Minor modififications: Sebastian Warnholz
##
## Following changes:
##   - ubuntu:bionic instead of debian:buster
##   - libicu66      instead of libicu63
##   - libjpeg62     instead of libjpeg62-turbo
##   - libreadline8  instead of libreadline7
##   - no littler

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/INWTlab/r-docker" \
      org.label-schema.vendor="INWT Open Source Projects" \
      maintainer="Sebastian Warnholz <sebastian.warnholz@inwt-statistics.de>"

ARG R_VERSION
ARG CRAN
ENV R_VERSION=${R_VERSION:-4.0.3} \
  LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
  && apt install -y --no-install-recommends \
    bash-completion \
    ca-certificates \
    file \
    fonts-texgyre \
    g++ \
    gfortran \
    gsfonts \
    libblas-dev \
    libbz2-1.0 \
    libcurl4 \
    libicu66 \
    libjpeg62 \
    libopenblas-dev \
    libpangocairo-1.0-0 \
    libpcre3 \
    libpng16-16 \
    libreadline8 \
    libtiff5 \
    liblzma5 \
    locales \
    make \
    unzip \
    zip \
    zlib1g \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8 \
  && BUILDDEPS="curl \
    default-jdk \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libicu-dev \
    libpcre3-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    liblzma-dev \
    libx11-dev \
    libxt-dev \
    perl \
    tcl-dev \
    tk-dev \
    texinfo \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-recommended \
    texlive-latex-extra \
    x11proto-core-dev \
    xauth \
    xfonts-base \
    xvfb \
    zlib1g-dev" \
  && apt install -y --no-install-recommends $BUILDDEPS \
  && cd tmp/ \
  ## Download source code
  && curl -O https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz \
  ## Extract source code
  && tar -xf R-${R_VERSION}.tar.gz \
  && cd R-${R_VERSION} \
  ## Set compiler flags
  && R_PAPERSIZE=letter \
    R_BATCHSAVE="--no-save --no-restore" \
    R_BROWSER=xdg-open \
    PAGER=/usr/bin/pager \
    PERL=/usr/bin/perl \
    R_UNZIPCMD=/usr/bin/unzip \
    R_ZIPCMD=/usr/bin/zip \
    R_PRINTCMD=/usr/bin/lpr \
    LIBnn=lib \
    AWK=/usr/bin/awk \
    CFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
    CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g" \
  ## Configure options
  ./configure --enable-R-shlib \
               --enable-memory-profiling \
               --with-readline \
               --with-blas \
               --with-lapack \
               --with-tcltk \
               --disable-nls \
               --with-recommended-packages \
  ## Build and install
  && make \
  && make install \
  && make clean \
  # -- Tests for R installation - should not be included into the final image --
  # && make install-tests \
  # && cd /usr/local/lib/R/tests \
  # && ../bin/R CMD make check \
  # -- end --
  ## Add a library directory (for user-installed packages)
  && mkdir -p /usr/local/lib/R/site-library \
  && chown root:staff /usr/local/lib/R/site-library \
  && chmod g+ws /usr/local/lib/R/site-library \
  ## Fix library path
  && sed -i '/^R_LIBS_USER=.*$/d' /usr/local/lib/R/etc/Renviron \
  && echo "R_LIBS_USER=\${R_LIBS_USER-'/usr/local/lib/R/site-library'}" >> /usr/local/lib/R/etc/Renviron \
  && echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /usr/local/lib/R/etc/Renviron \
  ## Set configured CRAN mirror -> happens in r-base layer
  # && MRAN=https://mran.microsoft.com/snapshot/${BUILD_DATE} \
  # && echo MRAN=$MRAN >> /etc/environment \
  # && export MRAN=$MRAN \
  # && echo "options(repos = c(INWTRAN = 'https://cran.inwt-statistics.de/${BUILD_DATE}'))" >> /usr/local/lib/R/etc/Rprofile.site \
  # && echo "options(repos = c(getOption('repos'), CRAN='$MRAN'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site \
  ## Clean up from R source install
  && cd / \
  && rm -rf /tmp/* \
  && apt remove --purge -y $BUILDDEPS \
  && apt autoremove -y \
  && apt autoclean -y \
  && rm -rf /var/lib/apt/lists/*

CMD ["R"]
