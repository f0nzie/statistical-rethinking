FROM rocker/rstudio:3.6.3


RUN apt-get -y update \
 && apt-get -y install  \
    libxml2-dev \
    libz-dev

# needed by V8, shape
RUN apt-get -y update \
 && apt-get -y install  \
    libv8-dev 

# needed by extrafont, systemfonts
RUN apt-get -y update \
 && apt-get -y install  \
    libfontconfig1-dev \
    libcairo2-dev

# Set date on MRAN
# Install R packages
RUN install2.r --error --repo https://mran.microsoft.com/snapshot/2019-06-12 \
  bayesplot \
  bookdown \
  brms \
  BH \
  broom \
  dagitty \
  extrafont \
  gdtools \
  ghibli \
  gridExtra \
  ggrepel \
  GGally \
  ggthemes \
  ggbeeswarm \
  haven \
  igraph \
  loo \
  Matrix \
  MCMCglmm \
  mapproj \
  pacman \
  psych \
  rstan \
  rcartocolor \
  shape \
  shinystan \
#  systemfonts \
  tibble \
  threejs \
  tidybayes \
  tidyverse \
  viridis \
  wesanderson \
  xml2

RUN install2.r --error \
    systemfonts \
    farver \
    lifecycle

RUN install2.r --error --repo https://mran.microsoft.com/snapshot/2019-06-12 \
  hrbrthemes \
  logging 


# COPY hrbrthemes /home/rstudio/pkg/hrbrthemes
COPY fiftystater /home/rstudio/pkg/fiftystater
COPY dutchmasters /home/rstudio/pkg/dutchmasters
COPY rethinking /home/rstudio/pkg/rethinking
COPY scales /home/rstudio/pkg/scales

# RUN Rscript -e "install.packages('/home/rstudio/pkg/hrbrthemes', repos = NULL, type='source')"
RUN Rscript -e "install.packages('/home/rstudio/pkg/fiftystater', repos = NULL, type='source')"
RUN Rscript -e "install.packages('/home/rstudio/pkg/dutchmasters', repos = NULL, type='source')"
RUN Rscript -e "install.packages('/home/rstudio/pkg/rethinking', repos = NULL, type='source')"
RUN Rscript -e "install.packages('/home/rstudio/pkg/scales', repos = NULL, type='source')"


# COPY original_book /home/rstudio/original_book
# RUN chmod a+rwx -R /home/rstudio/original_book
