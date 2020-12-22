# base image
FROM ubuntu:16.04

MAINTAINER Maksim Perov

ARG GitLabLogin
ARG GitLabPassword

# add file to image
ADD root/.gitconfig /root/.gitconfig
ADD root/install-systemc /root/install-systemc

# installing
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev openjdk-8-jdk && \
  apt-get install -y gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev cmake && \
  apt-get install -y libpixman-1-dev libmpc3 libc6 lib32stdc++-4.8-dev libfdt-dev libglib2.0-dev libfdt-dev libusb-1.0-0-dev && \
  apt-get install -y sudo git htop man vim wget coreutils && \
  rm -rf /var/lib/apt/lists/* && \
  chmod +x /root/install-systemc && \
  /root/install-systemc && \
  git clone --recursive https://$GitLabLogin:$GitLabPassword@pass.mipt.ru:2443/coder/wasserfall-toolchain.git /root/wasserfall-toolchain && \
  cd /root/wasserfall-toolchain/ && git checkout wasserfall && \
  git submodule update --init --recursive && \
  ./configure --prefix=/opt/wasserfall-riscv --enable-multilib --with-arch=rv64imac --with-abi=lp64 && \
  make -j`nproc` && \
  cd /root/wasserfall-toolchain/installer/ && \
  ./builder.sh /root/wasserfall-toolchain/ /opt/wasserfall-riscv/ && \
  mv /root/wasserfall-toolchain/installer/risc-v_toolchain_installer.sh /root/ && \
  mv /root/wasserfall-toolchain/installer/risc-v_toolchain_uninstaller.sh /root/

# environment variables
ENV HOME /root

# working directory
WORKDIR /root

# default command
CMD ["bash"]
