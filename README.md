# scale-ci-ansible

The repo contains playbooks for various scale-ci automation tasks.  Those include install,
scaling, upgrade, and post install configuration. The environments under test include RHCOS and
OCP on OSP installs.

# RHCOS Usage

The RHCOS playbooks focus on RHCOS on AWS at this time and are found in the `OCP-4.X` directory.

The prerequisites are simple and simply an orchestration machine with kubeconfig and oc command.
The orchestration host can be localhost if properly setup.

## RHCOS Post Install

`OCP-4.X/post-install.yml` playbook is used to perform post RHCOS 4 cluster install operations.

Running from CLI:

```
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/post-install.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-4.X/post-install.yml
```

### Environment variables for RHCOS post install playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

ORCHESTRATION_USER
###############################################################################
# RHCOS Post Install Parameters
###############################################################################
POLL_ATTEMPTS

RHCOS_METADATA_LABEL_PREFIX

RHCOS_TOGGLE_INFRA_NODE
RHCOS_TOGGLE_PBENCH_NODE

RHCOS_INFRA_NODE_INSTANCE_TYPE
RHCOS_PBENCH_NODE_INSTANCE_TYPE

RHCOS_INFRA_NODE_VOLUME_IOPS
RHCOS_INFRA_NODE_VOLUME_SIZE
RHCOS_INFRA_NODE_VOLUME_TYPE

RHCOS_PBENCH_NODE_VOLUME_IOPS
RHCOS_PBENCH_NODE_VOLUME_SIZE
RHCOS_PBENCH_NODE_VOLUME_TYPE

PROMETHEUS_RETENTION_PERIOD
PROMETHEUS_STORAGE_SIZE
ALERTMANAGER_STORAGE_SIZE
```

## RHCOS scale

The RHCOS scale playbook is `OCP-4.X/scale.yml` and can scale an existing RHCOS cluster.

Running from CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/scale.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-4.X/scale.yml
```

### Environment variables for RHCOS scale playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

ORCHESTRATION_USER
###############################################################################
# RHCOS Scaling variables.
###############################################################################
POLL_ATTEMPTS

RHCOS_METADATA_LABEL_PREFIX

RHCOS_WORKER_COUNT
```

## RHCOS Upgrade

The RHCOS upgrade playbook is `OCP-4.X/upgrade.yml` and can upgrade an existing RHCOS cluster (if it
is upgrade-able).

Running from CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/upgrade.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-4.X/upgrade.yml
```

### Environment variables for RHCOS upgrade playbook

```
###############################################################################
# Ansible SSH variables.
###############################################################################
PUBLIC_KEY
PRIVATE_KEY

ORCHESTRATION_USER
###############################################################################
# RHCOS upgrade variables.
###############################################################################
POLL_ATTEMPTS

RHCOS_NEW_VERSION_URL
RHCOS_NEW_VERSION
```

# OCP on OSP Usage

The repository contains several Ansible playbooks and roles for installing
OpenShift on OpenStack. Those playbooks are in the `OCP-3.X` directory. Usage is as follows:

## OCP on OSP Install

The OCP on OSP install playbook is `OCP-3.X/install.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/install.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-3.X/install.yml
```

### Environment variables for OCP on OSP install playbook

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

## OCP on OSP scaleup

The OCP on OSP scaleup playbook is `OCP-3.X/scaleup.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/scaleup.yml or define EnvironmentOCP-3.X/ vars (See below)
$ time ansible-playbook -i inventory OCP-3.X/scaleup.yml
```

### Environment variables for OCP on OSP scaleup playbook

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

## OCP on OSP reset OSP environment

The OCP on OSP reset playbook is `OCP-3.X/reset-ocp-on-osp.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/reset-ocp-on-osp.yml or define Environment vars (See below)
$ time ansible-playbook -i inventory OCP-3.X/reset-ocp-on-osp.yml
```

### Environment variables for OCP on OSP reset playbook

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

OSP_SERVER_NAME
OSP_DELETE_FLAVORS
OSP_DELETE_IMAGES
```
