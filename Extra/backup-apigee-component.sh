#!/bin/bash

# This is a comment

/opt/apigee/apigee-service/bin/apigee-service edge-router stop

sleep 5

/opt/apigee/apigee-service/bin/apigee-service edge-router backup

sleep 5

/opt/apigee/apigee-service/bin/apigee-service edge-router start

sleep 5

/opt/apigee/apigee-service/bin/apigee-all status