IMAGE=blang/latex:ubuntu
WORKDIR=/data

run:
	@python src/main.py
	@docker run -ti -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex output.tex &> /dev/null
	@rm dist/*.log dist/*.aux dist/*.out dist/*.tex
	@echo Resume generated in dist/output.pdf

