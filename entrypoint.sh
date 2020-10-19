#!/bin/sh

set -e

export readonly KUBECONFIG=/tmp/config

if [ -z "$KUBE_CONFIG_DATA" ]
then
	aws eks update-kubeconfig --name "$KUBE_CLUSTER" --kubeconfig "$KUBECONFIG"
else
	echo "$KUBE_CONFIG_DATA" | base64 -d >"$KUBECONFIG"
fi

exec kubectl "$@"
