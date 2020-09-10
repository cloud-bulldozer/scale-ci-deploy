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

## Variables which are common to various cloud providers needs to be initialised first.
Documents for initializing can be found here - [ocp4_common_env_var.md](ocp4_common_env_var.md)

After that initialize the following variables -

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
Default: `managed-premium`
The storage class for Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_SIZE
Default: `10Gi`
The storage size for Prometheus server.

### OPENSHIFT_ALERTMANAGER_STORAGE_CLASS
Default: `managed-premium`
The storage class for the alertmanager servers.

### OPENSHIFT_ALERTMANAGER_STORAGE_SIZE
Default: `2Gi`