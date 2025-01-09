.DEFAULT_GOAL := all
CHART := pact-broker
RELEASE := chart-${CHART}-release
NAMESPACE := chart-tests-pact
TEST := ${RELEASE}-test-service
ACR := hmctssandbox
AKS_RESOURCE_GROUP := cnp-aks-sandbox-rg
AKS_CLUSTER := cnp-aks-sandbox-cluster

setup:
	az configure --defaults acr=${ACR}
	az acr login --name ${ACR}
	az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER}

clean:
	-helm uninstall ${RELEASE}
	-kubectl delete pod ${TEST} -n ${NAMESPACE}

lint:
	helm lint ${CHART}

deploy:
	helm install ${CHART} --name ${RELEASE} --namespace ${NAMESPACE} -f ci-values.yaml --wait --timeout 600

test:
	helm test ${RELEASE}

all: setup clean lint deploy test

.PHONY: setup clean lint deploy test all
