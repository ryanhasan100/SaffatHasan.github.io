FROM miktex/miktex

RUN mpm --install=geometry
RUN apt-get update && apt-get install texlive-generic-extra

COPY archive /data
COPY archive /miktex/work