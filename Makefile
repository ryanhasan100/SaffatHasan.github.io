IMAGE=blang/latex:ubuntu
WORKDIR=/data


run: dist/resume-simple.pdf dist/resume.pdf

watch:
	while true; do make --silent; sleep 1; done

resume: dist/resume.pdf
resume-simple: dist/resume-simple.pdf

dist/resume-simple.pdf: dist/resume-simple.tex dist
	docker run --rm -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume-simple.tex | tail -n2

dist/resume.pdf: dist/resume.tex dist/mcdowellcv.cls
	docker run --rm -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume.tex | tail -n2

dist/resume-simple.tex: src/main.py templates/resume-simple.tex resources/data.yml
	python src/main.py resume-simple

dist/resume.tex: src/main.py templates/resume.tex resources/data.yml
	python src/main.py resume

dist/mcdowellcv.cls: resources/mcdowellcv.cls
	mkdir -p dist
	cp resources/mcdowellcv.cls dist/mcdowellcv.cls

debug:
	docker run -ti -v "${PWD}/:${WORKDIR}" python sh

compile-original:
	docker run -ti -v "${PWD}/archive:${WORKDIR}" "${IMAGE}" lualatex main.tex

venv: src/requirements.txt
	py -m venv venv
	venv/Scripts/pip install -r src/requirements.txt


clean:
	@rm -rf dist/


