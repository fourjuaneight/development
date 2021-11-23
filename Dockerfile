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
COPY util/apt.sh ./

# Install apt binaries
RUN bash apt.sh

# Set user
RUN useradd -ms /bin/bash node
USER node
WORKDIR /home/node
COPY util ./

# Install brew binaries
RUN bash brew.sh

# Set zsh as default shell
RUN chsh -s $(which zsh)

# Setup dotfiles
COPY homedir ./homedir
RUN stow homedir

# Setup the environment
RUN bash setup.sh

# Install custom fonts
COPY fonts ./fonts
RUN bash fonts.sh

# Install rust crates
RUN bash cargo.sh

# Install npm global packages
RUN bash npm.sh

# Install pip packages
RUN bash pip.sh

# Load shell
CMD [ "/bin/zsh" ]
