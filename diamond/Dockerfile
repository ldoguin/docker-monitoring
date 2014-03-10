# Docker image containing the Diamond collector
#
# VERSION               0.0.1

FROM      ubuntu:precise
MAINTAINER Laurent Doguin <ldoguin@nuxeo.com>


# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y python-software-properties wget sudo net-tools

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN add-apt-repository ppa:nils-nm/ppa-diamond


RUN apt-get update
RUN apt-get install -y vim diamond  python-psycopg2
ADD diamond /etc/diamond/

