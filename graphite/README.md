graphite-docker
=================

A Docker image for collectd and graphite.

Based on:

https://github.com/dotcloud/collectd-graphite

https://github.com/MailOnline/collectd-graphite

and

https://github.com/jeffutter/collectd-graphite-docker

Build:

```
docker build -t graphite github.com/ldoguin/graphite-docker
```

Run:
```
docker run -p 8080:8080 -p 25826:25826/udp graphite
```

With Persistience:

Extract the data somewhere:
```
docker run graphite tar -cvps -C /opt/graphite/storage ./ | tar -xv -C "/PATH/TO/GRAPHITE/STORAGE" -f -
```

Then run with:

```
docker run -v /PATH/TO/GRAPHITE/STORAGE:/opt/graphite/storage -p 8080:8080 -p 25826:25826/udp graphite
```
