FROM rocker/r-ubuntu as base
RUN mkdir /dxafinal
WORKDIR /dxafinal

#renv package management
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
#default cache
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache
#restore package library
RUN R -e "renv::restore()"

