# OpenShift 4 IPI Alibaba Install Documentation

The OpenShift 4 IPI Alibaba variable file can be found at `OCP-4.X/vars/install-on-alibaba.yml`. It will configure the deployment playbook at `OCP-4.X/deploy-cluster.yml` to perform a cluster installation on Alibaba. In addition to installing a cluster, the playbook can also perform day 2 operations to include deploying three infra nodes and deploying a workload node to isolate workload driver pods from [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

## Usage

Running from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your expected orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/install-on-alibaba.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/deploy-cluster.yml -e platform=alibaba
```

## Environment variables

## Variables which are common to various cloud providers needs to be initialized first.
Documents for initializing can be found here - [ocp4_common_env_var.md](ocp4_common_env_var.md)

### ALIYUN_PROFILE
Default: `default`
The name of the Alibaba profile to be set on the orchestration machine for use with the Alibaba aliyun cli and installer.

### ALIYUN_ACCESS_KEY_ID
Default: No default.
The Alibaba access key.

### ALIYUN_BINARY
Default: `https://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.32-amd64.tgz`
Alibaba CLI aliyun install binary

### ALIYUN_ACCESS_KEY_SECRET
Default: No default.
The Alibaba secret access key.

### ALIBABA_REGION
Default: No default.
The Alibaba region to install on to.

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
Default: `3`
The number of worker nodes to install.

### OPENSHIFT_MASTER_INSTANCE_TYPE
Default: `ecs.r5.4xlarge`
The instance type of the masters.

### OPENSHIFT_WORKER_INSTANCE_TYPE
Default: `ecs.g6.2xlarge`
The instance type of the worker nodes.

### OPENSHIFT_MASTER_ROOT_VOLUME_SIZE
Default: `64`
The root volume disk size for the masters.

### OPENSHIFT_MASTER_ROOT_VOLUME_TYPE
Default: `cloud_essd`
The root volume type for the masters.

### OPENSHIFT_MASTER_ROOT_VOLUME_IOPS
Default: `0`

### OPENSHIFT_WORKER_ROOT_VOLUME_SIZE
Default: `64`
The root volume size for worker nodes.

### OPENSHIFT_WORKER_ROOT_VOLUME_TYPE
Default: `cloud_essd`
The root volume type for worker nodes.

### OPENSHIFT_WORKER_ROOT_VOLUME_IOPS
Default: `0`

### MACHINESET_METADATA_LABEL_PREFIX
Default: `machine.openshift.io`
The prefix used in machinesets. Usually this is `machine.openshift.io` however it might be `sigs.k8s.io` depending on version installed.

### OPENSHIFT_INFRA_NODE_INSTANCE_TYPE
Default: `ecs.g6.8xlarge`
The instance type for infra nodes.

### OPENSHIFT_WORKLOAD_NODE_INSTANCE_TYPE
Default: `ecs.g6.4xlarge`
The instance type for the workload node.

### OPENSHIFT_INFRA_NODE_VOLUME_SIZE
Default: `64`
The root volume size for the infra nodes.

### OPENSHIFT_INFRA_NODE_VOLUME_TYPE
Default: `cloud_essd`
The root volume type for infra nodes.

### OPENSHIFT_INFRA_NODE_VOLUME_IOPS
Default: `0`

### OPENSHIFT_WORKLOAD_NODE_VOLUME_SIZE
Default: `64`
The root volume size for the workload node.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_TYPE
Default: `cloud_essd`
The root volume type for workload node.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_IOPS
Default: `0`

### OPENSHIFT_PROMETHEUS_RETENTION_PERIOD
Default: `15d`
The retention period for the Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_CLASS
Default: `alicloud-disk`
The storage class for Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_SIZE
Default: `10Gi`
The storage size for Prometheus server.

### OPENSHIFT_ALERTMANAGER_STORAGE_CLASS
Default: `alicloud-disk`
The storage class for the alertmanager servers.

### OPENSHIFT_ALERTMANAGER_STORAGE_SIZE
Default: `2Gi`

### OPENSHIFT_TOGGLE_OVN_RELAY
Default: `false`
Toggle the deployment of the OVN SBSB relay.

### OVN_PATCH
Default: `false`
Toggle to patch and replace the default OVN deployment image.

### OVN_IMAGE
Default: `nil`
The OVN image that we will use to replace the default, requires `OVN_PATCH` to be `true`.
