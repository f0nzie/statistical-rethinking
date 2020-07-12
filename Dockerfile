FROM rocker/rstudio:3.6.3


RUN apt-get -y update \
 && apt-get -y install  \
    libxml2-dev \
    libz-dev

# needed by V8, shape
# needed by extrafont, systemfonts
RUN apt-get -y update \
 && apt-get -y install  \
    libv8-dev \
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
  farver \
  gdtools \
  ghibli \
  gridExtra \
  ggrepel \
  GGally \
  ggthemes \
  ggbeeswarm \
  haven \
  hrbrthemes \
  igraph \
  logging \
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
  tibble \
  threejs \
  tidybayes \
  tidyverse \
  viridis \
  wesanderson \
  xml2

# Error: packages ‘systemfonts’, ‘lifecycle’ are not available (for R version 3.6.3)
# also fails in travis
# systemfonts will not be available for 3.6.3 until 2019-06-29
RUN install2.r --error --repo https://mran.microsoft.com/snapshot/2019-06-29 \
    systemfonts

# lifecycle will install after 2019-08-02
# Error: package ‘lifecycle’ is not available (for R version 3.6.3)
RUN install2.r --error --repo https://mran.microsoft.com/snapshot/2019-08-02 \
    lifecycle

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

