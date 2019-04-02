#!/bin/bash

# Print the status on all OpenStack objects that are configured.

set -x

openstack server list --limit -1
openstack router list
openstack network list
openstack subnet list
openstack keypair list
openstack floating ip list
openstack security group list
openstack flavor list
openstack image list
openstack project list
openstack stack list
