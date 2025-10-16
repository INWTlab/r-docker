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

# 1. Environment and User Setup
ARG USER_NAME
ENV HOME=/app

# 2. Copy Artifacts from builder stage
COPY --from=geos-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR /app
CMD ["R"]
