# Makefile to convert markdown poems to PDF
SHELL=/usr/bin/env /bin/bash

all:	compile_all send
one:	compile_one send

send:	send_zamok
send_zamok:
	-CP --exclude=.git --exclude=output ./ ${Szam}publis/Chasse-aux-tresors-au-Musee-des-Beaux-Arts-pour-mes-26-ans.git/
	-CP --exclude=.git ./output/*.pdf ${Szam}publis/Chasse-aux-tresors-au-Musee-des-Beaux-Arts-pour-mes-26-ans.git/

compile_all:	clean alltex all_pdf clean
compile_one:	clean alltex main.pdf clean
main.pdf:
	-./prebuild.sh
	-pdflatex main.tex
	-pdflatex main.tex
	-pdflatex main.tex

all_pdf:
	-./prebuild.sh
	-./build.sh

clean:
	-mv -vf src/*.tex src/*.aux *.aux *.bbl *.blg *.brf *.dvi *.fdb_latexmk *.fls *.synctex.gz *.haux *.hidx *.htmp *.htoc *.idv *.idx *.ilg *.ind *.lg *.lof *.log *.lot *.meta *.nav *.out *.ps *.snm *.tid *.tmp *.tms *.toc *.vrb /tmp/

.SUFFIXES:
.SUFFIXES: .md .tex

CONTENT_MARKDOWN=$(wildcard src/*.md)
CONTENT_TEX=$(CONTENT_MARKDOWN:.md=.tex)

list_md:
	echo $(CONTENT_MARKDOWN)
list_tex:
	echo $(CONTENT_TEX)

alltex:	$(CONTENT_TEX)

%.tex:	%.md
	pandoc --from=markdown+escaped_line_breaks+yaml_metadata_block -N --to=latex --template=my.latex -o "$@" "$<"
# .md.tex:
# 	pandoc -t latex -o "$@" "$<"
