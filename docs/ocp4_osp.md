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

### PUBLIC_KEY
Default: `~/.ssh/id_rsa.pub`  
Public ssh key file for Ansible.

### PRIVATE_KEY
Default: `~/.ssh/id_rsa`  
Private ssh key file for Ansible.

### ORCHESTRATION_USER
Default: `stack`  
User for Ansible to log in as. Must authenticate with PUBLIC_KEY/PRIVATE_KEY.

### OPENSHIFT_INSTALL
Default: `true`  
Controls if cluster create and install portion of playbook is ran. The only reason to disable this is if you have a cluster already and wanted to run `OPENSHIFT_POST_INSTALL`, `OPENSHIFT_POST_CONFIG`, and/or `OPENSHIFT_DEBUG_CONFIG` against an existing cluster.

### OPENSHIFT_POST_INSTALL
Default: `true`  
Controls if day 2 operations are ran against this cluster. Day 2 operations includes creating infra nodes, creating a workload node, and steering infra workloads to infra nodes.

### OPENSHIFT_POST_CONFIG
Default: `true`  
Controls if "post-config" options are ran for this specific cluster. This opens the security groups for this cluster to permit more network tests to execute from the [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

### OPENSHIFT_DEBUG_CONFIG
Default: `true`  
This enables easier debugging for a cluster by populating the initially installed cluster nodes with the kubeconfig and ssh keys for quicker out of band and hands on debugging.

### OPENSTACK_CREATE_FLAVORS
Default: `true`  
Determines if the flavors will be created on the OpenStack Cloud.

### OPENSTACK_UPLOAD_IMAGE
Default: `true`  
Determines if the image will be uploaded into Glance on the OpenStack Cloud. If performing multiple deploys/cleanups, it can save time if the image is uploaded and then these steps skipped in the future installs.

### OPENSHIFT_CLIENT_LOCATION
Default: No default.  
Location to download and unpack the OpenShift client tool `oc`. The latest client can be found [https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)

### OPENSHIFT_IMAGE_LOCATION
Default: No default.  
Location to download the latest RHCOS image. The image is expected in qcow2 format so it will be converted into raw to take advantage of the Ceph driver for Glance. The latest image can be found in [https://github.com/openshift/installer/blob/master/data/data/rhcos.json](https://github.com/openshift/installer/blob/master/data/data/rhcos.json).

### OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE
Default: No default.  
The release image override payload. Also where the install `openshift-install` binary is extracted from. Find the latest test images at [https://openshift-release.svc.ci.openshift.org/](https://openshift-release.svc.ci.openshift.org/)

### OPENSHIFT_INSTALL_APIVERSION
Default: `v1`  
Depending upon the version of the payload tested this version string might need to be adjusted.

### OPENSHIFT_INSTALL_SSH_PUB_KEY_FILE
Default: `~/.ssh/id_rsa.pub`  
Public ssh key file to be used in the install-config.yaml.

### OPENSHIFT_INSTALL_PULL_SECRET
Default: No default.  
The pull secret to be used in installing the cluster.

### OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN
Default: No default.  
The token used to download and extract the installer binary from quay.

### OPENSHIFT_INSTALL_IMAGE_REGISTRY
Default: `registry.svc.ci.openshift.org`  
The registry which contains the install image.

### OPENSHIFT_INSTALL_REGISTRY_TOKEN
Default: No default.  
The token used to download and extract the installer binary from the registry.

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

### OPENSHIFT_CIDR
Default: `10.128.0.0/14`  
The block of IP addresses from which Pod IP addresses are allocated.

### OPENSHIFT_MACHINE_CIDR
Default: `10.0.128.0/17`  
The block of IP addresses used for hosts.

### OPENSHIFT_NETWORK_TYPE
Default: `OpenShiftSDN`  
The network type for OpenShift.

### OPENSHIFT_SERVICE_NETWORK
Default: `172.30.0.0/16`  
The block of IP addresses for services.

### OPENSHIFT_HOST_PREFIX
Default: `23`  
The subnet prefix length to assign to each individual node for Pod IP addresses.

### OPENSHIFT_POST_INSTALL_POLL_ATTEMPTS
Default: `600`  
The number of times to poll to check while the infra and workload node are being created and added to the cluster.

### OPENSHIFT_TOGGLE_INFRA_NODE
Default: `true`  
Enable infra nodes to be created with the `OPENSHIFT_POST_INSTALL` step.

### OPENSHIFT_TOGGLE_WORKLOAD_NODE
Default: `true`  
Enable a workload node to be created with the `OPENSHIFT_POST_INSTALL` step.

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
