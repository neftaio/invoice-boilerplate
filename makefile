TEX = pandoc
src = template.tex details.yml
FLAGS = --pdf-engine=lualatex#xelatex
DOCKERTAG = neftaio/invoice-boilerplate
DOCKERIMAGE := $(shell docker images -q $(DOCKERTAG):latest)

output.pdf : $(src)
	$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS)

.PHONY: clean
clean :
	rm output.pdf

.PHONY: bydocker
bydocker :
ifeq ($(DOCKERIMAGE),)
	@echo Image not found, it will be created...
	$(MAKE) build
endif

	@echo Processing document

	docker run --rm -v "$(PWD)":/usr/src/project -w /usr/src/project $(DOCKERTAG) make

.PHONY: build
build:
	docker build -t $(DOCKERTAG) .

.PHONY: rmimg
rmimg:
	docker rmi $(DOCKERTAG)

	#docker run --rm -v "$PWD":/usr/src/project -w /usr/src/project make
