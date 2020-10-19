#!/bin/sh

set -e
set -x

export readonly KUBECONFIG=/tmp/config

if [ -z "$KUBE_CONFIG_DATA" ]
then
	aws eks update-kubeconfig --name "$KUBE_CLUSTER" --kubeconfig "$KUBECONFIG"  --role-arn arn:aws:iam::033374200449:role/eksctl-operations-cluster-admin
else
	echo "$KUBE_CONFIG_DATA" | base64 -d >"$KUBECONFIG"
fi

#kubectl config view
#kubectl config get-contexts                          # display list of contexts 
#kubectl config current-context                       # display the current-context
exec kubectl "$@"
