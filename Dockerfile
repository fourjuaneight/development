FROM ubuntu:20.04

# Setup environment
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US

# Get the necessary build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev

# Move utility scripts
WORKDIR /
COPY util ./

# Install apt binaries
RUN bash apt.sh

# Install brew binaries
RUN bash brew.sh

# Setup the environment
RUN bash setup.sh

# Install custom fonts
RUN bash fonts.sh

# Install rust crates
RUN bash cargo.sh

# Install go binaries
RUN bash go.sh

# Install npm packages
RUN bash npm.sh

# Install pip packages
RUN bash pip.sh
