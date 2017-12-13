#!/bin/bash

# Create an Ansible inventory based on environment variables.
# Required environment variables:
# OPENSTACK_SERVER, OPENSTACK_USER, IMAGE_SERVER, IMAGE_USER.

set -u

# Create an inventory file with the openstack-server.
echo -e "[openstack-server]\n${OPENSTACK_SERVER} ansible_user=${OPENSTACK_USER}" > inventory
# Add the image-server to the inventory.
echo -e "[image-server]\n${IMAGE_SERVER} ansible_user=${IMAGE_USER}" >> inventory

cat inventory
