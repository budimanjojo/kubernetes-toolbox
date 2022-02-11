FROM alpine:3.15

ARG KUBECONFORM_VERSION=v0.4.12
ARG KUSTOMIZE_VERSION=v4.5.2

RUN apk --no-cache add curl

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
  https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && tar -xzf /tmp/kustomize/kustomize.tar.gz -C /tmp/kustomize \
  && mv /tmp/kustomize/kustomize /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && rm -rf /tmp/kustomize

CMD ["/bin/bash"]
