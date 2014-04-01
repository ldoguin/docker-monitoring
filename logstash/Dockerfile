# Logstash image started from https://github.com/arcus-io/docker-logstash

FROM ubuntu:quantal
MAINTAINER ldoguin "ldoguin@nuxeo.com"

RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
# Small trick to Install fuse(libreoffice dependency) because of container permission issue. 
RUN apt-get -y install fuse || true
RUN rm -rf /var/lib/dpkg/info/fuse.postinst

RUN apt-get -y install fuse

RUN apt-get install -y wget openjdk-7-jdk
RUN apt-get install -y curl
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.0.beta2.tar.gz 
RUN tar zxvf logstash-1.4.0.beta2.tar.gz
RUN mv logstash-1.4.0.beta2 /opt/logstash

ADD run.sh /usr/local/bin/run
ADD logstash.conf /opt/logstash/logstash.conf

EXPOSE 514
EXPOSE 9200
EXPOSE 9292
EXPOSE 9300
CMD ["/usr/local/bin/run"]
