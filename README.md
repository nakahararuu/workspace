# workspace
my workspace built on Docker container. see also nakahararuu/dotfiles

# usage 
```bash
docker build --build-arg PUID=$(id -u) --build-arg PGID=$(id -g) -t my-workspace .
cp default_chezmoi.toml custom_chezmoi && vim custom_chezmoi.toml
docker run -it -v $(pwd)/custom_chezmoi.toml:/custom_chezmoi.toml -v ~/.ssh:/home/docker-user/.ssh -v $(pwd):/workspace my-workspace
```
