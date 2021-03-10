export ORCHESTRATION_USER= #required field
export ORCHESTRATION_HOST= #required field
export OPENSHIFT_CLEANUP=true
export OPENSHIFT_INSTALL=true
export OPENSHIFT_POST_INSTALL=true
export OPENSHIFT_POST_CONFIG=true
export OPENSHIFT_DEBUG_CONFIG=false

# cluster version
export OPENSHIFT_CLIENT_LOCATION= #required field
export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=
export OPENSHIFT_INSTALL_BINARY_URL= 

# install
export OPENSHIFT_INSTALL_APIVERSION=v1
export OPENSHIFT_INSTALL_SSH_PUB_KEY_FILE=/root/.ssh/id_rsa.pub
export GOPATH=/root/.go
export OPENSHIFT_BASE_DOMAIN= #required field
export OPENSHIFT_CLUSTER_NAME= #required field
export OPENSHIFT_MASTER_COUNT=3
export OPENSHIFT_WORKER_COUNT=3
export OPENSHIFT_MASTER_VM_SIZE=Standard_D8s_v3
export OPENSHIFT_WORKER_VM_SIZE=Standard_D2s_v3
export OPENSHIFT_MASTER_ROOT_VOLUME_SIZE=1024
export OPENSHIFT_WORKER_ROOT_VOLUME_SIZE=1024
export OPENSHIFT_NETWORK_TYPE=OpenShiftSDN
export OPENSHIFT_CIDR=10.128.0.0/14
export OPENSHIFT_MACHINE_CIDR=10.0.0.0/16
export OPENSHIFT_SERVICE_NETWORK=172.30.0.0/16
export OPENSHIFT_HOST_PREFIX=23
export OPENSHIFT_POST_INSTALL_POLL_ATTEMPTS=600
export OPENSHIFT_TOGGLE_INFRA_NODE=true
export OPENSHIFT_TOGGLE_WORKLOAD_NODE=true
export MACHINESET_METADATA_LABEL_PREFIX=machine.openshift.io
export OPENSHIFT_INFRA_NODE_VM_SIZE=Standard_D4s_v3
export OPENSHIFT_WORKLOAD_NODE_VM_SIZE=Standard_D4s_v3
export OPENSHIFT_INFRA_NODE_VOLUME_SIZE=64
export OPENSHIFT_INFRA_NODE_VOLUME_TYPE=Premium_LRS
export OPENSHIFT_WORKLOAD_NODE_VOLUME_SIZE=64
export OPENSHIFT_WORKLOAD_NODE_VOLUME_TYPE=Premium_LRS
export OPENSHIFT_PROMETHEUS_RETENTION_PERIOD=15d
export OPENSHIFT_PROMETHEUS_STORAGE_CLASS=Premium_LRS
export OPENSHIFT_PROMETHEUS_STORAGE_SIZE=10Gi
export OPENSHIFT_ALERTMANAGER_STORAGE_CLASS=Premium_LRS
export OPENSHIFT_ALERTMANAGER_STORAGE_SIZE=2Gi

# post install
export KUBECONFIG_AUTH_DIR_PATH=
export ENABLE_DITTYBOPPER=true
export ENABLE_REMOTE_WRITE=false
export SINCGARS_REMOTE_WRITE_URL=
export SCALE_CI_BUILD_TRIGGER=true
export SCALE_CI_BUILD_TRIGGER_URL= 
export KUBECONFIG_PATH=/root/.kube/config
export JOB_ITERATIONS=1
export JENKINS_USER=
export JENKINS_API_TOKEN=
export JENKINS_ES_SERVER=


# cerberus 
export CERBERUS_ENABLE=false 
export CERBERUS_CONFIG_PATH=/root/cerberus.yml
export CERBERUS_IMAGE=quay.io/openshift-scale/cerberus:latest
export CERBERUS_URL=http://0.0.0.0:8080
export WATCH_NODES=true
export WATCH_CLUSTER_OPERATORS=true
export WATCH_NAMESPACES=[openshift-etcd,openshift-apiserver,openshift-kube-apiserver,openshift-kube-controller-manager,openshift-machine-api,openshift-kube-scheduler,openshift-ingress,openshift-sdn]
export CERBERUS_PUBLISH_STATUS=true
export INSPECT_COMPONENTS=false
export SLACK_INTEGRATION=false
export SLACK_API_TOKEN=
export SLACK_CHANNEL=
export WATCHER_SLACK_ID='{Monday:, Tuesday: , Wednesday:, Thursday: , Friday:, Saturday: , Sunday: }'
export SLACK_TEAM_ALIAS=
export ITERATIONS=5
export SLEEP_TIME=60
export DAEMON_MODE=true


# Azure specific
export AZURE_SUBSCRIPTION_ID= #required field
export AZURE_TENANT_ID= #required field
export AZURE_SERVICE_PRINCIPAL_CLIENT_ID= #required field
export AZURE_SERVICE_PRINCIPAL_CLIENT_SECRET= #required field
export AZURE_BASE_DOMAIN_RESOURCE_GROUP_NAME= #required field
export AZURE_REGION="centralus"

#elasticsearch
export ES_SERVER= #required field
export ELASTIC_CURL_URL= #required field
export ELASTIC_CURL_USER= #required field
export ELASTIC_SERVER= #required field

# credentials
export SSHKEY_TOKEN= #required field
export OPENSHIFT_INSTALL_PULL_SECRET= #required field
export OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN= #required field
export OPENSHIFT_INSTALL_IMAGE_REGISTRY= #required field
export OPENSHIFT_INSTALL_REGISTRY_TOKEN= #required field
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE=false
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE_VERSION=
export JOB_ITERATIONS=1
