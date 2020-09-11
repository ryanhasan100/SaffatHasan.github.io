IMAGE=zidizei/lualatex
# IMAGE=brokenpylons/lualatex

run:
	python resume/main.py

compile:
	docker run -i --rm -v "${PWD}/dist:/src" ${IMAGE} lualatex main.tex
