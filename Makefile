# makefile pro preklad LaTeX verze Bc. prace
# makefile for compilation of the thesis
# (c) 2008 Michal Bidlo
# E-mail: bidlom AT fit vut cz
# Edited by: dytrych AT fit vut cz
#===========================================
CO=projekt

all: $(CO).pdf

pdf: $(CO).pdf

presentation: $(CO)-presentation.pdf

%.pdf: clean
	pdflatex $(basename $@)
	-bibtex $(basename $@)
	# makeglossaries $(basename $@)
	# makeglossaries-lite $(basename $@)
	pdflatex $(basename $@)
	pdflatex $(basename $@)

%.ps: %.dvi
	dvips $(basename $@)

%.dvi: %.tex %.bib
	latex $(basename $@)
	-bibtex $(basename $@)
	latex $(basename $@)
	latex $(basename $@)

clean:
	rm -f *.dvi *.log $(CO)*.blg $(CO)*.bbl $(CO)*.toc *.aux $(CO)*.out $(CO)*.lof $(CO)*.ptc $(CO)*.nav $(CO)*.snm 
	rm -f *~

clean-all: clean
	rm -f $(CO).pdf $(CO)-presentation.pdf

pack:
	tar czvf $(CO).tar.gz *.tex *.bib *.bst ./template/* ./bib-styles/* ./figures/* zadani.pdf $(CO).pdf Makefile Changelog

# Use make rename NAME=new_name to rename the project
rename: clean
	-mv $(CO).pdf $(NAME).pdf
	-mv $(CO)-presentation.pdf $(NAME)-presentation.pdf
	-mv $(CO).tex $(NAME).tex
	-mv $(CO)-01-kapitoly-chapters.tex $(NAME)-01-kapitoly-chapters.tex
	-mv $(CO)-01-kapitoly-chapters-en.tex $(NAME)-01-kapitoly-chapters-en.tex
	-mv $(CO)-20-literatura-bibliography.bib $(NAME)-20-literatura-bibliography.bib
	-mv $(CO)-30-prilohy-appendices.tex $(NAME)-30-prilohy-appendices.tex
	-mv $(CO)-30-prilohy-appendices-en.tex $(NAME)-30-prilohy-appendices-en.tex
	-mv $(CO)-presentation.tex $(NAME)-presentation.tex
	-mv $(CO)-presentation-slides.tex $(NAME)-presentation-slides.tex
	-mv $(CO)-presentation-slides_en.tex $(NAME)-presentation-slides_en.tex
	sed -i "s/$(CO)-01-kapitoly-chapters/$(NAME)-01-kapitoly-chapters/g" $(NAME).tex
	sed -i "s/$(CO)-01-kapitoly-chapters-en/$(NAME)-01-kapitoly-chapters-en/g" $(NAME).tex
	sed -i "s/$(CO)-20-literatura-bibliography/$(NAME)-20-literatura-bibliography/g" $(NAME).tex
	sed -i "s/$(CO)-30-prilohy-appendices/$(NAME)-30-prilohy-appendices/g" $(NAME).tex
	sed -i "s/$(CO)-30-prilohy-appendices-en/$(NAME)-30-prilohy-appendices-en/g" $(NAME).tex
	sed -i "s/$(CO)-presentation-slides/$(NAME)-presentation-slides/g" $(NAME)-presentation.tex
	sed -i "s/$(CO)-presentation-slides_en/$(NAME)-presentation-slides_en/g" $(NAME)-presentation.tex
	sed -i "s/$(CO)/$(NAME)/g" Makefile
	
# Pozor, vlna neresi vse (viz popis.txt) / Warning - vlna is not solving all problems (see description.txt)
vlna:
	vlna -l $(CO)-*.tex

# Spocita normostrany / Count of standard pages
normostrany:
	echo "scale=2; `detex -n $(CO)-[01]*.tex | sed s/"^ *"/""/ | sed s/"^	*"/""/ | wc -c`/1800;" | bc

