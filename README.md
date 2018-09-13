# scale-ci-ansible

This repository contains tasks to automate the install of OpenShift Container
Platform (OCP) on an OpenStack Platform (OSP) environment using the
[openshift-ansible](https://github.com/openshift/openshift-ansible.git)
repository.

# Usage

The repository contains several Ansible playbooks and roles for installing
OpenShift on OpenStack. To use Ansible you must first create an inventory file:  

1. Create an `inventory` file to suit your environment. The following groups
must be defined in the inventory file:  
* **openstack-server** - The group contains the host that runs OpenStack. Sometimes
called the undercloud and usually contains the the OpenStack rc file.
* **image-server** - This group contains the host that has the RAW images to use
when building virtual machine servers in OpenStack.

There is a shell script file that formats the values for an Ansible inventory
file. The script uses the the following environment variables:  
`OPENSTACK_SERVER`, `OPENSTACK_USER`, `IMAGE_SERVER`, and `IMAGE_SERVER_USER`

```sh
files/create_inventory.sh
```

2. Set environment variables for the runtime environment (such as Jenkins). See
the [environment variables](#environment_variables) section for more details.

3. Run the Ansible playbook:
```sh
ansible-playbook -vv -i inventory install.yml
```
or
```sh
ansible-playbook -vv -i inventory scaleup.yml
```

These playbook runs a series of commands on the "openstack-server" that create
the necessary objects to create a VM server in OpenStack. The address is added
to the dynamic Ansible dynamic while the install playbook runs. Other plays
are run in sequence in their respective playbook to automate the different
parts of the install or scale up process.

# Environment variables

## Install

The install is configurable by setting environment variables before running the
Ansible install playbook.

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

###############################################################################
# OpenShift Container Platform (OCP) variables.
###############################################################################
OCP_REQUIRED_ANSIBLE_VERSION
OCP_CLEAN_YUM_CACHE

OCP_ARTIFACTS_DIR
OCP_CLUSTER_ID
OCP_MAJOR_MINOR
OCP_NTP_SERVERS

OCP_DNS_DOMAIN
OCP_DNS_KEY_ALGORITHM
OCP_DNS_UPDATE_FILE
OCP_DNS_KEY_NAME
OCP_NSUPDATE_FILE

OCP_CLONE_OPENSHIFT_ANSIBLE
OCP_OPENSHIFT_ANSIBLE_REPOSITORY
OCP_OPENSHIFT_ANSIBLE_VERSION
OCP_OPENSHIFT_ANSIBLE_CONTRIB_REPOSITORY
OCP_OPENSHIFT_ANSIBLE_CONTRIB_VERSION

OCP_DEFAULT_IMAGE_NAME

OCP_DEFAULT_FLAVOR
OCP_CNS_FLAVOR
OCP_INFRA_FLAVOR
OCP_LB_FLAVOR
OCP_MASTER_FLAVOR
OCP_NODE_FLAVOR

OCP_NODE_TARGET

OCP_GLUSTER_BLOCK_HOST_VSIZE
OCP_GLUSTERFS_BLOCK_TAG
OCP_GLUSTERFS_HEKETI_TAG
OCP_GLUSTERFS_IMAGE_TAG
OCP_GLUSTERFS_S3_TAG

OCP_CONTAINER_REGISTRIES

OCP_METERING_INSTALL
OCP_METERING_HIVE_META_SCLASS
OCP_METERING_HIVE_META_SSIZE
OCP_METERING_HDFS_NAME_SCLASS
OCP_METERING_HDFS_NAME_SSIZE
OCP_METERING_HDFS_DATA_SCLASS
OCP_METERING_HDFS_DATA_SSIZE
OCP_METERING_HDFS_DATA_REPLICAS

OCP_SERVICE_CATALOG_ENABLE
OCP_TEMPLATE_SERVICE_BROKER_ENABLE

###############################################################################
# OpenStack Platform (OSP) variables.
###############################################################################
OSP_CLIENT_PATH

OSP_ATOMIC_IMAGE
OSP_RHEL_IMAGE

OS_PROJECT_NAME

OSP_KEYPAIR_NAME
OSP_SECURITY_GROUP_NAME

OSP_PUBLIC_NETWORK_NAME
OSP_PUBLIC_SUBNET_NAME

OSP_PRIVATE_NETWORK_NAME
OSP_PRIVATE_ROUTER_NAME
OSP_PRIVATE_SUBNET_NAME
OSP_PRIVATE_SUBNET_RANGE

OSP_SERVER_NAME
OSP_SERVER_FLAVOR
OSP_SERVER_IMAGE

OSP_CREATE_FLAVORS
OSP_UPLOAD_IMAGES
```

## Scale up

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

###############################################################################
# OpenShift Container Platform (OCP) variables.
###############################################################################
OCP_ARTIFACTS_DIR
OCP_CLUSTER_ID
OCP_MAJOR_MINOR
OCP_NTP_SERVERS

OCP_DNS_DOMAIN
OCP_DNS_KEY_ALGORITHM
OCP_DNS_UPDATE_FILE
OCP_DNS_KEY_NAME
OCP_NSUPDATE_FILE

OCP_DEFAULT_IMAGE_NAME

OCP_DEFAULT_FLAVOR
OCP_CNS_FLAVOR
OCP_INFRA_FLAVOR
OCP_LB_FLAVOR
OCP_MASTER_FLAVOR
OCP_NODE_FLAVOR

OCP_NODE_TARGET
OCP_SCALE_BLOCK_SIZE

###############################################################################
# OpenStack Platform (OSP) variables.
###############################################################################
OSP_CLIENT_PATH

OS_PROJECT_NAME

OSP_KEYPAIR_NAME
OSP_SECURITY_GROUP_NAME

OSP_PUBLIC_NETWORK_NAME
OSP_PUBLIC_SUBNET_NAME

OSP_PRIVATE_NETWORK_NAME
OSP_PRIVATE_ROUTER_NAME
OSP_PRIVATE_SUBNET_NAME
OSP_PRIVATE_SUBNET_RANGE

OSP_SERVER_NAME
OSP_SERVER_FLAVOR
OSP_SERVER_IMAGE
```
