# finaldata550
# Code Description

`code/01_make_table_1.R`
- read in the simulated data and creates a demographic table
- saves table as a `.rds` object in `output/` folder

`code/02_make_adiposity_graph.R`
- uses adipose tissue measures to track change in adiposity over the course of one year
- saves a graph as a `.png` object in `output/` folder

`code/03_make_android_gynoid_graph.R`
- compares 2 centralized obesity measures and plots on a line graph
- saves a graph as a `.png` object in `output/` folder

`code/04_render_dxa_report.R`
- Renders dxafinalreportt.rmd from the command line. 

`dxafinalreport.Rmd`
- compiles an html report with the table and graphs provided in the code folder

## Build Docker Image
This project can be built in a containerized environment for reproducibility produces. We are using docker to do so. To build this image, on the command line, use the following command:

`docker build -t dxaimage .`
This should build properly.

## Build DXA final report
In the makefile, there is a rule denoting the sources necessary to build this cohesive report. There is a folder in the repository called `report`, and this is where the output of the report will be stored after building the image within the container. You will use the same code to do this as you would to build the docker image. 

`make report/dxareport.html`


## Synchronize Packages
This project uses the Renv R package management system to manage packages and ensure reproducibility. All packages are listed in `renv.lock`. The makefile includes a `make install` rule for ease of package synchronization across machines. To synchronize your system run the follwoing command on the command line: 

`make install`

## steps to generate the report
On my local machine, the relative file path starts at "finaldata550". This is the directory that contains the code, output, and clean_simulated_data folders, the makefile and the report. Remotely, this is the finaldata550 repository. In order to generate the report, you must use the makefile to build the report from the command line with the command "make dxafinalreport.html". In order to build this report, you will need to use the outputs from each of the listed scripts above (code/01-4_xyz.R), which can be found in the outputs folder. The code you will use on the commandline is:

`Make dxafinalreport.html`

## Contents of the report
This report contains one table and 2 graphs. The data used is DXA body composition data. This data given is simulated data and is in no way, shape, form representative of any person. Any resemblance to a specific person's measurements is purely coincidental. Table 1 contains demographic statistics. The 1st graph demonstrates the change in overall adipose tissue percentage over 1 year across participants. The last graph stratifies the general trend across participants in central mass adiposity change over a year by  key central obesity tendencies(in this case, Android and Gynoid percent fat tissue).



