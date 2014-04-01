# Kibana image started from arcus-io/docker-kibana

FROM base
MAINTAINER ldoguin
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nginx-full unzip
RUN (cd /tmp && wget --no-check-certificate http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip -O pkg.zip && unzip pkg.zip && cd kibana-* && cp -rf ./* /usr/share/nginx/www/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD run.sh /usr/local/bin/run

EXPOSE 80
CMD ["/usr/local/bin/run"]

