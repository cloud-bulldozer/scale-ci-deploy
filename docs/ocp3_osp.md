# OpenShift 3 on OpenStack scale-ci-deploy Documentation

## Install playbook

The OpenShift 3 on OpenStack install playbook is `OCP-3.X/install.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/install.yml or define Environment vars (See below)
$ ansible-playbook -vv -i inventory OCP-3.X/install.yml
```

### Environment variables for OpenShift 3 on OpenStack install playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

###############################################################################
# OCP 3.X install variables.
###############################################################################
OSP_ATOMIC_IMAGE
OSP_RHEL_IMAGE

OSP_CREATE_FLAVORS
OSP_UPLOAD_IMAGES

OSP_NESTED_VIRT

OCP_BASTION_NAME
OCP_BASTION_FLAVOR
OCP_BASTION_IMAGE

OCP_REQUIRED_ANSIBLE_VERSION

OCP_CLUSTER_ID

OCP_MAJOR_MINOR
OCP_NTP_SERVERS

OCP_DNS_DOMAIN

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
```

## OpenShift 3 on OpenStack scaleup

The OpenShift on OpenStack scaleup playbook is `OCP-3.X/scaleup.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/scaleup.yml or define Environment vars (See below)
$ ansible-playbook -vv -i inventory OCP-3.X/scaleup.yml
```

### Environment variables for OpenShift 3 on OpenStack scaleup playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

###############################################################################
# OCP 3.X Scaleup variables.
###############################################################################
OCP_BASTION_NAME

OCP_CLUSTER_ID
OCP_DNS_DOMAIN

OCP_NODE_TARGET

OCP_SCALE_BLOCK_SIZE
```

## OpenShift 3 on OpenStack reset OpenStack environment playbook

The OpenShift on OpenStack reset playbook is `OCP-3.X/reset-ocp-on-osp.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/reset-ocp-on-osp.yml or define Environment vars (See below)
$ ansible-playbook -vv -i inventory OCP-3.X/reset-ocp-on-osp.yml
```

### Environment variables for OpenShift 3 on OpenStack reset playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

###############################################################################
# Reset OCP on OSP variables.
###############################################################################
OCP_CLUSTER_ID
OCP_DNS_DOMAIN

OCP_BASTION_NAME

OSP_DELETE_FLAVORS
OSP_DELETE_IMAGES
```
