#!/usr/bin/bash

ENVIRON="$1"
# == {dev,test,production}

ansible-playbook -v -i inventories/${ENVIRON}.ini playbooks/install/test.yml

