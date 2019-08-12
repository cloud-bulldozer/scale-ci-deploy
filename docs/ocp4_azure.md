# OpenShift 4 IPI Azure Install Documentation

The OpenShift 4 IPI Azure install playbook is `OCP-4.X/install-on-azure.yml` and will deploy a cluster on Azure. In addition to installing a cluster, the playbook can also perform day 2 operations to include deploying three infra nodes and deploying a workload node to isolate workload driver pods from [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

## Usage

Running from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your expected orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/install-on-azure.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/install-on-azure.yml
```

## Environment variables

### PUBLIC_KEY
Default: `~/.ssh/id_rsa.pub`  
Public ssh key file for Ansible.

### PRIVATE_KEY
Default: `~/.ssh/id_rsa`  
Private ssh key file for Ansible.

### ORCHESTRATION_USER
Default: `root`  
User for Ansible to log in as. Must authenticate with PUBLIC_KEY/PRIVATE_KEY.

### OPENSHIFT_CLEANUP
Default: `false`  
Controls if previously deployed cluster will be destroyed prior to installing a new one.

### OPENSHIFT_INSTALL
Default: `true`  
Controls if cluster create and install portion of playbook is ran. The only reason to disable this is if you have a cluster already and wanted to run `OPENSHIFT_POST_INSTALL`, `OPENSHIFT_POST_CONFIG`, and/or `OPENSHIFT_DEBUG_CONFIG` against an existing cluster.

### OPENSHIFT_POST_INSTALL
Default: `true`  
Controls if day 2 operations are ran against this cluster. Day 2 operations includes creating infra nodes, creating a workload node, and steering infra workloads to infra nodes.

### OPENSHIFT_POST_CONFIG
Default: `true`  
Controls if "post-config" options are ran for this specific cluster. This opens the network security groups for this cluster to permit more network tests to execute from the [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

### OPENSHIFT_DEBUG_CONFIG
Default: `false`  
This enables easier debugging for a cluster by populating the initially installed cluster nodes with the kubeconfig and ssh keys for quicker out of band and hands on debugging.

### OPENSHIFT_CLIENT_LOCATION
Default: No default.  
Location to download and unpack the OpenShift client tool `oc`. The latest client can be found [https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)

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

### OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE
Default: `false`  
Option to build the installer binary from source instead of extract method. Not recommended.

### OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE_VERSION
Default: `master`  
Branch to build installer from if `OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE` is set to true.

### GOPATH
Default: `/root/.go`  
When building from source the gopath must be set.

### AZURE_SUBSCRIPTION_ID
Default: No default.  
The id of the subscription to Azure to use. Use `az account show` to find id.

### AZURE_TENANT_ID
Default: No default.  
The Azure tenantId from `az account show`.

### AZURE_SERVICE_PRINCIPAL_CLIENT_ID
Default: No default.  
The Azure service principal id to use for this cluster. Create a service principal (one time) with `az ad sp create-for-rbac --role Owner --name test-sp`.

### AZURE_SERVICE_PRINCIPAL_CLIENT_SECRET
Default: No default.  
The service principal password. This should be shown in the return on the `az ad sp create-for-rbac` command ran above to create the service principal.

### AZURE_BASE_DOMAIN_RESOURCE_GROUP_NAME
Default: No default.  
The resource group in which the base domain is located.

### AZURE_REGION
Default: No default.  
The Azure region to install on to. Example: `centralus`

### OPENSHIFT_BASE_DOMAIN
Default: No default.  
The base domain for the cluster.

### OPENSHIFT_CLUSTER_NAME
Default: No default.  
The name of the cluster.

### OPENSHIFT_MASTER_COUNT
Default: `3`  
The number of master nodes.

### OPENSHIFT_WORKER_COUNT
Default: `5`  
The number of worker nodes to install.

### OPENSHIFT_MASTER_VM_SIZE
Default: `Standard_D4s_v3`  
The vm size of the masters.

### OPENSHIFT_WORKER_VM_SIZE
Default: `Standard_D2s_v3`  
The vm size of the worker nodes.

### OPENSHIFT_MASTER_ROOT_VOLUME_SIZE
Default: `64`  
The root volume disk size for the masters.

### OPENSHIFT_WORKER_ROOT_VOLUME_SIZE
Default: `64`  
The root volume size for worker nodes.

### OPENSHIFT_CIDR
Default: `10.128.0.0/14`  
The block of IP addresses from which Pod IP addresses are allocated.

### OPENSHIFT_MACHINE_CIDR
Default: `10.0.0.0/16`  
The block of IP addresses used for hosts.

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

### OPENSHIFT_INFRA_NODE_VM_SIZE
Default: `Standard_D2s_v3`  
The vm size for infra nodes.

### OPENSHIFT_WORKLOAD_NODE_VM_SIZE
Default: `Standard_D2s_v3`  
The vm size for the workload node.

### OPENSHIFT_INFRA_NODE_VOLUME_SIZE
Default: `64`  
The root volume size for the infra nodes.

### OPENSHIFT_INFRA_NODE_VOLUME_TYPE
Default: `Premium_LRS`  
The root volume type for infra nodes.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_SIZE
Default: `64`  
The root volume size for the workload node.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_TYPE
Default: `Premium_LRS`  
The root volume type for workload node.

### OPENSHIFT_PROMETHEUS_RETENTION_PERIOD
Default: `15d`  
The retention period for the Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_CLASS
Default: `Premium_LRS`  
The storage class for Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_SIZE
Default: `10Gi`  
The storage size for Prometheus server.

### OPENSHIFT_ALERTMANAGER_STORAGE_CLASS
Default: `Premium_LRS`  
The storage class for the alertmanager servers.

### OPENSHIFT_ALERTMANAGER_STORAGE_SIZE
Default: `2Gi`  
The storage size for the alert manager servers.

### KUBECONFIG_AUTH_DIR_PATH
Default: No default.  
For use with Flexy built clusters, in which only the post-install steps are ran.
