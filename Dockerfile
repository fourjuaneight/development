FROM ubuntu:20.04

# Setup environment
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin
ENV OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
ENV OPENSSL_INCLUDE_DIR=/usr/include/openssl
ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

# Get the necessary build tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    bash \
    build-essential \
    curl \
    git-all \
    install-info \
    libssl-dev \
    libffi-dev \
    pkg-config \
    python3 \
    python3-pip \
    wget \
    zsh

# Set user
RUN useradd -ms /bin/bash node
USER node
WORKDIR /home/node
COPY homedir/.bashrc ./.bashrc

# Move utility scripts
USER root
WORKDIR /
COPY util ./

# Install apt binaries
RUN bash apt.sh

# Install brew binaries
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN bash brew.sh

# Install Go
RUN wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz

# Set zsh as default shell
RUN chsh -s $(which zsh)

# Set user
USER node
WORKDIR /home/node
COPY util ./

# Install rust crates
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
RUN bash cargo.sh

# Install custom fonts
COPY fonts ./fonts
USER root
RUN bash fonts.sh

# Install npm global packages
USER node
RUN bash npm.sh

# Install pip packages
RUN bash pip.sh

# Install Vim plug
RUN curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup dotfiles
COPY homedir ./

# Install zsh plugins via sheldon
USER root
RUN chown node /home/node/.sheldon
RUN chown node /home/node/.config
USER node
RUN bash sheldon.sh

# Move zsh plugins to correct directory
RUN mv /home/node/.sheldon /home/node/.config/sheldon

# Load shell
CMD [ "/bin/zsh" ]
