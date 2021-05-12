slides.html: slides.Rmd
	Rscript -e "rmarkdown::render('slides.Rmd')"
