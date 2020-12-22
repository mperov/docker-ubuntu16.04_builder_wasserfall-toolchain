## Ubuntu 16.04 Dockerfile

<p align="left">
    <a href="https://github.com/mperov/docker-ubuntu16.04_builder_wasserfall-toolchain/graphs/contributors" alt="Contributors">
        <img alt="Contributors" src="https://img.shields.io/github/contributors/mperov/docker-ubuntu16.04_builder_wasserfall-toolchain?label=Contributors">
    </a>
</p>

This repository contains **Dockerfile** of [Ubuntu](http://www.ubuntu.com/) for creating container which can simplify building of gcc-newlib toolchain for Wasserfall processor.

### Base Docker Image

* [ubuntu:16.04](https://hub.docker.com/_/ubuntu)

### Installation

1. Install [Docker](https://www.docker.com/)
2. Clone repo - `git clone https://github.com/mperov/docker-ubuntu16.04_builder_wasserfall-toolchain.git`
3. `cd docker-ubuntu16.04_builder_wasserfall-toolchain/`
4. Build Docker image - `docker build --build-arg GitLabLogin='your login' --build-arg GitLabPassword='your password' -t mperov/ubuntu16.04_builder_wasserfall-toolchain .`
**Don't worry!** Your **password** is needed for cloning toolchain. You can check this in Dockerfile!
5. Check built image - `docker images`

### Usage

To get installer and uninstaller:

```console
docker cp `docker create ubuntu16.04_builder_wasserfall-toolchain`:/root/risc-v_toolchain_installer.sh .
docker cp `docker create ubuntu16.04_builder_wasserfall-toolchain`:/root/risc-v_toolchain_uninstaller.sh .
```

For trying toolchain or rebuilding it you may run container:
    
    docker run -it --rm mperov/ubuntu16.04_builder_wasserfall-toolchain
    
### Troubleshooting

If your GitLab login and/or password contains special symbols, e.g. @, you may use hex code instead of special symbol. For example, special symbol @ is 0x40 in hex code.

So, in your password use %40 instead of @ - `GitLabPassword='p%40ssword'` instead of `GitLabPassword='p@ssword'`

What about other symbols? You can get hex code from ASCII table!
