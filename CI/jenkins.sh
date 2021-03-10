#! /bin/bash
#This script will be deployed on jenkins bash
#Present here only for pr review, 
#Will be removed before merge


ghprbCommentBody="/rerun aws"

export Platform=`echo $ghprbCommentBody | awk '{if (NF > 1) printf "" ; for (i=2; i<NF; i++) printf $i " "; if (NF >= 2) print $NF;}'` 
echo $Platform

#configured properties files are stored at : http://dell-r510-01.perf.lab.eng.rdu2.redhat.com/scale-ci-deploy-CI

yum install wget -y 
wget -O CI/properties_files/${Platform}_openshift_installer.sh "http://dell-r510-01.perf.lab.eng.rdu2.redhat.com/scale-ci-deploy-CI/${Platform}/${Platform}_openshift_installer.sh"
chmod +x CI/properties_files/${Platform}_openshift_installer.sh 

source CI/run_ci.sh ${Platform} 