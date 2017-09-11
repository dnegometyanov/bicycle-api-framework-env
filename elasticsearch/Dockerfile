FROM openjdk:8

MAINTAINER Aboullaite Mohammed
ENV DEBIAN_FRONTEND noninteractive

ENV ELASTICSEARCH_VERSION 5.2.1
# Add esuser to avoid starting Elasticsearch as the root user.
RUN useradd -d /home/esuser -m esuser
WORKDIR /home/esuser

RUN mkdir /data

# Install Elastisearch
RUN \
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
tar xvzf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
rm -f elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
chown -R esuser:esuser elasticsearch-${ELASTICSEARCH_VERSION}

# Performance Tweaks
RUN echo "* - nofile 65535" >> /etc/security/limits.conf && \
    echo "* - memlock unlimited" >> /etc/security/limits.conf && \
    echo vm.max_map_count=262144 >> /etc/sysctl.conf && \
    echo vm.swappiness=0 >> /etc/sysctl.conf

ENV MAX_OPEN_FILES=65535
ENV MAX_LOCKED_MEMORY=unlimited

# elasticsearch.yml and Dockerfile are on same location
ADD elasticsearch.yml /home/esuser/elasticsearch-${ELASTICSEARCH_VERSION}/config/elasticsearch.yml
ENTRYPOINT elasticsearch-${ELASTICSEARCH_VERSION}/bin/elasticsearch