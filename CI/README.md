## Usage Example:

Initialise the environment variables in bash script in CI/properties_files [here](properties_files/) for the required platform to deploy the cluster, certain env variables have been initialised for a CI run, however some variables are left not populated such as AWS/Azure/GCP credentials and OpenShift pull secrets.By reviewing the script you can see how the variables are intended to be populated for CI integration.

### After initialising run the below command:
```sh
$ ./CI/run_ci.sh platform
```

Where platform can be either `aws`, `azure` or `gcp`.

The orchestration host can be `localhost` or a remote machine already provisioned on the cloud in which the cluster will be deployed on.  If executing on a local machine or from Jenkins, `localhost` should be used.


