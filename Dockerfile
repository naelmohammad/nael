# Dockerfile for building out django base packages with all objects and modules
# enabled from the base image.


#Set the base image
FROM ubuntu:latest

# Maintainers name
MAINTAINER Nael Mohammad

# Local directory with project source
ENV DOCKYARD_SRC=django
# Directory in container for all proejct files to make modifications.
ENV DOCKYARD_SRVHOME=/srv
# Directory for project source files.
ENV DOCKYARD_SRVPROJ=/srv/django

# Update default repository and packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python python-pip


#Create application subdirectory

WORKDIR $DOCYARD_SRVHOME
RUN mkdir media static logs
VOLUME ["$DOCKYARD_SRVHOME/media/", "$DOCKYARD_SRVHOME/logs/"]


# Copy source code to SRCDIR which is the source directory
COPY $DOCKYARD_SRC $DOCKYARD_SRVPROJ

#Install Python dependencies
RUN pip install -r $DOCKYARD_SRVPROJ/requirements.txt

# Port to expose
EXPOSE 8000


# Copy Entrypoint Script into the image

WORKDIR $DOCKYARD_SRVPROJ
COPY ./docker-entrpoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
