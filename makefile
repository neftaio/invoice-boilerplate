TEX = pandoc
src = template.tex details.yml
FLAGS = --pdf-engine=xelatex
DOCKERTAG = neftaio/invoice-boilerplate
DOCKERIMAGE := $(shell docker images -q $(DOCKERTAG):latest)

output.pdf : $(src)
	$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS)

.PHONY: clean
clean :
	rm output.pdf

.PHONY: compile
compile :
ifeq ($(DOCKERIMAGE),)
	@echo Image not found, it will be created...
	$(MAKE) build
endif

	@echo Processing document

	docker run --rm -v "$(PWD)":/usr/src/project -w /usr/src/project $(DOCKERTAG) make -f makefile-inner

.PHONY: process 
process:
	ls
	#$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS)


.PHONY: build
build:
	docker build -t $(DOCKERTAG) .

.PHONY: rmi
rmi:
	docker rmi $(DOCKERTAG)

.PHONY: bash
bash:
	docker run --rm  -v "$(PWD)":/usr/src/project -w /usr/src/project -it --entrypoint bash $(DOCKERTAG)

	#docker run --rm -v "$PWD":/usr/src/project -w /usr/src/project make
