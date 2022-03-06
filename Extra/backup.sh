#!/bin/bash
# This is a command of stop all the components
/opt/apigee/apigee-service/bin/apigee-all stop
sleep 5
# This is a command of backup all the components
/opt/apigee/apigee-service/bin/apigee-all backup
sleep 5
# This is a command of start all the components
/opt/apigee/apigee-service/bin/apigee-all start
sleep 5
# This is a command of check the status of all the components
/opt/apigee/apigee-service/bin/apigee-all status
