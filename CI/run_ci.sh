#!/bin/bash

set -o pipefail
set -eu

_platform=$@                                  #to accept the platform as input from command line

if [[ ${_platform} == '' ]]; then
  echo -e "Wrong usage, please enter a platform choice: aws/azure/gcp"
  exit 1
fi


chmod +x CI/properties_files/${_platform}_openshift_installer.sh 
source CI/properties_files/${_platform}_openshift_installer.sh       #to initialize the required env variables

export PLATFORM=$_platform
source CI/common.sh                          # to check if all environment variables are set accordingly

diff_list=`git diff --name-only origin/master`
echo -e "List of files changed : ${diff_list} \n"

cat > results.markdown << EOF
Results for scale-ci-deploy
Platform                       | Result | Runtime  |
-------------------------------|--------|----------|
EOF

test_rc=0    
start_time=`date`
  
echo -e "\n======================================================================"
echo -e "     CI test for scale-ci-deploy in ${_platform}                    "
echo -e "======================================================================\n"
  
# Create inventory File:
echo "[orchestration]" > inventory
echo "${ORCHESTRATION_HOST}" >> inventory
  
ansible-playbook -v -i inventory OCP-4.X/deploy-cluster.yml -e platform=${_platform} 

EXIT_STATUS=$?
if [ "$EXIT_STATUS" -eq "0" ]                         #to check if the test exits successfully or not
then
    result="PASS"
else
    result="FAIL"
    test_rc=1
fi

end_time=`date`
duration=`date -ud@$(($(date -ud"$end_time" +%s)-$(date -ud"$start_time" +%s))) +%T`
  
echo "${_platform}                       | ${result} | ${duration}" >> results.markdown

cat results.markdown

exit $test_rc
