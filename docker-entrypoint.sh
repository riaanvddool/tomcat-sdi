#! /bin/sh

set -eux
adduser -s /bin/false -D -h $CATALINA_HOME -H -u ${TOMCAT_UID} tomcat \
 && chown -R tomcat $CATALINA_HOME/* \
 && chmod +x $CATALINA_HOME/bin/setenv.sh
gosu tomcat catalina.sh run
