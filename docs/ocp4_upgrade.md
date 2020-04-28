# OpenShift 4 Upgrade playbook

The OpenShift 4 upgrade playbook is `OCP-4.X/upgrade.yml` and can upgrade an existing cluster (if it is upgrade-able).

Running from CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/upgrade.yml or define Environment vars (See below)
$ ansible-playbook -vv -i inventory OCP-4.X/upgrade.yml
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

### POLL_ATTEMPTS
Default: `600`  
The number of times for the playbook to poll the OpenShift cluster to determine if the cluster has completed an upgrade.

### RHCOS_NEW_VERSION_URL
Default: No default.  
The url portion of a new version to upgrade to. An example would be `quay.io/openshift-release-dev/ocp-release` or `registry.svc.ci.openshift.org/ocp/release`.

### RHCOS_NEW_VERSION
Default: No default.  
The new version to upgrade to. Check [https://openshift-release.svc.ci.openshift.org/](https://openshift-release.svc.ci.openshift.org/) for versions and upgrade paths based on the installed cluster.

### FORCE_UPGRADE
Default: `false`  
Determines the `--force` flag value for the `oc adm upgrade` command to initiate an upgrade.

### CERBERUS_URL
Default: ""
To enable Cerberus integration add the url of cerberus in the format http://1.2.3.4:8080
