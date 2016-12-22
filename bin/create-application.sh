#!/bin/bash
echo -n "USER NAME: "
read USER
echo -n "PASSWORD: "
read PASS
echo -n "IDENTITY DOMAIN: "
read IDDOMAIN
echo -n "REGION [us/em]: "
read REGION
if [ $REGION = em ]; then
	REGION=europe
elif [ $REGION = us ]; then
	REGION=us
else
	exit 1
fi
echo -n "APPLICATION NAME: "
read APPNAME
echo -n "LOCAL ARCHIVE: "
read ARCHIVE
echo -n "NOTES: "
read NOTES
echo ""

CURRENT=`date "+%Y%m%d-%H%M%S"`

zip -j artifact/accs_${CURRENT}.zip ${ARCHIVE} artifact/manifest.json

echo "curl -X PUT -u shinyay:yanaYANA0928 https://${IDDOMAIN}.storage.oraclecloud.com/v1/Storage-${IDDOMAIN}/Container_ACCS"
curl -X PUT -u shinyay:yanaYANA0928 https://${IDDOMAIN}.storage.oraclecloud.com/v1/Storage-${IDDOMAIN}/Container_ACCS
echo "curl -X PUT -u shinyay:yanaYANA0928 https://${IDDOMAIN}.storage.oraclecloud.com/v1/Storage-${IDDOMAIN}/Container_ACCS/accs_${CURRENT}.zip -T artifact/accs_${CURRENT}.zip"
curl -X PUT -u shinyay:yanaYANA0928 https://${IDDOMAIN}.storage.oraclecloud.com/v1/Storage-${IDDOMAIN}/Container_ACCS/accs_${CURRENT}.zip -T artifact/accs_${CURRENT}.zip
echo ""
echo "USER:${USER} PWD:${PASS} IDDOMAIN:${IDDOMAIN} REGION:${REGION} APPLICATION NAME:${APPNAME} NOTES:${NOTES}"
echo ""
echo -n "Do you accept to create instance ?(y/n): "
read ANSWER
echo ""

if [ $ANSWER = y ]; then
	echo "curl -X POST -u ${USER}:${PASS} \n
        -H "X-ID-TENANT-NAME: ${IDDOMAIN}" \n
        -H "Content-Type: multipart/form-data" \n
        -F "name=${APPNAME}" \n
        -F "runtime=java" \n
        -F "subscription=Monthly" \n
        -F "deployment=@artifact/deployment.json" \n
        -F "archiveURL=Container_ACCS/accs_${CURRENT}.zip" \n
        -F "notes=${NOTES}" \n
        https://apaas.${REGION}.oraclecloud.com/paas/service/apaas/api/v1.1/apps/${IDDOMAIN}"

        curl -X POST -u ${USER}:${PASS} \
        -H "X-ID-TENANT-NAME: ${IDDOMAIN}" \
        -H "Content-Type: multipart/form-data" \
        -F "name=${APPNAME}" \
        -F "runtime=java" \
        -F "subscription=Monthly" \
        -F "deployment=@artifact/deployment.json" \
        -F "archiveURL=Container_ACCS/accs_${CURRENT}.zip" \
        -F "notes=${NOTES}" \
        https://apaas.${REGION}.oraclecloud.com/paas/service/apaas/api/v1.1/apps/${IDDOMAIN}
else
	exit 1
fi
