#!/bin/sh

EXTRACT_FLG=$1

if [ ! $EXTRACT_FLG = "y" ]; then
	echo "usage: $0 <EXTRACT_FLG> (y: extract and remove archive)"
	exit 1
fi

TOMCAT_DIR=apache-tomcat-7.0.73
ARCHIVE_NAME=${TOMCAT_DIR}.zip
if [ -e $ARCHIVE_NAME ]; then
	echo "FILE EXISTED"
	exit 1
else
	wget --no-check-certificate http://download.nus.edu.sg/mirror/apache/tomcat/tomcat-7/v7.0.73/bin/${ARCHIVE_NAME} 
fi

if [ $EXTRACT_FLG = "y" ]; then
	unzip ${ARCHIVE_NAME}
	rm ${ARCHIVE_NAME}
	rm -fr ${TOMCAT_DIR}/webapps/docs
	rm -fr ${TOMCAT_DIR}/webapps/examples
	rm -fr ${TOMCAT_DIR}/webapps/host-manager
	rm -fr ${TOMCAT_DIR}/webapps/manager
	rm -fr ${TOMCAT_DIR}/webapps/ROOT
fi
