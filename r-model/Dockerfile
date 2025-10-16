# ----------------
# Stage 1: builder
# ----------------
FROM inwt/r-batch:4.5.1.non-root AS model-builder

#1. User and Environment Setup
ARG USER_NAME=user

# 2. System Dependencies (Run as root)
USER root
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    libnode-dev \
    # Cleanup APT after install
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# 3. Install R Packages Installation
USER ${USER_NAME}
RUN installPackage rstan \
    && installPackage prophet \
    # Cleanup R build artifacts
    && rm -rf /tmp/downloaded_packages/*

# --------------
# Stage 2: final
# --------------
FROM inwt/r-batch:4.5.1.non-root

# 1. Environment and User Setup
ARG USER_NAME=user
ENV HOME=/app

# 2. Copy Artifacts from builder stage
COPY --from=model-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/

# 3. Set User and Workdir
USER ${USER_NAME}
WORKDIR /app
CMD ["R"]
