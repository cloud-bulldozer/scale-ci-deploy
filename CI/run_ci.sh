#!/bin/bash

set -o pipefail
set -eu

export PLATFORM=$@                                                 #to accept the platform as input from command line

if [[ ${PLATFORM} == '' ]]; then
  echo -e "Wrong usage, please enter a platform choice: aws/azure/gcp"
  exit 1
elif [[ ${PLATFORM} == "all" ]]; then
  declare -a test_list=("aws" "azure" "gcp")
else 
  test_list=$PLATFORM
  
fi

diff_list=`git diff --name-only origin/master`
echo -e "List of files changed : ${diff_list} \n"

cat > results.markdown << EOF
Results for scale-ci-deploy
Platform                       | Result | Runtime  |
-------------------------------|--------|----------| 
EOF

test_rc=0  

for test in ${test_list[@]}; do

  chmod +x CI/properties_files/${test}_openshift_installer.sh 
  source CI/properties_files/${test}_openshift_installer.sh        #to initialize the required env variables
  export _PLATFORM=$test                                           #needed to check the platform in common.sh
  source CI/common.sh                                              # to check if all environment variables are set accordingly
    
  start_time=`date`
  
  echo -e "\n======================================================================"
  echo -e "     CI test for scale-ci-deploy in ${test}                    "
  echo -e "======================================================================\n"
  
  # Create inventory File:
  echo "[orchestration]" > inventory
  echo "${ORCHESTRATION_HOST}" >> inventory

  export ANSIBLE_FORCE_COLOR=true 
  ansible-playbook -v -i inventory OCP-4.X/deploy-cluster.yml -e platform=${test} 

  EXIT_STATUS=$?
  if [ "$EXIT_STATUS" -eq "0" ]                                    #to check if the test exits successfully or not
  then
      result="PASS"
  else
      result="FAIL"
      test_rc=1
  fi

  end_time=`date`
  duration=`date -ud@$(($(date -ud"$end_time" +%s)-$(date -ud"$start_time" +%s))) +%T`
  
  echo "${test}                            | ${result} | ${duration}" >> results.markdown

  ##Destroy cluster, auto cleanup##
  
  start_time=`date`
  
  ansible-playbook -v -i inventory OCP-4.X/destroy-cluster.yml -e platform=$test  
   
  EXIT_STATUS=$?
  if [ "$EXIT_STATUS" -eq "0" ]                                    #to check if the test exits successfully or not
  then
      result="PASS"
  else
      result="FAIL"
  fi

  end_time=`date`
  duration=`date -ud@$(($(date -ud"$end_time" +%s)-$(date -ud"$start_time" +%s))) +%T`
  
  echo "Destroy ${test} cluster            | ${result} | ${duration}" >> results.markdown

done 

cat results.markdown

exit $test_rc
