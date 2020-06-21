# workspace
my workspace built on Docker container. see also nakahararuu/dotfiles

# usage 
```bash
docker build --build-arg PUID=$(id -u) --build-arg PGID=$(id -g) -t my-workspace  .
docker run -it -e GIT_USER=your_user -e GIT_EMAIL=your_email -v ~/.ssh:/home/docker-user/.ssh -v $(pwd):/workspace my-workspace
```
