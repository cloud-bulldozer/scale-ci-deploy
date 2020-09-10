# OpenShift 4 IPI OpenStack Install Documentation

The OpenShift 4 IPI OpenStack install playbook is `OCP-4.X/install-on-osp.yml` and will deploy a cluster on OpenStack. In addition to installing a cluster, the playbook can also perform day 2 operations to include deploying three infra nodes and deploying a workload node to isolate workload driver pods from [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

The OpenStack cloud in which this has been tested with and on is a Red Hat OpenStack Platform 13 cloud installed via tripleo. The install orchestration used to deploy the cloud is [openshift-scale/scale-ci-tripleo](https://github.com/openshift-scale/scale-ci-tripleo).

## Usage

Running from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your undercloud machine as the orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/install-on-osp.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/install-on-osp.yml
```

Note that for Tripleo OpenStack Clouds, the Undercloud machine is used as the orchestration host as it will be easier to setup/coordinate any sort of lab specific networking on this machine (Usually).

## Environment variables for `install-on-osp.yml`

## Variables which are common to various cloud providers needs to be initialised first.
Documents for initializing can be found here - [ocp4_common_env_var.md](ocp4_common_env_var.md)

After that initialize the following variables -

### OPENSTACK_CREATE_FLAVORS
Default: `true`
Determines if the flavors will be created on the OpenStack Cloud.

### OPENSTACK_UPLOAD_IMAGE
Default: `true`
Determines if the image will be uploaded into Glance on the OpenStack Cloud. If performing multiple deploys/cleanups, it can save time if the image is uploaded and then these steps skipped in the future installs.

### OPENSHIFT_IMAGE_LOCATION
Default: No default.
Location to download the latest RHCOS image. The image is expected in qcow2 format so it will be converted into raw to take advantage of the Ceph driver for Glance. The latest image can be found in [https://github.com/openshift/installer/blob/master/data/data/rhcos.json](https://github.com/openshift/installer/blob/master/data/data/rhcos.json).

### OPENSHIFT_BASE_DOMAIN
Default: `example.com`
The base domain for the cluster.

### OPENSHIFT_CLUSTER_NAME
Default: `scale-ci`
The name of the cluster.

### OPENSHIFT_MASTER_COUNT
Default: `3`
The number of master nodes.

### OPENSHIFT_WORKER_COUNT
Default: `5`
The number of worker nodes to install.

### OPENSHIFT_MASTER_FLAVOR
Default: `m4.xlarge`
The flavor of the masters.

### OPENSHIFT_WORKER_FLAVOR
Default: `m4.xlarge`
The flavor of the worker nodes.

### MACHINESET_METADATA_LABEL_PREFIX
Default: `machine.openshift.io`
The prefix used in machinesets. Usually this is `machine.openshift.io` however it might be `sigs.k8s.io` depending on version installed.

### OPENSHIFT_INFRA_NODE_FLAVOR
Default: `m4.xlarge`
The flavor for infra nodes.

### OPENSHIFT_WORKLOAD_NODE_FLAVOR
Default: `m4.xlarge`
The flavor for the workload node.

### OPENSHIFT_PROMETHEUS_RETENTION_PERIOD
Default: `15d`
The retention period for the Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_CLASS
Default: `standard`
The storage class for Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_SIZE
Default: `10Gi`
The storage size for Prometheus server.

### OPENSHIFT_ALERTMANAGER_STORAGE_CLASS
Default: `standard`
The storage class for the alertmanager servers.

### OPENSHIFT_ALERTMANAGER_STORAGE_SIZE
Default: `2Gi`
The storage size for the alert manager servers.

## Cleanup playbook

Instead of a cleanup step, the OpenStack cleanup is a separate playbook due to a few additional steps and the potential for cleanup to be unsuccessful. Thus separating into a separate playbook provides the operator a good segue to double check things before redeploying again.

To run the cleanup playbook from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your undercloud machine as the orchestration host
$ # Edit cleanup variables (Ex vi OCP-4.X/vars/clean-on-osp.yml) or define env variables
$ ansible-playbook -vv -i inventory OCP-4.X/clean-on-osp.yml
```

## Environment variables for `clean-on-osp.yml`

### PUBLIC_KEY
Default: `~/.ssh/id_rsa.pub`
Public ssh key file for Ansible.

### PRIVATE_KEY
Default: `~/.ssh/id_rsa`
Private ssh key file for Ansible.

### ORCHESTRATION_USER
Default: `stack`
User for Ansible to log in as. Must authenticate with PUBLIC_KEY/PRIVATE_KEY.

### OPENSHIFT_BASE_DOMAIN
Default: `example.com`
The base domain for the cluster.

### OPENSHIFT_CLUSTER_NAME
Default: `scale-ci`
The name of the cluster.

### OPENSTACK_DELETE_FLAVORS
Default: `true`
Determines if the flavors will be deleted on the OpenStack Cloud.

### OPENSTACK_DELETE_IMAGE
Default: `true`
Determines if the image will be deleted from Glance on the OpenStack Cloud.

### DATA_SERVER_ENABLE
Default: `false`
Controls whether the data server is launched.

### DATA_SERVER_IMAGE
Default: `quay.io/openshift-scale/snappy-data-server`
Latest, maintained image of the snappy data server.

### DATA_SERVER_LOG_LVL
Default: `info`  
Data server log level. Current [Uvicorn server](https://www.uvicorn.org) **options:** *'critical', 'error', 'warning', 'info', 'debug', 'trace'.

### DATA_SERVER_PORT
Default: `7070`  
Data server service port.

### DATA_SERVER_PUBLIC_HOST
Default: `localhost`  
URL to public host of data server.

### DATA_SERVER_ROOT_PATH
Default: `~/data_server`
Absolute path to the data server's host's directory.

### DATA_SERVER_SECRET
Default: No default.
Secret to encode passwords in database.

### FIRST_SUPERUSER
Default: No default.
Username for the first super user.

### FIRST_SUPERUSER_PASSWORD
Default: No default.
Password for the first super user.

### POSTGRES_PASSWORD
Default: No default.
Postgresql database super user password.
