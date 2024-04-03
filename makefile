dxafinalreport.html: dxafinalreport.Rmd code/04_render_dxa_report.R \
	output/table_one.rds \
	output/02_adiposity_graph.png \
	output/03_android_gynoid_graph.png
	
	Rscript code/04_render_dxa_report.r
	
.PHONY: install
install: 
  Rscript -e "renv::restore(prompt=FALSE)"
	