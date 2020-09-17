IMAGE=blang/latex:ubuntu
WORKDIR=/data

run: venv
	@venv/Scripts/python src/main.py
	@cp archive/mcdowellcv.cls dist/
	@docker run -ti -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume.tex &> /dev/null
	@docker run -ti -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume-simple.tex &> /dev/null
	@rm dist/*.log dist/*.aux dist/*.out dist/*.tex dist/*.cls
	@echo Resume generated in dist/output.pdf

debug:
	docker run -ti -v "${PWD}/:${WORKDIR}" python sh

compile-original:
	docker run -ti -v "${PWD}/archive:${WORKDIR}" "${IMAGE}" lualatex main.tex

.PHONY: venv
venv:
	py -m venv venv
	venv/Scripts/pip install -r src/requirements.txt


clean:
	@rm -rf dist/


