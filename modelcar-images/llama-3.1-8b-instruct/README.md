# llama-3.1-8b-instruct

https://huggingface.co/neuralmagic/llama-3.1-8b-instruct

quay.io/redhat-ai-services/modelcar-catalog:llama-3.1-8b-instruct

## Building Image

```
podman build modelcar-images/llama-3.1-8b-instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:llama-3.1-8b-instruct  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i llama-32-11b redhat-ai-services/vllm-kserve \
    --values modelcar-images/llama-3.1-8b-instruct/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
