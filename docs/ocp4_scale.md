# OpenShift 4 Scale playbook

The scale playbook is `OCP-4.X/scale.yml` and can scale an existing cluster's worker machinesets up or down. The playbook follows the same conventions as the install playbooks in terms of running/orchestrating.

Running from CLI:

```sh
$ cp OCP-4.X/inventory.example inventory
$ # Add orchestration host to inventory
$ # Edit vars in OCP-4.X/vars/scale.yml or define Environment vars (See below)
$ ansible-playbook -vv -i inventory OCP-4.X/scale.yml
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
The number of times for the playbook to poll the OpenShift cluster to determine if the worker count has scaled as expected.

### RHCOS_METADATA_LABEL_PREFIX
Default: `machine.openshift.io`  
The prefix used in machinesets. Usually this is `machine.openshift.io` however it might be `sigs.k8s.io` depending on version installed.

### RHCOS_WORKER_COUNT
Default: `5`  
The total desired count of nodes.
