FROM ubuntu:latest

RUN apt-get -y update && apt-get -y upgrade && apt-get install  -y \
		git \
		curl \
		sudo \
		unzip \
		gcc \
		fzf \
		python3-pip

RUN adduser --disabled-password --gecos '' nvimuser
RUN adduser nvimuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

USER nvimuser
WORKDIR /home/nvimuser

#npm install
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
#yarn install
RUN sudo npm install --global yarn
#nvim appimage install
RUN sudo curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
RUN sudo chmod u+x ./nvim.appimage
RUN sudo ./nvim.appimage --appimage-extract
RUN sudo ./squashfs-root/AppRun --version
RUN sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# nvim plugin setup
RUN mkdir -p /home/nvimuser/.config/nvim/autoload
RUN sudo curl -fLo /home/nvimuser/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY ./init.vim ./plugins.vim ./coc-setup.vim /home/nvimuser/.config/nvim/
#COPY ./init.lua /home/nvimuser/.config/nvim/
COPY ./test.sh .
COPY ./index.js .
#COPY ./init.lua .
COPY entrypoint.sh /usr/local/bin
#RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN sudo chmod +x test.sh
#RUN sudo python3 -m pip install --user --upgrade pynvim
#RUN sudo pip3 install jedi
RUN nvim +PlugInstall +qall


#RUN sudo ./test.sh
RUN mkdir workspace
WORKDIR /home/nvimuser/workspace/

#RUN nvim 'CocInstall coc-json|qa'
#RUN [ "/bin/bash", "-c", "nvim -n -i NONE -es -S <(echo -e 'silent! CocInstall coc-json coc-tsserver')" ]


ENTRYPOINT bash
#ENTRYPOINT ["nvim", "$@"]
