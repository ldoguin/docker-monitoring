docker-monitoring
=================

Docker images used to test monitoring

Let's start by building the images:

    cd nuxeobase
    docker build -t nuxeo/nuxeobase .
    cd ../nuxeo
    docker build -t nuxeo/nuxeo .
    cd ../graphite
    docker build -t nuxeo/graphite .
    cd ../diamondBuild
    docker build -t nuxeo/diamond .

Then you can start your containers.

Start the graphite container:

    docker run -p 8080:8080 -p 2030:2030 -p 2040:2040 -P -d nuxeo/graphite

Start the nuxeo container:

    docker run -p 80:80 -P -d -name nuxeoServer nuxeo/nuxeo

Start the diamond container:

    docker run -d -v /proc:/host_proc:ro  -link  nuxeoServer:nuxeo -name collector nuxeo/diamond

Now with this particular setup you should have your graphite instance available on port 8080 of your host and Nuxeo available on port 80.
