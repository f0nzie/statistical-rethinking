# kurtz-rethinking bookdown

[toc]

## Bookdown details
* R-3.6.3
* RStudio 1.2.5042
* MRAN dated on `2019-06-12`



## Build and run

### Build container

Build with:

```
docker build  -f Dockerfile -t f0nzie/kurtz-rethinking .
```



### Run container

```
docker run --rm -p 8787:8787 -v /home/msfz751/docker-share/kurtz:/home/rstudio/share  -e USERID=$UID -e PASSWORD=kurtz f0nzie/kurtz-rethinking
```

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