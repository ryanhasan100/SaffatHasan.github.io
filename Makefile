IMAGE=zidizei/lualatex
# IMAGE=brokenpylons/lualatex

run:
	python src/main.py


build:
	docker build . -t latex

compile: build
	docker run -ti latex pdflatex resume.tex

debug: build
	docker run -ti -v "${PWD}:/data" -v "${PWD}:/miktex/work" latex sh
	# docker run --rm -it --user="$(id -u):$(id -g)" --net=none -v "${PWD}:/data" brokenpylons/lualatex sh #lualatex
