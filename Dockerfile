FROM archlinux:latest

RUN pacman -Syy

RUN pacman -Syu --noconfirm pandoc wget make fontconfig ttf-liberation

RUN wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh

RUN echo "PATH=$PATH:/root/bin" > /root/.bashrc

RUN $HOME/bin/tlmgr install fontspec geometry ragged2e spreadtab fp xstring arydshln titlesec

RUN $HOME/bin/tlmgr install enumitem xunicode xltxtra hyperref polyglossia wallpaper footmisc

RUN $HOME/bin/tlmgr install tools realscripts

RUN mkdir /usr/src/project

CMD ["bash"]
