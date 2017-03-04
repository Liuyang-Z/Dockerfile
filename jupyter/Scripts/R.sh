#!/usr/bin/env bash

apt-get update
apt-get -y install libxml2-dev libssl-dev libcurl4-openssl-dev r-base libzmq3-dev wget git

echo ":: Now, installing R package."

Rscript -e 'install.packages("crayon", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("pbdZMQ", repos="https://cran.rstudio.com")'
Rscript -e 'install.packages("devtools", repos="https://cran.rstudio.com")'

Rscript -e "devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))"
Rscript -e "IRkernel::installspec()"

echo ":: Install R kernel for Jupyter Notebook successfully."
echo ":: Now restart the docker container."