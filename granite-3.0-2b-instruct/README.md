# Granite-3.0-2b-instruct

https://huggingface.co/ibm-granite/granite-3.0-2b-instruct

## Building Image

Once your token has been created, be sure to accept the terms and conditions for this model on the model home page.

```
podman build -t redhat-ai-services/modelcar-catalog:granite-3.0-2b-instruct . --build-arg HF_TOKEN="hf_..."
```
