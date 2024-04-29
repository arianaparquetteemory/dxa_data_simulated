# report-associated rules
dxafinalreport.html: dxafinalreport.Rmd code/04_render_dxa_report.R \
	output/table_one.rds \
	output/02_adiposity_graph.png \
	output/03_android_gynoid_graph.png
	
	Rscript code/04_render_dxa_report.r

code/04_render_dxa_report.r: dxafinalreport.Rmd

.PHONY: install
install: 
	Rscript -e "renv::restore(prompt=FALSE)"
	
	#Docker-associated rules
PROJECTFILES= 	output/table_one.rds \
	output/02_adiposity_graph.png \
	output/03_android_gynoid_graph.png\
    makefile \
    dxafinalreport.Rmd
	
	RENVFILES = renv/activate.R renv.lock
	
	# rule to build image 
dxaimage: Dockerfile $(PROJECTFILES) $(RENVFILES) 
	docker build -t dxaimage . 
	touch $@
	
	# rule to build final report in Docker
report/dxafinalreport.html: dxaimage 
    docker run -v "$$(pwd)/dxafinalreport:/report/dxafinalreport" dxaimage
