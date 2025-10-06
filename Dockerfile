FROM alpine:3.22

# renovate: depName=yannh/kubeconform datasource=github-releases
ARG KUBECONFORM_VERSION=v0.7.0
# renovate: depName=kubernetes-sigs/kustomize datasource=github-releases
ARG KUSTOMIZE_VERSION=kustomize/v5.7.1
# renovate: depName=fluxcd/flux2 datasource=github-releases
ARG FLUX2_VERSION=v2.7.1
# renovate: depName=adrienverge/yamllint datasource=github-tags
ARG YAMLLINT_VERSION=v1.37.1

RUN apk add --no-cache curl python3 py3-pip bash git yq ca-certificates openssh-client

# Install kubeconform
RUN mkdir /tmp/kubeconform \
  && curl -L -o /tmp/kubeconform/kubeconform.tar.gz \
  https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz \
  && tar -xzf /tmp/kubeconform/kubeconform.tar.gz -C /tmp/kubeconform \
  && mv /tmp/kubeconform/kubeconform /usr/local/bin \
  && chmod +x /usr/local/bin/kubeconform \
  && rm -rf /tmp/kubeconform

# Install kustomize
RUN mkdir /tmp/kustomize \
  && curl -L -o /tmp/kustomize/kustomize.tar.gz \
  https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION##*/}/kustomize_${KUSTOMIZE_VERSION##*/}_linux_amd64.tar.gz \
  && tar -xzf /tmp/kustomize/kustomize.tar.gz -C /tmp/kustomize \
  && mv /tmp/kustomize/kustomize /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && rm -rf /tmp/kustomize

# Install flux2
RUN mkdir /tmp/flux2 \
  && curl -L -o /tmp/flux2/flux2.tar.gz \
  https://github.com/fluxcd/flux2/releases/download/${FLUX2_VERSION}/flux_${FLUX2_VERSION#"v"}_linux_amd64.tar.gz \
  && tar -xzf /tmp/flux2/flux2.tar.gz -C /tmp/flux2 \
  && mv /tmp/flux2/flux /usr/local/bin \
  && chmod +x /usr/local/bin/flux \
  && rm -rf /tmp/flux2

# Install yamllint
RUN pip3 install --no-cache-dir --no-compile --break-system-packages yamllint==${YAMLLINT_VERSION}

# Cleanup
RUN apk del py3-pip \
  && find /usr/lib/ -type d -name '__pycache__' -exec rm -rf {} +

CMD ["/bin/bash"]
