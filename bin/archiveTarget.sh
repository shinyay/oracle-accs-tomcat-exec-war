#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "usage: ${0} <ARCHIVE NAME FOR ACCS> <MANIFET_PATH> <TOMCAT INSTALLED ROOT>";
  exit 1;
fi

FILENAME_FOR_ACCS=${1}
MANIFEST=${2}
TOMCAT_DIR=${3}

cp $MANIFEST $TOMCAT_DIR
cd $TOMCAT_DIR && tar zcvf ../$FILENAME_FOR_ACCS * && cd ..
