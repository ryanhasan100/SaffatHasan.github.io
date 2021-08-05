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

dist/resume-simple.tex: python-builder templates/resume-simple.tex resources/data.yml
	docker run -v "${PWD}:${WORKDIR}" python-builder resume-simple

dist/resume.tex: python-builder templates/resume.tex resources/data.yml
	docker run -v "${PWD}:${WORKDIR}" python-builder resume

dist/mcdowellcv.cls: resources/mcdowellcv.cls
	mkdir -p dist
	cp resources/mcdowellcv.cls dist/mcdowellcv.cls

python-builder: src/requirements.txt src/main.py
	docker build . -t python-builder

clean:
	@rm -rf dist/


