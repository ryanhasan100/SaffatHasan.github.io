# How to Build This Resume

## Prerequisites

* [Make](https://www.gnu.org/software/make/)
* [Python3](https://www.python.org/downloads/)
* [Docker](https://docs.docker.com/get-docker/) OR LuaLatex (surprisingly nontrivial, docker is a much better alternative)

## Building with `Make`

1. Run `make`
2. ... That's it.

## What running `make` does

1. Create virtual python environment in `venv/` and install python dependencies
1. Run `python src/main.py` against the the `.tex` templates in `templates/`
   This populates the values in `resources/data.yml` into the template
1. Run `lualatex` against the generated tex file and outputs a `.pdf` file in `dist/`