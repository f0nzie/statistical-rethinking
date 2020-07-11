#!/bin/sh
# we assume we are sharing the book folder between host and container
# remove output folder
rm -rf _bookdown_files/
rm -rf public/

# build boon on public folder
Rscript -e 'bookdown::render_book(input = "index.Rmd", output_format = "bookdown::gitbook", output_dir = "public", config_file = "_bookdown.yml", clean_envir = FALSE)'

# copy the book to the shared folder in the host
# cp -r _book_final/ ../share/
