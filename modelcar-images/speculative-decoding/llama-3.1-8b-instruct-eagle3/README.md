# llama-3.1-8b-instruct and EAGLE3-LLaMA3.1-Instruct-8B

This modelcar image contains the following models:

https://huggingface.co/meta-llama/llama-3.1-8b-instruct

https://huggingface.co/yuhuili/EAGLE3-LLaMA3.1-Instruct-8B

This modelcar image is intended to be utilized with vLLMs speculative decoding feature.

quay.io/redhat-ai-services/modelcar-catalog:llama-3.1-8b-instruct-eagle3

## Building Image

```
podman build modelcar-images/speculative-decoding/llama-3.1-8b-instruct-eagle3 \
    -t quay.io/redhat-ai-services/modelcar-catalog:llama-3.1-8b-instruct-eagle3  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i llama-31-8b-instruct-eagle3 redhat-ai-services/vllm-kserve \
    --values modelcar-images/speculative-decoding/llama-3.1-8b-instruct-eagle3/values.yaml \
    --values modelcar-images/speculative-decoding/llama-3.1-8b-instruct-eagle3/values-a10g.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
