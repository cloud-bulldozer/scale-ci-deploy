# OpenShift 4 IPI AWS Install Documentation

The OpenShift 4 IPI AWS variable file can be found at `OCP-4.X/vars/install-on-aws.yml`. It will configure the deployment playbook at `OCP-4.X/deploy-cluster.yml` to perform a cluster installation on AWS. In addition to installing a cluster, the playbook can also perform day 2 operations to include deploying three infra nodes and deploying a workload node to isolate workload driver pods from [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

## Usage

Running from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your expected orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/install-on-aws.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/deploy-cluster.yml -e platform=aws
```

## Example

[aws-example.sh](aws-example.sh) is an example script to run this playbook without modifying the vars file.

In order to execute it you should:
* Verify your ssh keys - `PUBLIC_KEY` and `PRIVATE_KEY`
* Verify `OPENSHIFT_CLIENT_LOCATION` is valid (or update to a newer client location)
* Set the release image payload `OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE`
* Populate `OPENSHIFT_INSTALL_PULL_SECRET`, `OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN`, and `OPENSHIFT_INSTALL_REGISTRY_TOKEN`
* Populate `AWS_PROFILE`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`
* Populate `OPENSHIFT_BASE_DOMAIN`

## Environment variables

## Variables which are common to various cloud providers needs to be initialised first.
Documents for initializing can be found here - [ocp4_common_env_var.md](ocp4_common_env_var.md)

After that initialize the following variables -

### AWS_PROFILE
Default: `default`
The name of the AWS profile to be set on the orchestration machine for use with the AWS cli and installer.

### AWS_ACCESS_KEY_ID
Default: No default.
The AWS access key.

### AWS_SECRET_ACCESS_KEY
Default: No default.
The AWS secret access key.

### AWS_REGION
Default: No default.
The AWS region to install on to.

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

### OPENSHIFT_MASTER_INSTANCE_TYPE
Default: `m5.xlarge`
The instance type of the masters.

### OPENSHIFT_WORKER_INSTANCE_TYPE
Default: `m5.large`
The instance type of the worker nodes.

### OPENSHIFT_MASTER_ROOT_VOLUME_SIZE
Default: `64`
The root volume disk size for the masters.

### OPENSHIFT_MASTER_ROOT_VOLUME_TYPE
Default: `gp3`
The root volume type for the masters.

### OPENSHIFT_MASTER_ROOT_VOLUME_IOPS
Default: `0`
Provisioned IOPS, when 0, it uses the default value of the volume

### OPENSHIFT_WORKER_ROOT_VOLUME_SIZE
Default: `64`
The root volume size for worker nodes.

### OPENSHIFT_WORKER_ROOT_VOLUME_TYPE
Default: `gp3`
The root volume type for worker nodes.

### OPENSHIFT_WORKER_ROOT_VOLUME_IOPS
Default: `0`
Provisioned IOPS, when 0, it uses the default value of the volume

### MACHINESET_METADATA_LABEL_PREFIX
Default: `machine.openshift.io`
The prefix used in machinesets. Usually this is `machine.openshift.io` however it might be `sigs.k8s.io` depending on version installed.

### OPENSHIFT_INFRA_NODE_INSTANCE_TYPE
Default: `m5.large`
The instance type for infra nodes.

### OPENSHIFT_WORKLOAD_NODE_INSTANCE_TYPE
Default: `m5.large`
The instance type for the workload node.

### OPENSHIFT_INFRA_NODE_VOLUME_SIZE
Default: `64`
The root volume size for the infra nodes.

### OPENSHIFT_INFRA_NODE_VOLUME_TYPE
Default: `gp3`
The root volume type for infra nodes.

### OPENSHIFT_INFRA_NODE_VOLUME_IOPS
Default: `0`
Provisioned IOPS, when 0, it uses the default value of the volume

### OPENSHIFT_WORKLOAD_NODE_VOLUME_SIZE
Default: `64`
The root volume size for the workload node.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_TYPE
Default: `gp3`
The root volume type for workload node.

### OPENSHIFT_WORKLOAD_NODE_VOLUME_IOPS
Default: `0`
Provisioned IOPS, when 0, it uses the default value of the volume

### OPENSHIFT_PROMETHEUS_RETENTION_PERIOD
Default: `15d`
The retention period for the Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_CLASS
Default: `gp3-csi`
The storage class for Prometheus server.

### OPENSHIFT_PROMETHEUS_STORAGE_SIZE
Default: `10Gi`
The storage size for Prometheus server.

### OPENSHIFT_ALERTMANAGER_STORAGE_CLASS
Default: `gp3-csi`
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

### WORKLOAD_AWS_AZ_SUFFIX
Default: `d`
Default EC2 availability zone(AZ) is set to `d`, but some regions do not have the AZ `d`, in that case you can set this to some other letter.
E.g. for `us-east-2`, you can request `us-east-2a/b/c` as `us-east-2d` does not exist.
