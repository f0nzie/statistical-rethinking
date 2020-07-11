#!/bin/bash


BOOK_DIR=${PWD}/original_book

docker run --rm -p 8787:8787 \
    -v /home/msfz751/docker-share/kurtz:/home/rstudio/share  \
    -e USERID=$UID -e PASSWORD=kurtz \
     -v $BOOK_DIR:/home/rstudio/book \
    f0nzie/kurtz-rethinking
