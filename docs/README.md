# Documentation

The scale-ci-deploy repo is split into two major directories, playbooks for OpenShift 4 and playbooks for OpenShift 3.

## OpenShift 4 (OCP-4.X directory) scale-ci-deploy docs

| Environment              | IPI Install | Scale-up | Upgrade | Cleanup / Destroy            |
| ------------------------ | ----------- | -------- | ------- | ---------------------------- |
| [AWS](ocp4_aws.md)       | Yes         | Yes      | Yes     | Variable `OPENSHIFT_CLEANUP` |
| [Azure](ocp4_azure.md)   | Yes         | Yes      | Yes     | Variable `OPENSHIFT_CLEANUP` |
| [GCP](ocp4_gcp.md)       | Yes         | Yes      | No      | Variable `OPENSHIFT_CLEANUP` |
| [OpenStack](ocp4_osp.md) | Yes         | No       | Yes     | Separate Playbook            |

### OpenShift 4 Scale playbook

See the [OpenShift 4 scale document](ocp4_scale.md) for the scale playbook documentation.

### OpenShift 4 Upgrade playbook

See the [OpenShift 4 upgrade document](ocp4_upgrade.md) for the upgrade playbook documentation.

## OpenShift 3 (OCP-3.X directory) scale-ci-deploy docs

| Environment              | Install | Scale-up |
| ------------------------ | ------- | -------- |
| [OpenStack](ocp3_osp.md) | Yes     | Yes      |

## Playbooks usage in CI

For Jenkins setup, each install has a Jenkins job implemented in [scale-ci-pipeline](https://github.com/openshift-scale/scale-ci-pipeline)

To implement in your own CI, use a SCM plugin/module to clone the code into a build step. Each install variable in the docs should be implemented as a parameter for each job. An example build step for OCP 4 IPI AWS install as implemented in Jenkins would look like:

```sh
set -o pipefail
set -eux

echo "[orchestration]" > inventory
echo "${ORCHESTRATION_HOST}" >> inventory

ansible-playbook -vv -i inventory OCP-4.X/install-on-aws.yml
```
