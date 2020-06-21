# workspace
my workspace built on Docker container. see also nakahararuu/dotfiles

# usage 
```bash
vim chezmoi.toml
docker build --build-arg PUID=$(id -u) --build-arg PGID=$(id -g) -t my-workspace .
docker run -it -v ~/.ssh:/home/docker-user/.ssh -v $(pwd):/workspace my-workspace
```
