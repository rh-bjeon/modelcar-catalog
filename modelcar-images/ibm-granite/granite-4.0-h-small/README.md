# granite-4.0-h-small

https://huggingface.co/ibm-granite/granite-4.0-h-small

quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-h-small

## Building Image

This ModelCar build downloads the model locally then copies the files to a container in multiple layers to avoid podman memory issues.

### Downloading model files locally

```
mkdir -p ./modelcar-images/ibm-granite/granite-4.0-h-small/models
podman run --rm --platform linux/amd64 \
    -v ./modelcar-images/ibm-granite/granite-4.0-h-small/models:/models \
    --env-file modelcar-images/ibm-granite/granite-4.0-h-small/downloader.env \
    quay.io/redhat-ai-services/huggingface-downloader:latest
```

### Building the ModelCar Image

```
podman build modelcar-images/ibm-granite/granite-4.0-h-small \
    -t quay.io/redhat-ai-services/modelcar-catalog:granite-4.0-h-small  \
    --platform linux/amd64
```

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i granite-40-h-small redhat-ai-services/vllm-kserve \
    --values modelcar-images/ibm-granite/granite-4.0-h-small/values.yaml
```

For more information on the above Helm Chart, you can find the source code for that chart here:

https://github.com/redhat-ai-services/helm-charts/tree/main/charts/vllm-kserve
