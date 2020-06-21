FROM ubuntu:20.04

# create docker-user
ARG PUID=1000
ARG PGID=1000 
RUN groupadd -g ${PGID} docker-user && \
    useradd -u ${PUID} -g docker-user -m docker-user 

# packages for all users
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt-get install -y \ 
        build-essential curl file git sudo \
        language-pack-ja language-pack-en \
        software-properties-common apt-utils 

# packages for docker-user 
USER docker-user
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew && \
    mkdir ~/.linuxbrew/bin && \
    ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin && \
    eval $(~/.linuxbrew/bin/brew shellenv) && \
    brew install tmux vim parallel gawk wget openjdk@11 fish tmux-xpanes chezmoi

# space vim & fisher
RUN  curl -sLf https://spacevim.org/install.sh | bash && \
     curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# dot files
COPY default_chezmoi.toml /home/docker-user/.config/chezmoi/chezmoi.toml
RUN chezmoi init --apply --verbose https://github.com/nakahararuu/dotfiles.git

# tmux plugins
# see https://github.com/tmux-plugins/tpm/issues/6
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
    tmux start-server && \
    tmux new-session -d && \
    sleep 1 && \
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
    tmux kill-server

# lang
ENV LANG=ja_JP.UTF8

COPY start.sh /tmp/
WORKDIR /workspace
ENTRYPOINT ["fish"]
