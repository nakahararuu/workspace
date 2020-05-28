FROM ubuntu

# packages
RUN apt update && \
    apt-get install -y \ 
        sudo build-essential curl wget file git tmux vim parallel gawk \
        openjdk-11-jdk apt-utils software-properties-common
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt update && \
    apt-get install -y fish
RUN wget https://github.com/twpayne/chezmoi/releases/download/v1.5.5/chezmoi_1.5.5-852_linux_amd64.deb && \
    apt-get install ./chezmoi_1.5.5-852_linux_amd64.deb && \
    rm chezmoi_1.5.5-852_linux_amd64.deb

# user
ARG PUID=1000
ARG PGID=1000 

RUN groupadd -g ${PGID} docker-user && \
    useradd -u ${PUID} -g docker-user -m docker-user  && \
    usermod docker-user -s /usr/bin/fish && \
    echo "docker-user     ALL=(ALL)        NOPASSWD: ALL" >> /etc/sudoers
USER docker-user

# space vim & fisher
RUN  curl -sLf https://spacevim.org/install.sh | bash && \
     curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# dot files
RUN mkdir -p ~/.config/chezmoi && \
    echo '\
[data]\n\
    [data.git]\n\
        email = "docker-user@example.com"\n\
	      user= "docker-user"\
' > ~/.config/chezmoi/chezmoi.toml
RUN chezmoi init --apply --verbose https://github.com/nakahararuu/dotfiles.git

# tmux plugins
# see https://github.com/tmux-plugins/tpm/issues/6
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
    tmux start-server && \
    tmux new-session -d && \
    sleep 1 && \
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
    tmux kill-server

WORKDIR /workspace
ENTRYPOINT ["tmux"]
