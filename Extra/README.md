Description
============
This is a basic playbook to install apigee components in all environments. Below are the components that gets installed on the different servers based on the host file. 

Cassandra
ZooKeeper
Router
Message Processor
Management Server
EdgeUI
Qpid Server
Postgres 

To run the playbook: 
ansible-playbook apigeeInstaller.yml -i apigeeHosts --extra-vars 'env=<envName> dc=<dataCenterName>'

where, 
envName can be dev, test, staging or prod
dataCenterName can be dc1 or dc2. If there is only one data center then mention it as 'dc1'

To run the playbook on any one specifig server or host: 
ansible-playbook apigeeInstaller.yml -i apigeeHosts --limit <IPAddress> --extra-vars 'env=<envName> dc=<dataCenterName>'

Requirements
------------
To run this playbook, ssh keys for the user (ansible user) need to be copied to gitlab.west.com to get the requiered packages.


Role Variables
--------------
All the variables under group_vars or roles/<role_name>/vars/main.yml

Dependencies
------------
No dependency on any other role.

Future Enhancements
-------------------
 1. We should be able to add more servers to the existing list using the playbook. It should perform install, update configFile and do other     necessary manual steps. 
 2. Implementing the postgres Master/Slave replication across datacenter. 
 

Author Information
------------------
Sunil Shet
Shoban Magalingam
Jeremy Stockstill

