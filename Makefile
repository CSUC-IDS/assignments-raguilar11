all: gapminder_assignment

gapminder_assignment:

	Rscript -e "knitr::knit('gapminder_assignment.Rmd');/
  rmarkdown::render('gapminder_assignment.Rmd','html_document')"

clean:
	rm -rf *.md
	rm -rf *.html