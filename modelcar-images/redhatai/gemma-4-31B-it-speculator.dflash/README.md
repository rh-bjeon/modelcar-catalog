# gemma-4-31B-it-FP8-block

https://huggingface.co/redhatai/gemma-4-31B-it-FP8-block

quay.io/redhat-ai-services/modelcar-catalog:gemma-4-31B-it-speculator.dflash

## Building Image

```
podman build modelcar-images/redhatai/gemma-4-31B-it-speculator.dflash \
    -t quay.io/bjeon1/modelcar-catalog:gemma-4-31B-it-speculator.dflash  \
    --platform linux/amd64
```
