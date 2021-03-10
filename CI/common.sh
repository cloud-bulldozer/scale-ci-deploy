#! /bin/bash

#common to all platforms

if [[ -z $ORCHESTRATION_USER ]];then 
    echo 'ORCHESTRATION_USER not set, exiting!'
    exit 1
fi

if [[ -z $ORCHESTRATION_HOST ]];then 
    echo 'ORCHESTRATION_HOST not set, exiting!'
    exit 1 
fi

if [[ -z $OPENSHIFT_CLIENT_LOCATION ]];then 
    echo 'OPENSHIFT_CLIENT_LOCATION not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_BASE_DOMAIN ]];then 
    echo 'OPENSHIFT_BASE_DOMAIN not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_CLUSTER_NAME ]];then 
    echo 'OPENSHIFT_CLUSTER_NAME not set, exiting!'
    exit 1
fi

if [[ -n $KUBECONFIG_PATH ]]; then
  export KUBECONFIG=$KUBECONFIG_PATH
else
  echo "Looks like kubeconfig path is not set, assuming that it's in the default location - $HOME/.kube/config"
fi

if [[ -z $SSHKEY_TOKEN ]];then 
    echo 'SSHKEY_TOKEN not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_PULL_SECRET ]];then 
    echo 'OPENSHIFT_INSTALL_PULL_SECRET not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN ]];then 
    echo 'OPENSHIFT_INSTALL_QUAY_REGISTRY_TOKEN not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_IMAGE_REGISTRY ]];then 
    echo 'OPENSHIFT_INSTALL_IMAGE_REGISTRY not set, exiting!'
    exit 1
fi

if [[ -z $OPENSHIFT_INSTALL_REGISTRY_TOKEN ]];then 
    echo 'OPENSHIFT_INSTALL_REGISTRY_TOKEN not set, exiting!'
    exit 1
fi

if [[ -z $ES_SERVER ]]; then
  echo 'ES_SERVER undefined, exiting!'
  exit 1
fi

#aws
if [[ $PLATFORM = "aws" ]];then 
    if [[ -z $AWS_PROFILE || -z $AWS_ACCESS_KEY_ID || -z $AWS_SECRET_ACCESS_KEY || -z $AWS_REGION ]]; then
        echo 'one or more aws credentials are undefined, exiting!'
        exit 1
    fi    
fi

#azure
if [[ $PLATFORM = "azure" ]];then 
    if [[ -z $AZURE_SUBSCRIPTION_ID || -z $AZURE_TENANT_ID || -z $AZURE_SERVICE_PRINCIPAL_CLIENT_ID || -z $AZURE_SERVICE_PRINCIPAL_CLIENT_SECRET || -z $AZURE_BASE_DOMAIN_RESOURCE_GROUP_NAME || -z $AZURE_REGION ]]; then
        echo 'one or more azure credentials are undefined, exiting!'
        exit 1
    fi    
fi

#gcp
if [[ $PLATFORM = "gcp" ]];then 
    if [[ -z $GCP_REGION || -z $GCP_PROJECT || -z $GCP_SERVICE_ACCOUNT || -z $GCP_SERVICE_ACCOUNT_EMAIL || -z $GCP_AUTH_KEY_FILE ]]; then
        echo 'one or more GCP credentials are undefined, exiting!'
        exit 1
    fi    
fi
