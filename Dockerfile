FROM archlinux:latest

RUN pacman -Syy

RUN pacman -Syu --noconfirm texlive-core pandoc 

RUN mkdir /usr/src/project

CMD ["bash"]
