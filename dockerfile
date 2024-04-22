FROM rocker/r-ubuntu as base
RUN mkdir /dxafinal
WORKDIR /dxafinal

RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libfribidi-dev
RUN apt-get install -y  libharfbuzz-dev libfribidi-dev
RUN apt-get install -y libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
RUN apt-get install -y libxml2-dev

#renv package management
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
#default cache
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache


#restore package library
RUN R -e "renv::restore()"

Run mkdir report

CMD make && mv dxafinalreport.html report




