# Huggingface-modelcar-builder

[![GitHub](https://img.shields.io/badge/GitHub-repo-blue.svg)](https://github.com/redhat-ai-services/modelcar-catalog/tree/main/huggingface-modelcar-builder) [![Quay.io](https://img.shields.io/badge/Quay.io-image-blue.svg)](https://quay.io/repository/redhat-ai-services/huggingface-modelcar-builder)

## download_model

```
python download_model.py -h         
usage: download_model.py [-h] [-m MODEL_REPO] [-t TARGET_DIR] [-a ALLOW_PATTERNS [ALLOW_PATTERNS ...]]

options:
  -h, --help            show this help message and exit
  -m MODEL_REPO, --model-repo MODEL_REPO
                        The model repo on huggingface
  -t TARGET_DIR, --target-dir TARGET_DIR
                        The target directory to download the model
  -a ALLOW_PATTERNS [ALLOW_PATTERNS ...], --allow-patterns ALLOW_PATTERNS [ALLOW_PATTERNS ...]
                        The allowed patterns to download
```
