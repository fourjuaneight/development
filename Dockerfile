FROM ubuntu:20.04

# Get the necessary build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev

# Set util scripts to be executable
RUN chmod +x ./utils/*.sh

# Install apt binaries
RUN ./utils/apt.sh

# Install brew binaries
RUN ./utils/brew.sh

# Setup the environment
RUN ./utils/setup.sh

# Install custom fonts
RUN ./utils/fonts.sh

# Install rust crates
RUN ./utils/cargo.sh

# Install go binaries
RUN ./utils/go.sh

# Install npm packages
RUN ./utils/npm.sh

# Install pip packages
RUN ./utils/pip.sh
