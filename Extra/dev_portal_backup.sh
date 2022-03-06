#!/bin/bash
#Change to the Drupal directory, /opt/apigee/apigee-drupal by default:
	    cd /opt/apigee/apigee-drupal
#Use pg_dump command 
	    pg_dump --dbname=devportal --host=10.71.178.29 --username=apigee --password=secretSauce --format=c > /tmp/portal.bak
#Make a backup of your entire Drupal web root directory.
#The default webroot location is /opt/apigee/apigee-drupal/wwwroot
		tar cvf /opt/apigee/backup/wwwroot.tar wwwroot/*
#Make a backup of the public files.
#By default, these files are located in /opt/apigee/apigee-drupal/wwwroot/sites/default/files
	    cd /opt/apigee/apigee-drupal/wwwroot/sites/default
		tar cvf /opt/apigee/backup/files.tar files/*
#Make a backup of the private files in /opt/apigee/data/apigee-drupal-devportal/private
	    cd /opt/apigee/data/apigee-drupal-devportal
	    tar cvf /opt/apigee/backup/private.tar private/*