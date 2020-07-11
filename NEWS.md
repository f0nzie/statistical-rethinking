# NEWS
[toc]

## 20200711
* Change the MRAN date to 2020-06-12
* Copy `original_book` folder from cloned rtepository
* Group all CRAN packages in one layer to apply MRAN date
* Install `hrbrthemes` from MRAN
* Add package `logging`
* Do not copy `book` folder. We will share it from the host so any changes in the container are reflected on the shared hosted folder.
* Add a script `run_docker.sh` that run the container and shares the `book` folder
* Add a script `build_book.sh` under the `book` folder. It contains R commands to compile the book.
