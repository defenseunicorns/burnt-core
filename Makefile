# renovate: datasource=docker depName=ghcr.io/defenseunicorns/packages/dubbd-k3d extractVersion=^(?<version>\d+\.\d+\.\d+)
DUBBD_K3D_VERSION := 0.9.0

# renovate: datasource=github-tags depName=defenseunicorns/zarf
ZARF_VERSION := v0.29.2

# renovate: datasource=github-tags depName=defenseunicorns/uds-package-metallb
METALLB_VERSION := 0.0.1

# renovate: datasource=docker depName=ghcr.io/defenseunicorns/uds-capability/uds-idam extractVersion=^(?<version>\d+\.\d+\.\d+)
IDAM_VERSION := 0.1.11

# renovate: datasource=docker depName=ghcr.io/defenseunicorns/uds-capability/uds-sso extractVersion=^(?<version>\d+\.\d+\.\d+)
SSO_VERSION := 0.1.3

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

cluster/create:
	k3d cluster delete -c dev/k3d.yaml
	k3d cluster create -c dev/k3d.yaml

cluster/full: cluster/create build/all deploy/all 

build/all: build/bundle 

deploy/all: deploy/bundle

build/bundle:
	cd core && uds bundle create --set INIT_VERSION=$(ZARF_VERSION) --set METALLB_VERSION=$(METALLB_VERSION) --set DUBBD_VERSION=$(DUBBD_K3D_VERSION) --set IDAM_VERSION=$(IDAM_VERSION) --set SSO_VERSION=$(SSO_VERSION) --confirm

deploy/bundle: ## Deploy the SSO uds bundle
	cd core && uds bundle deploy uds-bundle-uds-core-*.tar.zst --confirm

remove/bundle:
	cd core && uds bundle remove uds-bundle-uds-core-*.tar.zst --confirm

cleanup:
	rm -rf build && cd core && rm -rf run tmp bigbang.dev.* customreg.yaml on_failure.sh realm.json truststore.jks.b64 uds-bundle-uds-core-*.tar.zst values-keycloak.yaml values-authservice.yaml