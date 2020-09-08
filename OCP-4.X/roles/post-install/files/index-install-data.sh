#!/usr/bin/bash

export UUID=$(uuidgen)
export INSTALL_LOG=${LOG:-/root/openshift-install.log}
export ES=${ELASTIC_URL:-http://elastic:9200}
export USER=$ELASTIC_USER
if [[ -z $USER ]]; then
  export ESUSER=""
else
  export ESUSER="--user ${USER}"
fi

oc_command=/usr/local/bin/oc
timestamp=`date +"%Y-%m-%dT%T.%3N"`

CLUSTER_NAME=$($oc_command adm config get-clusters | tail -1)
PLATFORM=$($oc_command get infrastructure cluster -o jsonpath='{.status.platformStatus.type}')

masters=$($oc_command get nodes -l node-role.kubernetes.io/master --no-headers=true | wc -l)
workers=$($oc_command get nodes -l node-role.kubernetes.io/master --no-headers=true | wc -l)
workload=$($oc_command get nodes -l node-role.kubernetes.io/workload --no-headers=true | wc -l)
infra=$($oc_command get nodes -l node-role.kubernetes.io/infra --no-headers=true | wc -l)
all=$($oc_command get nodes  --no-headers=true | wc -l)

for line in $(cat ${INSTALL_LOG} | tail -n 20 | egrep "[0-9]+s\"$" | egrep -oh "[a-zA-Z]+\s?[a-zA-Z]+?:\s?([0-9]+[m|s])+" | sed 's/\s//g' | sed s/s$//g); do
  action=$(echo $line | awk -F':' '{print $1}' | sed 's/ /_/g')
  time=$(echo $line | awk -F':' '{print $2}')
  sec=$(echo $time | awk -F'm' '{print $2}')
  if [[ -z $sec ]] ; then
    min=0
    sec=$(echo $time | awk -F's' '{print $1}')
  else
    min=$(echo $time | awk -F'm' '{print $1}')
  fi
  time=$(echo $(echo $min*60|bc)+$sec | bc)
  curl $ESUSER -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
  "uuid" : "'$UUID'",
  "platform": "'$PLATFORM'",
  "master_count": '$masters',
  "worker_count": '$workers',
  "infra_count": '$infra',
  "workload_count": '$workload',
  "total_count": '$all',
  "cluster_name": "'$CLUSTER_NAME'",
  "action": "'$action'",
  "duration": '$time',
  "timestamp": "'$timestamp'"
  }' $ES/openshift_cluster_timings/_doc/
done

echo ""
echo "----------------------------------" | tee /tmp/install-uuid
echo "UUID of run : $UUID" | tee -a /tmp/install-uuid
echo "----------------------------------" | tee -a /tmp/install-uuid
echo ""
