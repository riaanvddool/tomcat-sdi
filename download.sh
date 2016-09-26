#! /bin/bash

GS_VER="${GS_VER:-2.8.3}"
GS_PLUGINS="mysql cas css imagemosaic-jdbc wps feature-pregeneralized pyramid importer"

GN_VER="${GN_VER:-3.0.3}"

set -eux
topdir="$(readlink -f $(dirname $0))"
mkdir -p $topdir/downloads
cd $topdir/downloads

test -f geoserver.zip  || wget -O geoserver.zip  http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VER}/geoserver-${GS_VER}-war.zip && unzip -j -d ../webapps/ -x geoserver.zip geoserver.war
test -f geonetwork.war || wget -O geonetwork.war http://sourceforge.net/projects/geonetwork/files/GeoNetwork_opensource/v${GN_VER}/geonetwork.war/download && cp geonetwork.war ../webapps/

for _p in $GS_PLUGINS ; do
    test -f "geoserver-${GS_VER}-${_p}-plugin.zip" || wget -O geoserver-${GS_VER}-${_p}-plugin.zip https://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VER}/extensions/geoserver-${GS_VER}-${_p}-plugin.zip/download
done
