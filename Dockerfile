FROM ubuntu:22.04
# LABEL Maximiliano Suster <mxsstr93@gmail.com>

# -----------------------------------------------------------------------------
# Environment variables
# -----------------------------------------------------------------------------
# ENV GIT_EMAIL="mxsstr93@gmail.com" \
#     GIT_NAME="Maximiliano Suster"

ENV NODE_VERSION=14.15.0
ENV NPM_VERSION=9.7.1
ENV IONIC_VERSION=4

# -----------------------------------------------------------------------------
# Pre-install
# -----------------------------------------------------------------------------
RUN \
  dpkg --add-architecture i386 \
  && apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # tools
    curl \
    wget \
    zip \
    git \
    unzip ruby xdg-utils links links2 w3m nano dirmngr apt-transport-https lsb-release ca-certificates
# configure git
# RUN git config --global user.email "${GIT_EMAIL}"
# RUN git config --global user.name "${GIT_NAME}"

# Add terminal color scheme
RUN echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\u\[$(tput setaf 1)\] @ \[$(tput setaf 2)\]\h\[$(tput setaf 4)\] \w \[$(tput setaf 1)\]$ \[$(tput sgr0)\]"' >> ~/.bashrc
RUN . ~/.bashrc

# install node 12
# RUN \
#   curl -sL https://deb.nodesource.com/setup_14.x | bash -

# RUN \
# DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
#   node npm 
#   #gcc g++ make


RUN \
  apt-get update -qqy \
  && curl --retry 3 -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
  && npm install -g npm@"$NPM_VERSION" \
  && npm install -g ionic@4.7.0 \
  && npm install -g @angular/cli@14.2.12
  



EXPOSE 8100 
WORKDIR /app
CMD npm install && ionic serve

# -----------------------------------------------------------------------------
# Clean up
# -----------------------------------------------------------------------------
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*