#!/usr/bin/bash

ENVIRON="$1"
# == {dev,production}

ansible-playbook -v -i "inventories/${ENVIRON}.ini" playbooks/upgrade/upgrade_test.yml

