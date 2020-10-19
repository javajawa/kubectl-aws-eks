#!/bin/sh

set -e

export readonly KUBECONFIG=/tmp/config

if [ -z "$KUBE_CONFIG_DATA" ]
then
	if [ -n "$AWS_ROLE" ]
	then
		aws eks update-kubeconfig --name "$KUBE_CLUSTER" --kubeconfig "$KUBECONFIG" --role-arn "$AWS_ROLE"
	else
		aws eks update-kubeconfig --name "$KUBE_CLUSTER" --kubeconfig "$KUBECONFIG"
	fi
else
	echo "$KUBE_CONFIG_DATA" | base64 -d >"$KUBECONFIG"
fi

exec kubectl "$@"
