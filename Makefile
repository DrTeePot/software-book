LATEX:=pdflatex
LATEXOPT:=--shell-escape
NONSTOP:=--interaction=nonstopmode

LATEXMK:=latexmk
LATEXMKOPT:=-pdf
CONTINUOUS:=-pvc

MAIN:=$(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
COMPILATION_FOLDER:=bin
DIST_FOLDER:=dist
SOURCE:=main.tex

SOURCES:=$(DIST_FOLDER) $(COMPILATION_FOLDER) $(SOURCE) Makefile 

all: $(SOURCE).pdf

.refresh:
	touch .refresh

$(DIST_FOLDER):
	mkdir ./dist

$(COMPILATION_FOLDER):
	mkdir ./bin

$(SOURCE).pdf: $(SOURCES)
	$(LATEXMK) $(LATEXMKOPT) \
		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(Q1) \
		-jobname=./$(COMPILATION_FOLDER)/$(SOURCE)
	mv ./$(COMPILATION_FOLDER)/$(SOURCE).pdf ./$(DIST_FOLDER)/$(SOURCE).pdf

clean:
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
	rm -rf $(COMPILATION_FOLDER)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force watch
