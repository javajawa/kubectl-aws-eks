#!/bin/sh

set -e
set -x

export readonly KUBECONFIG=/tmp/config

if [ -z "$KUBE_CONFIG_DATA" ]
then
	aws eks update-kubeconfig --name "$KUBE_CLUSTER" --kubeconfig "$KUBECONFIG"
else
	echo "$KUBE_CONFIG_DATA" | base64 -d >"$KUBECONFIG"
fi

cat /tmp/config

aws --region eu-west-1 eks get-token --cluster-name operations-cluster
kubectl config view
kubectl config get-contexts                          # display list of contexts 
kubectl config current-context                       # display the current-context
kubectl "$@"
