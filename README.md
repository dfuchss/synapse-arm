# DEPRECATED: This repo will be deleted within the next days.

# synapse arm (Fork)
[![Docker Push ARM & Other](https://github.com/dfuchss/synapse-arm/actions/workflows/deploy-docker.yml/badge.svg)](https://github.com/dfuchss/synapse-arm/actions/workflows/deploy-docker.yml)

This fork aims to provide an arm docker image (e.g. for Raspberry Pi).

The image is build as `:latest` using Github Actions from the current [master branch](https://github.com/dfuchss/synapse-arm/tree/master). See [Dockerfile](https://github.com/dfuchss/synapse-arm/blob/deploy/Dockerfile) for more information.

The [image](https://github.com/dfuchss/synapse-arm/pkgs/container/synapse) will be build once a week (or if triggered manually because I see that there's an update).
The main branch will be kept up to date via cron with upstream.

Use the following as image name: `ghcr.io/dfuchss/synapse`

The original README can be found [here](https://github.com/dfuchss/synapse-arm/blob/develop/README.rst)
