#!/bin/bash
#
# Script to deploy and verify deployment of the ovnkube-sbdb-relay
# ./sbdb-relay.sh deploy|verify
#

OVN_NS=openshift-ovn-kubernetes

if [[ "$1" == "deploy" ]]; then
  OVNMASTER_PODS=($(oc get po -o wide -n ${OVN_NS} | awk '/ovnkube-master/{ print $1 }'))

  echo "Deploying SBDB"
  for POD in "${OVNMASTER_PODS[@]}"; do
      oc logs ${POD} -c ovnkube-master | grep relay.go
      if [[ $? -eq 0 ]]; then
        echo "Found ovnkube-master leader: ${POD}"
        YAML=$(oc logs ${POD} -c ovnkube-master | awk '/\-\-\-/,/^\w[0-9]{4}/' | head -n -1)
        echo "${YAML}" | oc create -f -
        break
      else
        echo "${POD} does not contain relay yaml"
      fi
  done
elif [[ "$1" == "verify" ]]; then
  SBDB_IPS=($(oc get po -o wide -n ${OVN_NS} | awk '/sbdb-relay/{ print $6 }'))
  SBDB_IPS_STR="${SBDB_IPS[@]}"
  OVNKUBE_PODS=($(oc get po -n ${OVN_NS} | awk '/ovnkube-node/{ print $1 }'))
  NODE_COUNT=${#OVNKUBE_PODS[@]}
  declare -A ready
  
  echo "SBDB IPs: ${SBDB_IPS_STR}"

  # Populate array tracking node readiness state
  for PODS in "${OVNKUBE_PODS[@]}"; do
    ready[${PODS}]=false
  done
  
  # Check SBDB connection of each ovn-controller
  READY_NODES=0
  while [ "${READY_NODES}" -lt "${NODE_COUNT}" ] ; do
    for POD in "${OVNKUBE_PODS[@]}"; do
      if ! ${ready[${POD}]}; then
        echo "Searching pod ${POD} for SBDB IPs."
        oc logs ${POD} -c ovn-controller | grep -E ${SBDB_IPS_STR// /|}
        if [ $? -eq 0 ]; then
          READY_NODES=$((${READY_NODES}+1));
          echo "Found ${POD} using relays (Ready ${READY_NODES}/${NODE_COUNT})."
          ready[${POD}]=true
          break
        fi
      fi
    done
  done

  echo "All ${READY_NODES} ovnkube-nodes connected to SBDB relays."
else
  echo "$(basename "$0") requires one of two parameters: deploy or verify"
fi
