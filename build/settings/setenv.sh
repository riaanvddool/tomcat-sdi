#!/bin/sh

NORMAL="-server -d64"
HEADLESS="-Djava.awt.headless=true"

# Set stack thread size: http://docs.oracle.com/cd/E13150_01/jrockit_jvm/jrockit/jrdocs/refman/optionX.html#wp1000929
STACK="-Xss2M"

HEAP="-Xms${MINMEM:-128m} -Xmx${MAXMEM:-756m}"
GC="-XX:+UseParNewGC -XX:MaxGCPauseMillis=500 -XX:+UseConcMarkSweepGC"

GEOSERVER_OPTS="-Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true"
GEONETWORK_OPTS="-Djava.security.egd=file:/dev/./urandom -Dgeonetwork.dir=$GEONETWORK_DATA_DIR"

CATALINA_OPTS="$NORMAL $HEADLESS $STACK $HEAP $GC $GEOSERVER_OPTS $GEONETWORK_OPTS"


if $JMX ; then
  CATALINA_OPTS="$CATALINA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=${DEBUG_PORT},server=y,suspend=n -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false  -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.port=${JMX_PORT} -Djava.rmi.server.hostname=${JMX_HOSTNAME} -Dcom.sun.management.jmxremote.rmi.port=${JMX_PORT}"
fi




