# OpenShift 4 on OpenStack Post Install Documentation

The OpenShift 4 on OpenStack post install playbook is `OCP-4.X/post-install-on-osp.yml` and will install and setup some cluster management tools like cerberus on a cluster installed by [jetpack](https://github.com/redhat-performance/jetpack). The Jetpack will deploy given OpenStack version and deployes given OpenShift on top of it. The Jetpack also creates infra and workload nodes for day 2 operations.

## Usage

Running from the CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your undercloud machine as the orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/post-install-on-osp.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/post-install-on-osp.yml
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

### OPENSHIFT_POST_CONFIG
Default: `true`
Controls if "post-config" options are ran for this specific cluster. This opens the security groups for this cluster to permit more network tests to execute from the [openshift-scale/workloads](https://github.com/openshift-scale/workloads) repo.

### OPENSHIFT_DEBUG_CONFIG
Default: `true`
This enables easier debugging for a cluster by populating the initially installed cluster nodes with the kubeconfig and ssh keys for quicker out of band and hands on debugging.

### KUBECONFIG_PATH
Default: `~/.kube/config`
Path to kube_config.

### CERBERUS_CONFIG_PATH
Default: `~/cerberus.yaml`
Path to cerberus_config.

### CERBERUS IMAGE
Default: `quay.io/openshift-scale/cerberus:latest`
Image to be pulled to run the containerized version of cerberus.

### CERBERUS_URL
Default: "http://0.0.0.0:8080"
Optional arguement for cerberus configuration if cerberus is using a different URL than the default.

### DISTRIBUTION
Default: `openshift`
Distribution type supported by cerberus can be kubernetes or openshift.

### PORT
Default: `8080`
http server port where cerberus status is published.

### WATCH NODES
Default: `true`
Set to True for the cerberus to monitor the cluster nodes.

### WATCH CLUSTER OPERATORS
Default: `true`
Set to True for the cerberus to monitor the cluster operators.

### WATCH_URL_ROUTES
Default: `[]`
Route url's to be monitored by cerberus.

### WATCH NAMESPACES
Default: `'[openshift-etcd, openshift-apiserver, openshift-kube-apiserver, openshift-monitoring, openshift-kube-controller-manager, openshift-machine-api, openshift-kube-scheduler, openshift-ingress, openshift-sdn, openshift-ovn-kubernetes]'`
List the namespaces to be monitored by cerberus.

### CERBERUS_PUBLISH_STATUS
Default: `true`
When enabled, cerberus starts a light weight http server and publishes the status.

### INSPECT_COMPONENTS
Default: `false`
Enable it only when OpenShift client is supported to run. When enabled, cerberus collects logs, events and metrics of failed components.

### PROMETHEUS_URL
Default: `''`
The prometheus url.

### PROMETHEUS_BEARER_TOKEN
Default: `''`
The prometheus bearer token is needed to authenticate with prometheus.

### SLACK_INTEGRATION
Default: `false`
When enabled, cerberus reports the the failed interations and sends the report for the same on a slack channel.

### SLACK_API_TOKEN
Default: No default.
It refers to Bot User OAuth Access Token used for cerberus.

### SLACK_CHANNEL
Default: No default.
It refers to the slack channel ID the user wishes to receive the notifications for cerberus failures.

### COP_SLACK_ID
Default: `'{Monday: , Tuesday: , Wednesday: , Thursday: , Friday: , Saturday: , Sunday: }'`
When slack_integration is enabled, a cop can be assigned for each day. The cop of the day is tagged while reporting failures in a slack channel. Values are slack member ID's.

### SLACK_TEAM_ALIAS
Default: No default.
The slack team alias to be tagged while reporting failures in the slack channel when no cop is assigned.

### ITERATIONS
Default: `5`
Iterations to loop before stopping the watch in cerberus monitoring. It will be replaced with infinity when the daemon mode is enabled.

### SLEEP_TIME
Default: `60`
Sleep duration between each iteration in cerberus monitoring.

### KUBE_API_REQUEST_CHUNK_SIZE
Default: `250`
Large requests will be broken into the specified chunk size to reduce the load on API server and improve responsiveness while retrieving node and pod status in cerberus.

### DAEMON_MODE
Default: `true`
Iterations are set to infinity which means that the cerberus will monitor the resources forever.

### CORES_USAGE_PERCENTAGE
Default: `0.5`
The fraction of cores to be used for multiprocessing.

### DATABASE_PATH
Default: `/tmp/cerberus.db`
Path where cerberus database needs to be stored.

### REUSE_DATABASE
Default: `false`
When enabled, cerberus database is reused to store the failures.

### CERBERUS_ENABLE
Default: `false`
Controls whether the monitoring of Kubernetes/OpenShift cluster components by cerberus should be enabled or not.

### DATA_SERVER_ENABLE
Default: `false`
Controls whether the data server is launched.

### DATA_SERVER_ROOT_PATH
Default: `/root/data_server`
Absolute path to the data server's host's directory.

### DATA_SERVER_IMAGE
Default: `quay.io/openshift-scale/snappy-data-server`
Latest, maintained image of the snappy data server.

### DATA_SERVER_PUBLIC_HOST
Default: `localhost`  
URL to public host of data server.

### DATA_SERVER_PORT
Default: `7070`  
Service port.

### DATA_SERVER_LOG_LVL
Default: `info`  
Data server log level. Current [Uvicorn server](https://www.uvicorn.org) **options:** *'critical', 'error', 'warning', 'info', 'debug', 'trace'.
