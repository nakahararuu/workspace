FROM ubuntu:20.04

# basic packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt-get install -y sudo build-essential curl git language-pack-ja language-pack-en

# lang
ENV LANG=ja_JP.UTF8

# user
ARG PUID=1000
ARG PGID=1000 
RUN groupadd -g ${PGID} docker-user && \
    useradd -u ${PUID} -g docker-user -m docker-user  && \
    echo "docker-user     ALL=(ALL)        NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Set disable_coredump false" >> /etc/sudo.conf
USER docker-user

# LinuxBrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
ENV PATH $PATH:/home/linuxbrew/.linuxbrew/bin/

# user packages & dot files
WORKDIR /home/docker-user
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nakahararuu/dotfiles/master/executable_bootstrap.sh)"

WORKDIR /workspace
ENTRYPOINT ["tmux"]
