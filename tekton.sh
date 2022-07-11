#!/bin/sh
set -eo pipefail
t=kustomize/tekton/
s=$t/secret/
mkdir -p $s
pushd . > /dev/null
cd $s
cp ~/.aws/config awsConfig.txt
cp ~/.aws/credentials awsCredentials.txt
popd > /dev/null
kubectl kustomize $t | sed -e 's/n\(.*-\)pipelinerun$/generateN\1/' | kubectl create -f -
