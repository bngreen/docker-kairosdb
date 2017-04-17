FROM java:8u92-jre-alpine

RUN apk --update add bash
RUN apk --update add curl

RUN mkdir /opt

# Install KAIROSDB
RUN cd /opt; \
  curl -L https://github.com/kairosdb/kairosdb/releases/download/v1.1.3/kairosdb-1.1.3-1.tar.gz | \
  tar zxfp -

ADD kairosdb.properties /opt/kairosdb/conf/kairosdb.properties

# Kairos API telnet and jetty ports
EXPOSE 4242 8083

# Set Kairos config vars
#ENV KAIROS_JETTY_PORT 8083
ENV CASSANDRA_HOST_LIST 10.1.2.3:9160

# Copy scripts into container to set kairos config params
ADD config-kairos.sh /usr/bin/config-kairos.sh

ADD wait-for-it.sh /usr/bin/wait-for-it.sh

# Run kairosdb in foreground on boot
CMD ["/usr/bin/config-kairos.sh"]
