FROM archlinux:latest

RUN pacman -Syy
RUN pacman -Syu texlive-core pandoc

COPY template.tex template.tex
COPY makefile makefile

CMD ["bash"]
