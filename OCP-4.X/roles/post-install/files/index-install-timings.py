import os
import uuid
import json
import requests
from datetime import datetime

UUID = str(uuid.uuid4())
LOG_FILE = os.getenv('INSTALL_LOG', '/root/openshift_install.log')
ES = os.getenv('ES_SERVER', 'http://elastic:9200')
oc_command = '/usr/local/bin/oc'
timestamp = datetime.now().strftime("%Y-%m-%dT%T")

CLUSTER_NAME = os.popen(oc_command + " get infrastructure cluster -o jsonpath='{.status.infrastructureName}'").read()
CLUSTER_VERSION = os.popen(oc_command + " get clusterversion --no-headers -o custom-columns=name:{.status.desired.version}").read()
PLATFORM = os.popen(oc_command + " get infrastructure cluster -o jsonpath='{.status.platformStatus.type}'").read()
NETWORK_TYPE = os.popen(oc_command + " describe network.config/cluster | grep 'Network Type' |  awk '{print $3}' | head -n 1").read()

masters = int(os.popen(oc_command + " get nodes -l node-role.kubernetes.io/master --no-headers=true | wc -l").read())
workers = int(os.popen(oc_command + " get nodes -l node-role.kubernetes.io/worker,node-role.kubernetes.io/infra!=,node-role.kubernetes.io/workload!= | wc -l").read())
workload = int(os.popen(oc_command + " get nodes -l node-role.kubernetes.io/workload --no-headers=true | wc -l").read())
infra = int(os.popen(oc_command + " get nodes -l node-role.kubernetes.io/infra --no-headers=true | wc -l").read())
all = int(os.popen(oc_command + " get nodes --no-headers=true | wc -l").read())

###Parse the install log file 

#Read last 20 lines from log file
lines = os.popen("cat "+ LOG_FILE + " | tail -n 20").read()

"""
Sample Input - 
time="2022-02-12T06:50:32Z" level=info msg="Access the OpenShift web-console here: devcluster.openshift.com"
time="2022-02-12T06:50:32Z" level=info msg="Login to the console with user: \"kubeadmin\", and password: \"abcdef""
time="2022-02-12T06:50:32Z" level=debug msg="Time elapsed per stage:"
time="2022-02-12T06:50:32Z" level=debug msg="           cluster: 5m34s"
time="2022-02-12T06:50:32Z" level=debug msg="         bootstrap: 31s"
time="2022-02-12T06:50:32Z" level=debug msg="Bootstrap Complete: 14m36s"
time="2022-02-12T06:50:32Z" level=debug msg="               API: 2m13s"
time="2022-02-12T06:50:32Z" level=debug msg=" Bootstrap Destroy: 1m9s"
time="2022-02-12T06:50:32Z" level=debug msg=" Cluster Operators: 10m58s"
time="2022-02-12T06:50:32Z" level=info msg="Time elapsed: 32m59s

"""

#'Time elapsed per stage' string is common in all the log files, and all required timings are found below its index.
x = lines.index("Time elapsed per stage")
lines = (lines[x:].split("\n"))[1:]
data = []
for i in lines[:-1]:
    x = i[i.index('msg="')+5:]
    x = x.lstrip().rstrip().split(':')
    data.append(x)

output = {}
for i in data:
    title = i[0]
    time = i[1].strip()
    temp = 0
    if 'm' in time:
        time = time.split('m')

        min = int(time[0])*60
        temp += min
        sec = int(time[1].split('s')[0])
        temp += sec
    else:
        sec = int(time.split('s')[0])
        temp += sec
    output[title] = temp

"""
Sample Output - 
{'cluster': 334, 'bootstrap': 31, 'Bootstrap Complete': 876, 'API': 133, 'Bootstrap Destroy': 69, 'Cluster Operators': 658, 'Time elapsed': 1979}
"""


### Index data to Elasticsearch
headers = {
    'Content-type': 'application/json',
    'Cache-Control': 'no-cache'
}

print(f"Indexing data to Elasticsearch: {ES}/openshift-install-timings")
for action in output:
    data = {
        "uuid" : UUID,
        "platform": PLATFORM,
        "network_type": NETWORK_TYPE,
        "cluster_version": CLUSTER_VERSION,
        "master_count": masters,
        "worker_count": workers,
        "infra_count": infra,
        "workload_count": workload,
        "total_node_count": all,
        "cluster_name": CLUSTER_NAME,
        "action": action,
        "duration": output[action],
        "timestamp": timestamp
    }
    print(data)
    data = json.dumps(data)
    response = requests.post(ES+'/openshift-install-timings/_doc/', headers=headers, data=data)
print("Data Successfully indexed to ES on index - openshift-install-timings")
print("UUID :- " + UUID)
