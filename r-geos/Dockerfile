# -------------------
# Setup (Global Args)
# -------------------
ARG R_VERSION=4.5.1.non-root
ARG USER_NAME=user

# ----------------
# Stage 1: builder
# ----------------
FROM inwt/r-batch:${R_VERSION} AS geos-builder

# 1. User and Environment Setup
ARG USER_NAME

# 2. System Dependencies (Run as root)
USER root
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libudunits2-dev \
    # Cleanup APT after install
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# 3. Install R Packages Installation
USER ${USER_NAME}
RUN installPackage \
    geojsonsf \
    raster \
    R.utils \
    sf \
    stars \
    terra \
    unix \
    # Cleanup R build artifacts
    && rm -rf /tmp/downloaded_packages/*

# --------------
# Stage 2: final
# --------------
FROM inwt/r-batch:${R_VERSION}

LABEL org.opencontainers.image.authors="Sebastian Warnholz, Jan Abel" \
      org.opencontainers.image.created="BUILD_DATE_TIME_PLACEHOLDER" \
      org.opencontainers.image.description="Build upon inwt/r-batch for geospatial data processing with GDAL" \
      org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.revision="GIT_SHA_PLACEHOLDER" \
      org.opencontainers.image.source="https://github.com/INWTlab/r-docker" \
      org.opencontainers.image.title="inwt/r-geos" \
      org.opencontainers.image.vendor="INWT Statistics" \
      org.opencontainers.image.version="${R_VERSION}"

# 1. Environment and User Setup
ARG USER_NAME
ENV HOME=/app

# 2. Copy Artifacts from builder stage
COPY --from=geos-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR /app
CMD ["R"]
