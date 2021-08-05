# This dockerfile is used to build the `python-builder`
# image which runs src/main.py against a templates/*.tex

FROM python:3.8-slim

WORKDIR /data

COPY src/requirements.txt .

RUN pip install -r requirements.txt

COPY src/main.py src/main.py

ENTRYPOINT ["python", "src/main.py"]