# scale-ci-deploy

The repo contains playbooks for scale-ci automation tasks.  Those include install, scaling, upgrade,
and post install configuration. The environments under test include RHCOS based OCP on AWS and OCP3
on OSP installs.

# RHCOS based OCP 4.X Usage

The playbooks focus on RHCOS based OCP on AWS at this time and are found in the `OCP-4.X` directory.

The prerequisites are simply an orchestration machine with kubeconfig and oc command. The
orchestration host can be localhost if properly setup.

### Prepare the Jump host
- The jump host is the node which orchestrates the ocp install and configures the nodes to support the Scale-CI pipeline.
- Jump host needs to be a RHEL box and preferred if it is based out of the AMI built by the image provisioner.

### Run
Clone the github repo:
```
$ git clone https://github.com/openshift-scale/scale-ci-deploy.git
$ cd scale-ci-deploy
$ cp OCP-4.X/inventory.example inventory
```
Set the variables including AWS credentials, Install config, post-install and kick off the playbook:
```
$ ansible-playbook -vv -i inventory OCP-4.X/install.yml
```

Set OPENSHIFT_POST_INSTALL and OPENSHIFT_TOOLING to true to run the post-install and post-config options to configure
the cluster to be able to run performance and scale tests using Scale-CI pipeline. The variables under the post-install section
of the inventory can be modified to override the default values.

### Cleanup
Set OPENSHIFT_INSTALL, OPENSHIFT_POST_INSTALL, OPENSHIFT_TOOLING, OPENSHIFT_DEBUG_TOOLING to False and
OPENSHIFT_AWS_INSTALL_CLEANUP to True in the inventory and run the playbook:
```
$ ansible-playbook -vv -i inventory OCP-4.X/install.yml
```

## RHCOS install on OSP

To install RHCOS on an OSP cloud, we use a different playbook. (`OCP-4.X/install-ocp-on-osp.yml`)

Running from CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/install-ocp-on-osp.yml or define Environment vars
$ ansible-playbook -vv -i inventory OCP-4.X/install-ocp-on-osp.yml
```

Typical usage for OCP on OSP install requires a cloud created by [openshift-scale/scale-ci-tripleo](https://github.com/openshift-scale/scale-ci-tripleo).

The orchestration host will be the undercloud machine.


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

# OCP3.X on OpenStack (OSP)

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

## OCP on OSP scaleup

The OCP on OSP scaleup playbook is `OCP-3.X/scaleup.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/scaleup.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-3.X/scaleup.yml
```

### Environment variables for OCP on OSP scaleup playbook

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

## OCP on OSP reset OSP environment

The OCP on OSP reset playbook is `OCP-3.X/reset-ocp-on-osp.yml`

Running from CLI:

```sh
$ cp OCP-3.X/inventory.example inventory
$ # Add Undercloud and image server to inventory
$ # Edit vars in OCP-3.X/vars/reset-ocp-on-osp.yml or define Environment vars (See below)
$ time ansible-playbook -vv -i inventory OCP-3.X/reset-ocp-on-osp.yml
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

OCP_BASTION_NAME

OSP_DELETE_FLAVORS
OSP_DELETE_IMAGES
```
