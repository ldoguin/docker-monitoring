# Nuxeo Platform
#
# VERSION               0.0.1

FROM      nuxeo/nuxeobase
MAINTAINER Laurent Doguin <ldoguin@nuxeo.com>

# Download latest LTS nuxeo version
RUN wget http://community.nuxeo.com/static/releases/nuxeo-5.8/nuxeo-cap-5.8-tomcat.zip && mv nuxeo-cap-5.8-tomcat.zip nuxeo-distribution.zip

ENV NUXEOCTL /var/lib/nuxeo/server/bin/nuxeoctl
ENV NUXEO_CONF /etc/nuxeo/nuxeo.conf

# Add postgresql Repository
RUN apt-add-repository "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
RUN wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update

# Install apache and ssh server 
RUN sudo apt-get install -y openssh-server apache2 postgresql-9.3
RUN mkdir -p /var/run/sshd

ADD supervisor_nuxeo.conf /etc/supervisor/conf.d/supervisor_nuxeo.conf
ADD nuxeo.apache2 /etc/apache2/sites-available/nuxeo
ADD postinst.sh /root/postinst.sh
ADD firstboot.sh /root/firstboot.sh
ADD entrypoint.sh /entrypoint.sh
ADD pgListener.py pgListener.py
RUN /root/postinst.sh
ADD pg_hba.conf /etc/postgresql/9.3/nuxeodb/pg_hba.conf

EXPOSE 22 80 5432
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

