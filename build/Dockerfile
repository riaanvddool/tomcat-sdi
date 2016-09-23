FROM tomcat:8-jre8

MAINTAINER rvddool@csir.co.za

# Run Tomcat as the 'tomcat' user
RUN \
    groupadd -r tomcat -g 1000 && \
    useradd -u 1000 -r -g tomcat -d $CATALINA_HOME -s /bin/bash tomcat

# Tomcat user helpers
COPY settings/.bash_profile $CATALINA_HOME/.bash_profile
COPY settings/.bash_logout $CATALINA_HOME/.bash_logout

# Tomcat config
COPY settings/setenv.sh $CATALINA_HOME/bin/setenv.sh
COPY settings/server.xml $CATALINA_HOME/conf/server.xml
COPY settings/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

# Create a self-signed certificate for Tomcat to use
RUN \
    openssl req \
        -new \
        -newkey rsa:4096 \
        -days 3650 \
        -nodes \
        -x509 \
        -subj "/C=US/ST=Alaska/L=Anchorage/O=Axiom Data Science/CN=tomcat.example.com" \
        -keyout $CATALINA_HOME/conf/ssl.key \
        -out $CATALINA_HOME/conf/ssl.crt

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.9
RUN set -x \
    apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

RUN chown -R tomcat:tomcat "$CATALINA_HOME"

ENV JMX false
ENV JMX_PORT 9004
ENV JMX_HOSTNAME localhost
ENV DEBUG_PORT 8000

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080 8443

CMD ["catalina.sh", "run"]
