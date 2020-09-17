IMAGE=blang/latex:ubuntu
WORKDIR=/data

# while true; do make --silent; sleep 1; done

run: dist/resume-simple.pdf dist/resume.pdf
	@rm -f dist/*.log dist/*.aux dist/*.out

dist/resume-simple.pdf: dist/resume-simple.tex dist
	docker run -ti -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume-simple.tex > /dev/null

dist/resume.pdf: dist/resume.tex dist/mcdowellcv.cls
	docker run -ti -v "${PWD}/dist:${WORKDIR}" "${IMAGE}" lualatex resume.tex > /dev/null

dist/resume-simple.tex: src/main.py templates/resume-simple.tex
	python src/main.py

dist/resume.tex: src/main.py templates/resume.tex
	python src/main.py

dist/mcdowellcv.cls: archive/mcdowellcv.cls
	mkdir -p dist
	cp archive/mcdowellcv.cls dist/mcdowellcv.cls

debug:
	docker run -ti -v "${PWD}/:${WORKDIR}" python sh

compile-original:
	docker run -ti -v "${PWD}/archive:${WORKDIR}" "${IMAGE}" lualatex main.tex

venv: src/requirements.txt
	py -m venv venv
	venv/Scripts/pip install -r src/requirements.txt


clean:
	@rm -rf dist/


