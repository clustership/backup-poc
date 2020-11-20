#!/bin/bash

NS=tethys-app

if [ "X"$1 = "X" ];
then
  echo "usage: `basename $0` <cluster>"
  exit 1
fi

cluster=$1

export KUBECONFIG="/home/centos/UPI/${cluster}/auth/kubeconfig"

if [ ! -f "${KUBECONFIG}" ];
then
  echo "kubeconfig: ${KUBECONFIG} does not exists"
  exit 1
fi

echo "Create new project ${NS}"
oc new-project ${NS}

echo "Create new sa tethys-frontend"
oc create sa tethys-frontend

#
# create more restricted scc with only NET_BIND_SERVICE should be better
#

echo "Add privileged to tethys-frontend (caution !!!)"
oc adm policy add-scc-to-user privileged -z tethys-frontend

exit 0
