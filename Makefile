.DEFAULT_GOAL := all
CHART := pact-broker
RELEASE := chart-${CHART}-release
NAMESPACE := chart-tests-pact
TEST := ${RELEASE}-test-service
ACR := hmctssandbox
AKS_RESOURCE_GROUP := cnp-aks-sandbox-rg
AKS_CLUSTER := cnp-aks-sandbox-cluster

setup:
    az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER}

clean:
    -helm uninstall ${RELEASE}
    -kubectl delete pod ${TEST} -n ${NAMESPACE}

lint:
    helm lint ${CHART}

package:
    helm package ${CHART}

push:
    helm push ${CHART}-0.1.0.tgz oci://$(ACR).azurecr.io/helm

deploy:
    helm install ${RELEASE} oci://$(ACR).azurecr.io/helm/${CHART} --namespace ${NAMESPACE} -f ci-values.yaml --wait --timeout 600s

test:
    helm test ${RELEASE}

all: setup clean lint package push deploy test

.PHONY: setup clean lint package push deploy test all