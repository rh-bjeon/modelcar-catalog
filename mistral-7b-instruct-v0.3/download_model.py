import os

from huggingface_hub import snapshot_download

model_repo = os.getenv("MODEL_REPO")

print(f"Attempting to download the following model from huggingface: {model_repo}")

snapshot_download(
    repo_id=model_repo,
    local_dir="/models",
    allow_patterns=["*.safetensors", "*.json", "*.txt"],
)
