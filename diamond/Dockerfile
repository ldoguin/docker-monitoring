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

RUN apt-get update
RUN apt-get install -y vim  pbuilder python-mock python-configobj python-support cdbs python-psycopg2 git

RUN git clone https://github.com/ldoguin/Diamond/

WORKDIR /Diamond
RUN make builddeb
RUN sudo dpkg -i build/diamond_*_all.deb
ADD diamond /etc/diamond/
ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD exec /usr/bin/diamond  -f
