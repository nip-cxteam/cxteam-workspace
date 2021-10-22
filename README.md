# CXTeam JupyterLab Workspace

[![GHCR Image Build](https://github.com/nip-cxteam/cxteam-workspace/actions/workflows/docker-image.yml/badge.svg)](https://github.com/nip-cxteam/cxteam-workspace/actions/workflows/docker-image.yml)

This Docker image contains the JupyterLab environment when spinning up instances on the CXTeam JupyterHub cluster. It is based on [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/) with added components that allow the team to use the environment as a complete research kitchen sink.

All deployment-specific details (keys, ids, etc.) are decoupled from this image, so it can be reused for other [Kubernetes clusters](https://zero-to-jupyterhub.readthedocs.io/en/latest/) or run on a local computer.

## Usage

For the JupyterHub Kubernetes cluster, set the following on the Helm config yaml file:

* `singleuser.image.name: ghcr.io/nip-cxteam/cxteam-workspace`
* `singleuser.image.tag: master`

For testing purposes, the image can also be run through Docker:
```
docker pull ghcr.io/nip-cxteam/cxteam-workspace:master
```

## Building
GitHub actions automatically builds and published the Docker image when changes are made to this repo. For development and testing, copy this repo and build the image:

```bash
git clone git@github.com:nip-cxteam/cxteam-workspace.git
cd cxteam-workspace
docker build -t ghcr.io/nip-cxteam/cxteam-workspace ./
```

