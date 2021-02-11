#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Install Python + Node.js and other stuff

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install \
    make \
    g++-4.8 \
    python2.7 \
    python-pip \
    python-dev \
    python3.5 \
    python3-pip \
    python3.5-dev \
    python-virtualenv \
    glpk-utils \
    openssh-server \
    sudo \
    default-jre \
    default-jdk \
    nodejs


# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV PASS=password
ENV USER=user

RUN groupadd -g 61000 $USER
RUN useradd -g 61000 -l -m -s /bin/false -u 61000 $USER
USER $USER

# Define working directory.
WORKDIR /home/$USER

# Define default command.
CMD ["bash"]
