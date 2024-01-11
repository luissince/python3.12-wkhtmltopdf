# Use a base image of Ubuntu 20.04
FROM  ubuntu:20.04

# At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# Label the image with the version
LABEL version="1.1.0"

# Update the package list and install dependencies
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
        wget \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Add the deadsnakes repository and update
RUN add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update -y

# Install Python 3.12 and related tools
RUN apt-get install -y --no-install-recommends \
        python3.12 \
        python3.12-venv \
        python3.12-dev

# Download and install wkhtmltopdf
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb \
    && apt install ./wkhtmltox_0.12.6-1.focal_amd64.deb -y \
    && rm wkhtmltox_0.12.6-1.focal_amd64.deb

# Base directory
WORKDIR /app