#!/bin/sh


### functions

curl_post()
{

if [ ${SSL} -eq 1 ]; then

curl -v -u ApigeeAdmin@west.com -X POST -H "Content-Type: text/xml" http://led36913:8080/v1/o/west/environments/${ENV}/keystores -d '<KeyStore name="'${KEYSTORE}'"/>'

curl -v -X POST -H "Content-Type: multipart/form-data" \
 -F file="@${KEYJAR}" "http://led36913:8080/v1/o/west/environments/${ENV}/keystores/${KEYSTORE}/keys?alias=${KEYALIAS}" \
 -u ApigeeAdmin@west.com


curl -v -X POST  -H "Content-Type:application/xml" http://led36913:8080/v1/o/west/e/${ENV}/references \
  -d '<ResourceReference name="'${KEYREF}'"> \
    <Refers>'${KEYSTORE}'</Refers> \
    <ResourceType>KeyStore</ResourceType> \
  </ResourceReference>' \
  -u ApigeeAdmin@west.com

curl -v -u ApigeeAdmin@west.com -X POST --header "Content-Type: application/json" \
  "http://led36913:8080/v1/o/west/environments/${ENV}/virtualhosts" --data '
{
  "hostAliases" : [ "'${VHOSTALIAS}'" ],
  "interfaces" : [ ],
  "listenOptions" : [ ],
  "name" : "'${VHOSTNAME}'",
  "port" : "'${PORT}'",
  "sSLInfo" : {
    "ciphers" : [ ],
    "clientAuthEnabled" : "false",
    "enabled" : "true",
    "ignoreValidationErrors" : false,
    "keyAlias" : "'${KEYALIAS}'",
    "keyStore" : "ref://'${KEYREF}'",
    "protocols" : [ ]
  }
} '

else

curl -v -u ApigeeAdmin@west.com -X POST --header "Content-Type: application/json" \
  "http://led36913:8080/v1/o/west/environments/${ENV}/virtualhosts" --data '
{
  "hostAliases" : [ "'${VHOSTALIAS}'" ],
  "interfaces" : [ ],
  "listenOptions" : [ ],
  "name" : "'${VHOSTNAME}'",
  "port" : "'${PORT}'"
} '
fi
}

curl_put()
{

if [ ${SSL} -eq 1 ]; then

curl -v -u ApigeeAdmin@west.com -X PUT --header "Content-Type: application/json" \
  "http://led36913:8080/v1/o/west/environments/${ENV}/virtualhosts/${VHOSTNAME}" --data '
{
  "hostAliases" : [ "'${VHOSTALIAS}'" ],
  "interfaces" : [ ],
  "listenOptions" : [ ],
  "name" : "'${VHOSTNAME}'",
  "port" : "'${PORT}'",
  "sSLInfo" : {
    "ciphers" : [ ],
    "clientAuthEnabled" : "false",
    "enabled" : "true",
    "ignoreValidationErrors" : false,
    "keyAlias" : "'${KEYALIAS}'",
    "keyStore" : "ref://'${KEYREF}'",
    "protocols" : [ ]
  }
} '

else

curl -v -u ApigeeAdmin@west.com -X PUT --header "Content-Type: application/json" \
  "http://led36913:8080/v1/o/west/environments/${ENV}/virtualhosts/${VHOSTNAME}" --data '
{
  "hostAliases" : [ "'${VHOSTALIAS}'" ],
  "interfaces" : [ ],
  "listenOptions" : [ ],
  "name" : "'${VHOSTNAME}'",
  "port" : "'${PORT}'"
} '
fi
}

### Start main

VHOSTNAME="default"
VHOSTALIAS="api.sysdev.west.com"
ENV="test"
PORT="9001"
KEYSTORE="tmpKeystore"
KEYALIAS="tmpKeyAlias"
KEYREF="tmpkeystoreref"
KEYJAR="/opt/apigee/tmpKeystore.jar"
SSL=0

curl_post

VHOSTNAME="newTLS"
VHOSTALIAS="api.sysdev.west.com"
ENV="test"
PORT="9002"
KEYSTORE="tmpKeystore"
KEYALIAS="tmpKeyAlias"
KEYREF="tmpkeystoreref"
KEYJAR="/opt/apigee/tmpKeystore.jar"
SSL=1

curl_post


VHOSTNAME="default"
VHOSTALIAS="api.sysdev.west.com"
ENV="dev"
PORT="9003"
KEYSTORE="tmpKeystore"
KEYALIAS="tmpKeyAlias"
KEYREF="tmpkeystoreref"
KEYJAR="/opt/apigee/tmpKeystore.jar"
SSL=0

curl_post

VHOSTNAME="newTLS"
VHOSTALIAS="api.sysdev.west.com"
ENV="dev"
PORT="9004"
KEYSTORE="tmpKeystore"
KEYALIAS="tmpKeyAlias"
KEYREF="tmpkeystoreref"
KEYJAR="/opt/apigee/tmpKeystore.jar"
SSL=1

curl_post

VHOSTNAME="default"
VHOSTALIAS="test-apimarketplace.west.com"
ENV="test"
PORT="80"
KEYSTORE="mainKeystore"
KEYALIAS="mainKeyAlias"
KEYREF="mainkeystoreref"
KEYJAR="/opt/apigee/mainKeystore.jar"
SSL=0

curl_post

VHOSTNAME="main_vhost"
VHOSTALIAS="test-apimarketplace.west.com"
ENV="test"
PORT="443"
KEYSTORE="mainKeystore"
KEYALIAS="mainKeyAlias"
KEYREF="mainkeystoreref"
KEYJAR="/opt/apigee/mainKeystore.jar"
SSL=1

curl_post

VHOSTNAME="default"
VHOSTALIAS="dev-apimarketplace.west.com"
ENV="dev"
PORT="80"
KEYSTORE="mainKeystore"
KEYALIAS="mainKeyAlias"
KEYREF="mainkeystoreref"
KEYJAR="/opt/apigee/mainKeystore.jar"
SSL=0

curl_post

VHOSTNAME="main_vhost"
VHOSTALIAS="dev-apimarketplace.west.com"
ENV="dev"
PORT="443"
KEYSTORE="mainKeystore"
KEYALIAS="mainKeyAlias"
KEYREF="mainkeystoreref"
KEYJAR="/opt/apigee/mainKeystore.jar"
SSL=1

curl_post

