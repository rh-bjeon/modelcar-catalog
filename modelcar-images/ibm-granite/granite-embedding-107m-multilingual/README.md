# granite-embedding-107m-multilingual

https://huggingface.co/ibm-granite/granite-embedding-107m-multilingual

quay.io/bjeon1/modelcar-catalog:granite-embedding-107m-multilingual

## Building Image

```
podman build modelcar-images/ibm-granite/granite-embedding-107m-multilingual \
    -t quay.io/bjeon1/modelcar-catalog:granite-embedding-107m-multilingual  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-embedding-107m-multilingual redhat-ai-services/vllm-kserve \
    --values modelcar-images/ibm-granite/granite-embedding-107m-multilingual/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
