# kurtz-rethinking bookdown

This book was written by Solomon Kurtz which code lives [here](https://github.com/ASKurz/Statistical_Rethinking_with_brms_ggplot2_and_the_tidyverse). It is a beautiful book on Bayesian regression in R using the [brms](https://statmodeling.stat.columbia.edu/2017/01/10/r-packages-interfacing-stan-brms/) package. Based on the book *"Statistical Rethinking"* by Richard McElreath, a Bayesian Course with examples in R and Stan. 


## Bookdown details
* Book version `1.0.1`. See `index.Rmd`.
* R-3.6.3
* RStudio 1.2.5042
* Most packages MRAN dated on `2019-06-12`. Other packages dated at later dates for smnoother book building.


## Build and run

### Build container

Build with:

```
docker build  -f Dockerfile -t f0nzie/kurtz-rethinking .
```


### Run container

```
docker run --rm -p 28787:8787 -v /home/msfz751/docker-share/kurtz:/home/rstudio/share  -e USERID=$UID -e PASSWORD=kurtz f0nzie/kurtz-rethinking
```

Then open RStudio in your browser with 127.0.0.1:28787, with `rstudio` and `kurtz` user id and password.

> **Note**. We will replace this a script that also shares the `book` folder. See below.


### Build book

```
Rscript -e 'bookdown::render_book(input = "index.Rmd", output_format = "bookdown::gitbook", output_dir = "public", clean_envir = FALSE)'
```

> **Note**. We will replace this with a script. See below.



## Scripts

### `run_docker.sh`

We want to share the `book` folder with the container and the host so any changes made from the container are reflected on the original book.

*   `BOOK_DIR=${PWD}/original_book`: folder where the book is located
*   `-v $BOOK_DIR:/home/rstudio/book `: the volume to share will be found under `book` in the `rstudio` folder

```
#!/bin/bash

BOOK_DIR=${PWD}/original_book

docker run --rm -p 8787:8787 \
    -v /home/msfz751/docker-share/kurtz:/home/rstudio/share  \
    -e USERID=$UID -e PASSWORD=kurtz \
     -v $BOOK_DIR:/home/rstudio/book \
    f0nzie/kurtz-rethinking
```



### `build_book.sh`

This script is located under the `book` folder. It will delete the temporary folder `_bookdown_files/` and the `public` folder before starting a new compilation.

```
#!/bin/sh
# we assume we are sharing the book folder between host and container
# remove output folder
rm -rf _bookdown_files/
rm -rf public/

# build boon on public folder
Rscript -e 'bookdown::render_book(input = "index.Rmd", output_format = "bookdown::gitbook", output_dir = "public", config_file = "_bookdown.yml", clean_envir = FALSE)'
```




## Dependencies



### Not in CRAN or MRAN

Install these packages with:

```
COPY pkg1 /home/rstudio/pkg/pkg1
RUN Rscript -e "install.packages('/home/rstudio/pkg/pkg1', repos = NULL, type='source')"
```

*   fiftystater

*   dutchmasters

*   rethinking

*   scales

### Packages in CRAN and MRAN

Install all these package swith:

```
RUN install2.r --error --repo https://mran.microsoft.com/snapshot/2019-06-12 \
	pkg1 pkg2 ... pkgn
```



*   bayesplot 
*   bookdown 

-   brms 
-   BH 
-   broom 
-   dagitty 
-   extrafont 
-   gdtools 
-   ghibli 
-   gridExtra 
-   ggrepel 
-   GGally 
-   ggthemes 
-   ggbeeswarm 
-   haven 
-   igraph 
-   loo 
-   Matrix 
-   MCMCglmm 
-   mapproj 
-   pacman 
-   psych 
-   rstan 
-   rcartocolor 
-   shape 
-   shinystan 
-   tibble 
-   threejs 
-   tidybayes 
-   tidyverse 
-   viridis 
-   wesanderson 
-   xml2
-   systemfonts 
-   farver 
-   lifecycle
-   hrbrthemes
-   logging 

## Build book from Travis

[6.4 Travis + GitHub Pages](https://musing-aryabhata-b16338.netlify.app/travis-ghpages.html) from book "bookdown: Authoring Books and Technical Documents with R Markdown" by Yihui Xie

> *"Since this Travis service is primarily for checking R packages, you will need a (fake) DESCRIPTION file as if the book repository were an R package. You may use the command line to enter touch DESCRIPTION (or in R: file.create('DESCRIPTION')). The only thing in this file that really matters for a bookdown project is the specification of dependencies. Here a dependency corresponds to a package that you plan to use in your book. If a dependency is on CRAN or BioConductor, you first list it in the Imports field of the DESCRIPTION file; this is equivalent to Travis running library(<PACKAGE>) before building your book. If it is a package on GitHub, you will need to include the USER/REPO in the Remotes field (equivalent to devtools::install_github(<"PACKAGE">)), and add the package name to the Imports field as well (so GitHub packages will be listed in two places in this file)."*

