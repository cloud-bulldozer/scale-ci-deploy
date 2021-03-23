#! /bin/bash
export TERM=screen-256color
bold=$(tput bold)
uline=$(tput smul)
normal=$(tput sgr0)

log() {
  echo ${bold}$(date -u):  ${@}${normal}
}

#common to all platforms

if [[ -z $ORCHESTRATION_USER ]];then 
    log "ORCHESTRATION_USER not set, exiting!"
    exit 1
fi

if [[ -z $ORCHESTRATION_HOST ]];then 
    log "ORCHESTRATION_HOST not set, exiting!"
    exit 1 
fi

if [[ -z $OPENSHIFT_CLIENT_LOCATION ]];then 
    log "OPENSHIFT_CLIENT_LOCATION not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_BINARY_URL ]];then 
    log "OPENSHIFT_INSTALL_BINARY_URL not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_BASE_DOMAIN ]];then 
    log "OPENSHIFT_BASE_DOMAIN not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_CLUSTER_NAME ]];then 
    log "OPENSHIFT_CLUSTER_NAME not set, exiting!"
    exit 1
fi

if [[ -n $KUBECONFIG_PATH ]]; then
  export KUBECONFIG=$KUBECONFIG_PATH
else
  log "Looks like kubeconfig path is not set, assuming that it's in the default location - HOME/.kube/config"
fi

if [[ -z $SSHKEY_TOKEN ]];then 
    log "SSHKEY_TOKEN not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_PULL_SECRET ]];then 
    log "OPENSHIFT_INSTALL_PULL_SECRET not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN ]];then 
    log "OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_IMAGE_REGISTRY ]];then 
    log "OPENSHIFT_INSTALL_IMAGE_REGISTRY not set, exiting!"
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_REGISTRY_TOKEN ]];then 
    log "OPENSHIFT_INSTALL_REGISTRY_TOKEN not set, exiting!"
    exit 1
fi

if [[ -z $ES_SERVER ]]; then
  log "ES_SERVER undefined, exiting!"
  exit 1
fi

#aws
if [[ $_PLATFORM = "aws" ]];then 
    if [[ -z $AWS_PROFILE || -z $AWS_ACCESS_KEY_ID || -z $AWS_SECRET_ACCESS_KEY || -z $AWS_REGION ]]; then
        log "one or more aws credentials are undefined, exiting!"
        exit 1
    fi    
fi

#azure
if [[ $_PLATFORM = "azure" ]];then 
    if [[ -z $AZURE_SUBSCRIPTION_ID || -z $AZURE_TENANT_ID || -z $AZURE_SERVICE_PRINCIPAL_CLIENT_ID || -z $AZURE_SERVICE_PRINCIPAL_CLIENT_SECRET || -z $AZURE_BASE_DOMAIN_RESOURCE_GROUP_NAME || -z $AZURE_REGION ]]; then
        log "one or more azure credentials are undefined, exiting!"
        exit 1
    fi    
fi

#gcp
if [[ $_PLATFORM = "gcp" ]];then 
    if [[ -z $GCP_REGION || -z $GCP_PROJECT || -z $GCP_SERVICE_ACCOUNT || -z $GCP_SERVICE_ACCOUNT_EMAIL || -z $GCP_AUTH_KEY_FILE ]]; then
        log "one or more GCP credentials are undefined, exiting!"
        exit 1
    fi    
fi
