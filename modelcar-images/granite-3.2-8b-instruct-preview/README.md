# Granite-3.2-8b-instruct-preview

https://huggingface.co/ibm-granite/granite-3.2-8b-instruct-preview

quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-8b-instruct-preview

## Building Image

```
podman build modelcar-images/granite-3.2-8b-instruct-preview \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-3.2-8b-instruct-preview  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-31-8b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/granite-3.2-8b-instruct-preview/values.yaml \
    --values modelcar-images/granite-3.2-8b-instruct-preview/values-a10g.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
