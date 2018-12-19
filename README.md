# Pact Broker Chart

[![Build Status](https://dev.azure.com/hmcts/CNP/_apis/build/status/Helm%20Charts/chart-pact-broker)](https://dev.azure.com/hmcts/CNP/_build/latest?definitionId=62)


This chart is intended for the [Pact Broker](https://github.com/pact-foundation/pact_broker/wiki/Overview).

## Links
- [Github Repository](https://github.com/pact-foundation/pact_broker)
- [Docker Image](https://hub.docker.com/r/dius/pact-broker)
- [Pact Broker Wiki](https://github.com/pact-foundation/pact_broker/wiki/Overview)
- [Thoughtworks blog](https://thoughtworks.github.io/pacto/patterns/cdc/)

## Configuration
The following table lists the configurable parameters of the Java chart and their default values.

| Parameter | Type | Description | Default |
| --------- | -----|------------ | ------- |


## Development and Testing

Default configuration (e.g. default image and ingress host) is setup for sandbox. This is suitable for local development and testing.

- Ensure you have logged in with `az cli` and are using `sandbox` subscription (use `az account show` to display the current one).
- For local development see the `Makefile` for available targets.
- To execute an end-to-end build, deploy and test run `make`.
- to clean up deployed releases, charts, test pods and local charts, run `make clean`

`helm test` will deploy a busybox container alongside the release which performs a simple HTTP request against the service health endpoint. If it doesn't return `HTTP 200` the test will fail. **NOTE:** it does NOT run with `--cleanup` so the test pod will be available for inspection.

## Azure DevOps Builds

Builds are run against the 'nonprod' AKS cluster.

### Pull Request Validation

A build is triggered when pull requests are created. This build will run `helm lint`, deploy the chart using `ci-values.yaml` and run `helm test`.

### Release Build

Triggered when the repository is tagged (e.g. when a release is created). Also performs linting and testing, and will publish the chart to ACR on success.
