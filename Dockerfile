FROM ubuntu:latest

RUN apt-get -y update && apt-get -y upgrade && apt-get install  -y \
		git \
		curl \
		sudo 

RUN adduser --disabled-password --gecos '' nvimuser
RUN adduser nvimuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER nvimuser
WORKDIR /home/nvimuser

RUN sudo curl -LO https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
RUN sudo chmod u+x ./nvim.appimage
RUN sudo ./nvim.appimage --appimage-extract
RUN sudo ./squashfs-root/AppRun --version
RUN sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

ENTRYPOINT bash
