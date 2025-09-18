# qwen3-embedding-0.6b

https://huggingface.co/qwen/qwen3-embedding-0.6b

quay.io/bjeon1/modelcar-catalog:qwen3-embedding-0.6b

## Building Image

```
podman build modelcar-images/qwen/qwen3-embedding-0.6b \
    -t quay.io/bjeon1/modelcar-catalog:qwen3-embedding-0.6b  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i qwen25-05b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/qwen/qwen3-embedding-0.6b/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
