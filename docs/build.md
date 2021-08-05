# How to Build This Resume

## Prerequisites

* [Make](https://www.gnu.org/software/make/)
* [Docker](https://docs.docker.com/get-docker/)

## Building with `Make`

1. Run `make` or `make run`

## What running `make` does

1. Build an image (`python-builder`) with installed python dependencies
1. Run `python-builder` against the `.tex` templates in `templates/`
   This populates the values in `resources/data.yml` into the template
1. Run `lualatex` against the generated tex file and outputs a `.pdf` file in `dist/`