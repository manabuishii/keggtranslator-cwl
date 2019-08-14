FROM ubuntu:xenial
ENV VERSION=v2.5
RUN apt-get update -y && \
    apt-get install -y wget openjdk-8-jdk-headless
RUN cd / && \
    wget http://www.cogsys.cs.uni-tuebingen.de/software/KEGGtranslator/downloads/KEGGtranslator_${VERSION}.jar
