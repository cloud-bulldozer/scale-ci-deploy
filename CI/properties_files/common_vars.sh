
#General
export ORCHESTRATION_USER= #required field 
export ORCHESTRATION_HOST= #required field
export OPENSHIFT_CLEANUP=true
export OPENSHIFT_INSTALL=true
export OPENSHIFT_POST_INSTALL=
export OPENSHIFT_POST_CONFIG=
export OPENSHIFT_DEBUG_CONFIG=
export DESTROY_CLUSTER=

# cluster version
export OPENSHIFT_CLIENT_LOCATION= #required field
export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=
export OPENSHIFT_INSTALL_BINARY_URL= #required field


# post install
export ENABLE_DITTYBOPPER=true
export KUBECONFIG_AUTH_DIR_PATH=
export SCALE_CI_BUILD_TRIGGER=
export SCALE_CI_BUILD_TRIGGER_URL=
export JENKINS_USER=
export JENKINS_API_TOKEN=
export JENKINS_ES_SERVER=

#cerberus
export CERBERUS_ENABLE=false
export KUBECONFIG_PATH=/root/.kube/config  #required field
export CERBERUS_CONFIG_PATH=/root/cerberus.yml
export CERBERUS_IMAGE=quay.io/openshift-scale/cerberus:latest
export CERBERUS_URL=http://0.0.0.0:8080
export CERBERUS_PORT=8080
export WATCH_NODES=true
export WATCH_CLUSTER_OPERATORS=true
export WATCH_NAMESPACES=[openshift-etcd,openshift-apiserver,openshift-kube-apiserver,openshift-monitoring,openshift-kube-controller-manager,openshift-machine-api,openshift-kube-scheduler,openshift-ingress,openshift-sdn]
export watch_master_schedulable='{enabled: True, label: node-role.kubernetes.io/master}'
export CERBERUS_PUBLISH_STATUS=true
export INSPECT_COMPONENTS=false
export SLACK_INTEGRATION=false
export SLACK_API_TOKEN=
export SLACK_CHANNEL=
export WATCHER_SLACK_ID='{Monday: , Tuesday: , Wednesday: , Thursday: , Friday: , Saturday: , Sunday: }'
export SLACK_TEAM_ALIAS=
export ITERATIONS=5
export SLEEP_TIME=60
export DAEMON_MODE=true

#elasticsearch
export ES_SERVER= #required field
export ELASTIC_CURL_URL= 
export ELASTIC_CURL_USER= 
export ELASTIC_SERVER= 

# credentials
export SSHKEY_TOKEN= #required field
export OPENSHIFT_INSTALL_PULL_SECRET= #required field
export OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN= #required field
export OPENSHIFT_INSTALL_IMAGE_REGISTRY= #required field
export OPENSHIFT_INSTALL_REGISTRY_TOKEN= #required field
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE=false
export OPENSHIFT_INSTALL_INSTALLER_FROM_SOURCE_VERSION=
export JOB_ITERATIONS=1

# rhacs
export RHACS_ENABLE=false
