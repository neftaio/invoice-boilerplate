FROM archlinux:latest

RUN pacman -Syy
RUN pacman -Syu --noconfirm texlive-core pandoc 

COPY template.tex template.tex
COPY makefile makefile

CMD ["bash"]
