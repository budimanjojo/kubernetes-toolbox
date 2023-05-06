<div align="center">

### Kubernetes Toolbox :sailboat:

</div>

## :book:&nbsp; Overview

This repository builds a Docker image that contains kubernetes tools.
I use this image to do manifest checking for my [home cluster](https://github.com/budimanjojo/home-cluster).
The version of binaries inside the container will always be the latest version available.
I use [renovate](https://github.com/renovatebot/renovate) to auto update those binaries.

## :toolbox:&nbsp; Tools included

- [kubeconform](https://github.com/yannh/kubeconform)
- [kustomize](https://github.com/kubernetes-sigs/kustomize)
- [flux](https://github.com/fluxcd/flux2)
- [yamllint](https://github.com/adrienverge/yamllint)

## :scroll:&nbsp; Usage

You can run this image directly using docker.

```
docker run --rm -it ghcr.io/budimanjojo/kubernetes-toolbox:latest /bin/bash
```

Or you can run it with Github Actions.

```
jobs:
  container:
    runs-on: ubuntu-latest
    container: ghcr.io/budimanjojo/kubernetes-toolbox:latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate manifests
        run: |
          kubeconform -strict -summary manifests.yaml
```

## License
MIT License
