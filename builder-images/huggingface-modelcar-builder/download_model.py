import os
from typing import List

import argparse

from huggingface_hub import snapshot_download

def main(
    model_repo: str,
    local_dir: str = "./models",
    allow_patterns: List[str] = ["*.safetensors", "*.json", "*.txt"],
):
    print(f"Attempting to download the following model from huggingface: {model_repo}")
    print(f"Target director: {local_dir}")
    print(f"With allow-patterns: {allow_patterns}")

    snapshot_download(
        repo_id=model_repo,
        local_dir=local_dir,
        allow_patterns=allow_patterns,
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-m", "--model-repo", help="The model repo on huggingface", type=str
    )
    parser.add_argument(
        "-t",
        "--target-dir",
        help="The target directory to download the model",
        default="./models",
        type=str,
    )
    parser.add_argument(
        "-a",
        "--allow-patterns",
        help="The allowed patterns to download",
        nargs="+",
        default=["*.safetensors", "*.json", "*.txt"],
    )
    args = parser.parse_args()
    main(
        model_repo=args.model_repo,
        local_dir=args.target_dir,
        allow_patterns=args.allow_patterns,
    )
