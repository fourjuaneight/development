FROM ubuntu:20.04

# Setup environment
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

# Get the necessary build tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    bash \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev \
    stow \
    zsh

# Move utility scripts
WORKDIR /
COPY util ./

# Install apt binaries
RUN bash apt.sh

# Install brew binaries
RUN bash brew.sh

# Set zsh as default shell
RUN chsh -s $(which zsh)

# Set user
RUN useradd -ms /bin/bash node
USER node
WORKDIR /home/node
COPY util ./

# Install rust crates
RUN bash cargo.sh

# Setup dotfiles
COPY homedir ./

# Setup the environment
RUN bash setup.sh

# Install custom fonts
COPY fonts ./fonts
RUN bash fonts.sh

# Install npm global packages
RUN bash npm.sh

# Install pip packages
RUN bash pip.sh

# Load shell
CMD [ "/bin/zsh" ]
