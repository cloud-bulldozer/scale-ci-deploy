#!/usr/bin/env bash
# Machine to use in inventory file
export ORCHESTRATION_HOST="localhost"

export PUBLIC_KEY=~/.ssh/id_rsa.pub
export PRIVATE_KEY=~/.ssh/id_rsa

export ORCHESTRATION_USER=root

export OPENSHIFT_CLEANUP=false
export OPENSHIFT_INSTALL=true
export OPENSHIFT_POST_INSTALL=true
export OPENSHIFT_POST_CONFIG=true
export OPENSHIFT_DEBUG_CONFIG=false

export OPENSHIFT_CLIENT_LOCATION="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.1.9/openshift-client-linux-4.1.9.tar.gz"
export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=
export OPENSHIFT_INSTALL_APIVERSION=v1
export OPENSHIFT_INSTALL_SSH_PUB_KEY_FILE=~/.ssh/id_rsa.pub
export OPENSHIFT_INSTALL_PULL_SECRET=
export OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN=
export OPENSHIFT_INSTALL_IMAGE_REGISTRY=registry.ci.openshift.org
export OPENSHIFT_INSTALL_REGISTRY_TOKEN=
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE=false
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE_VERSION=master
export GOPATH=/root/.go

export AWS_PROFILE=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_REGION=

export OPENSHIFT_BASE_DOMAIN=
export OPENSHIFT_CLUSTER_NAME=testcluster0
export OPENSHIFT_MASTER_COUNT=3
export OPENSHIFT_WORKER_COUNT=5
export OPENSHIFT_MASTER_INSTANCE_TYPE=m5.xlarge
export OPENSHIFT_WORKER_INSTANCE_TYPE=m5.large
export OPENSHIFT_MASTER_ROOT_VOLUME_SIZE=64
export OPENSHIFT_MASTER_ROOT_VOLUME_TYPE=gp2
export OPENSHIFT_MASTER_ROOT_VOLUME_IOPS=0
export OPENSHIFT_WORKER_ROOT_VOLUME_SIZE=64
export OPENSHIFT_WORKER_ROOT_VOLUME_TYPE=gp2
export OPENSHIFT_WORKER_ROOT_VOLUME_IOPS=0
export OPENSHIFT_CIDR=10.128.0.0/14
export OPENSHIFT_MACHINE_CIDR=10.0.0.0/16
export OPENSHIFT_SERVICE_NETWORK=172.30.0.0/16
export OPENSHIFT_HOST_PREFIX=23

export OPENSHIFT_POST_INSTALL_POLL_ATTEMPTS=600
export OPENSHIFT_TOGGLE_INFRA_NODE=true
export OPENSHIFT_TOGGLE_WORKLOAD_NODE=true
## Either machine.openshift.io or sigs.k8s.io
export MACHINESET_METADATA_LABEL_PREFIX=machine.openshift.io
export OPENSHIFT_INFRA_NODE_INSTANCE_TYPE=m5.large
export OPENSHIFT_WORKLOAD_NODE_INSTANCE_TYPE=m5.large
export OPENSHIFT_INFRA_NODE_VOLUME_SIZE=64
export OPENSHIFT_INFRA_NODE_VOLUME_TYPE=gp2
export OPENSHIFT_INFRA_NODE_VOLUME_IOPS=0
export OPENSHIFT_WORKLOAD_NODE_VOLUME_SIZE=64
export OPENSHIFT_WORKLOAD_NODE_VOLUME_TYPE=gp2
export OPENSHIFT_WORKLOAD_NODE_VOLUME_IOPS=0
export OPENSHIFT_PROMETHEUS_RETENTION_PERIOD=15d
export OPENSHIFT_PROMETHEUS_STORAGE_CLASS=gp2
export OPENSHIFT_PROMETHEUS_STORAGE_SIZE=10Gi
export OPENSHIFT_ALERTMANAGER_STORAGE_CLASS=gp2
export OPENSHIFT_ALERTMANAGER_STORAGE_SIZE=2Gi

export KUBECONFIG_AUTH_DIR_PATH=

# Clean up old kubeconfig
rm -rf OCP-4.X/kubeconfig

####################################################################################################
# Start Jenkins Build:
####################################################################################################
# List the environment variables.
set -o pipefail
set -eux

echo "[orchestration]" > inventory
echo "${ORCHESTRATION_HOST}" >> inventory

ansible-playbook -vv -i inventory -e OCP-4.X/deploy-cluster.yml -e platform=aws

####################################################################################################
# Post Jenkins Build Clean up:
####################################################################################################
rm -rf inventory
