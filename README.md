# Defense Unicorns UDS Core
The cross roads for integrating [UDS-IDAM](https://github.com/defenseunicorns/uds-idam), [DUBBD](https://github.com/defenseunicorns/uds-package-dubbd), and [Pepr](https://github.com/defenseunicorns/pepr) together.

### UDS Core Bundle
The [`uds-core` bundle](core/uds-bundle.yaml) is the integration point for `UDS-IDAM`, `DUBBD`, and `Pepr` where functionality can be built out for IDAM that leverages Pepr. Overtime this will progress to encompass more products and things.

In the [`uds-core` bundle config](core/uds-config.yaml) can be used to set/override application variables of the various peices of the bundle. This is done by utilizing [UDS-CLI](https://github.com/defenseunicorns/uds-cli).

### Getting Started
```bash
# Create a new k3d cluster with DUBBD + UDS-SSO + UDS-IDAM:
make cluster/full
```

### Make Targets
| Name                      | Description   |
|---------------------------|--------------------------------------|
| [cluster/create](Makefile#L18) | If an existing k3d cluster exists it will be destroyed and then a new cluster created. If no cluster exists create new. |
| [cluster/full](Makefile#L22) | Destroy any existing cluster, create a new one, then build and deploy all. |
| [build/all](Makefile#L24) | Create the build directory and build the `uds-core` bundle.  |
| [deploy/all](Makefile#L26) | Deploy the built `uds-core` bundle. |
| [build](Makefile#L28) | Create build directory. |
| [build/bundle](Makefile#L31) | Build the `uds-core` bundle. |
| [build/authservice](Makefile#L34) | Build only the [PEPR]() authservice / sso package for using in the bundle. |
| [deploy/bundle](Makefile#L37) | Deploy the `uds-core` bundle. |
| [remove/bundle](Makefile#L40) | Remove the deployed `uds-core` bundle. |
| [cleanup](Makefile#L43) | Remove all build and runtime generated files from project. |
