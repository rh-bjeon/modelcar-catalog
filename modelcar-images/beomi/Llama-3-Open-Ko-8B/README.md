# Llama-3-Open-Ko-8B

https://huggingface.co/meta-llama/Llama-3-Open-Ko-8B/

quay.io/bjeon1/modelcar-catalog:Llama-3-Open-Ko-8B

## Building Image

This model requires a user-token to authenticate with HuggingFace before pulling the model.  To generate a token, please refer to the [User access tokens](https://huggingface.co/docs/hub/en/security-tokens) documentation.

Once your token has been created, be sure to accept the terms and conditions for this model on the model home page.

```
podman build modelcar-images/beomi/Llama-3-Open-Ko-8B \
    -t quay.io/bjeon1/modelcar-catalog:Llama-3-Open-Ko-8B \
    --build-arg HF_TOKEN=$HF_TOKEN \
    --platform linux/amd64
```

export HF_TOKEN="hf_..."
podman build modelcar-images/Llama-3.1-8B-Instruct \
    -t quay.io/redhat-ai-services/modelcar-catalog:Llama-3.1-8B-Instruct \
    --build-arg HF_TOKEN=$HF_TOKEN \
    --platform linux/amd64

## Deploying Model

This model can be deployed using vLLM on OpenShift AI using the following Helm Chart.

This configuration includes some specific configurations to deploy it on an NVIDIA A10G, which may require changes for your specific GPU.

```
helm repo add redhat-ai-services https://redhat-ai-services.github.io/helm-charts/
helm repo update redhat-ai-services
helm upgrade -i llama-32-3b-instruct redhat-ai-services/vllm-kserve \
    --values modelcar-images/meta-llama/Llama-3-Open-Ko-8B/values.yaml
```

## Known Issues

### Access to model is restricted

When attempting to download the model, you may get the following error message:

```
Cannot access gated repo for url https://huggingface.co/meta-llama/Llama-3-Open-Ko-8B/resolve/9213176726f574b556790deb65791e0c5aa438b6/config.json.
Access to model meta-llama/Llama-3-Open-Ko-8B is restricted and you are not in the authorized list. Visit https://huggingface.co/meta-llama/Llama-3-Open-Ko-8B to ask for access.
```

You must accept the terms and conditions on the model homepage.
