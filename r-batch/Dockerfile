# ----------------
# Stage 1: builder
# ----------------
FROM inwt/r-base:4.5.1.non-root AS batch-builder

# 1. User and Enviroment Setup
ARG USER_NAME=user

# 2. System Dependencies
USER root

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    curl \
    openjdk-8-jdk \
    libbz2-dev \
    liblzma-dev \
    libmysqlclient-dev \
    libpcre3-dev \
    libpcre2-dev \
    libpq-dev \
    # AWS CLI
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.25.13.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    # Cleanup
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* aws awscliv2.zip

# 3. Configure Java & R Packages Installation
RUN R CMD javareconf
USER ${USER_NAME}
RUN installPackage \
    arrow \
    codetools \
    data.table \
    dplyr \
    futile.logger \
    gbm \
    ggplot2 \
    gridExtra \
    lintr \
    lme4 \
    mgcv \
    RClickhouse \
    rJava \
    RMySQL \
    roxygen2 \
    RPostgres \
    testthat \
    tidyr \
    dbtools \
    mctools \
    && rm -rf /tmp/downloaded_packages/*

# --------------
# Stage 2: final
# --------------
FROM inwt/r-base:4.5.1.non-root

# 1. Enviroment and User Setup
ARG USER_NAME=user

ENV HOME=/app

# 2. Copy Artifacts (R libaries & aws cli) from builder stage
COPY --from=batch-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/
USER root
COPY --from=batch-builder /usr/local/aws-cli/ /usr/local/aws-cli/
# create symlinks for aws cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws \
    && ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR ${HOME}

CMD ["R"]
