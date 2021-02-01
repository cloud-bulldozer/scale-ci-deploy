# scale-ci-deploy

This repo contains playbooks to install, scale and upgrade OpenShift 4 clusters on Azure, AWS, GCP, and OpenStack for the Scale-CI environment and test framework. Included are the playbooks to install and scale an OpenShift 3 cluster on OpenStack as well.

## Documentation, Usage and Examples

[See docs directory](docs/)

## Quickstart Usage Example - Install OpenShift 4 on AWS

1. Clone the repo
2. Create an inventory file with the intended orchestration host
3. Configure the install variables
4. Run the install playbook for the desired environment

```sh
$ git clone https://github.com/openshift-scale/scale-ci-deploy.git
$ cd scale-ci-deploy
$ cp OCP-4.X/inventory.example inventory
$ # Edit inventory and add your expected orchestration host
$ # Edit deployment variables (Ex vi OCP-4.X/vars/install-on-aws.yml) or define env variables
$ ansible-playbook -v -i inventory OCP-4.X/deploy-cluster.yml -e platform=aws
```

Where platform can be either `aws`, `azure` or `gcp`.

The orchestration host can be `localhost` or a remote machine already provisioned on the cloud in which the cluster will be deployed on.  If executing from Jenkins, `localhost` should be used.

An example bash script to run the playbook is provided in the docs directory [here](docs/aws-example.sh) however some variables are left not populated such as AWS credentials and OpenShift pull secret.  By reviewing the script you can see how the variables are intended to be populated by Jenkins parameters for CI integration.
