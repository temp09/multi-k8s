#!/bin/bash

# This is a scripts for backup the apigee components whic will run every week Saturday midnight through cronjob

/opt/apigee/apigee-service/bin/apigee-all stop 

sleep 5

/opt/apigee/apigee-service/bin/apigee-all backup

sleep 5

/opt/apigee/apigee-service/bin/apigee-all start