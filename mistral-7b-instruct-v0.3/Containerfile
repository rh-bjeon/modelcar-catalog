# Base image for the modelcar Granite image
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4 as base

# Set the HF_TOKEN with --build-arg HF_TOKEN="hf_..." at build time
ARG HF_TOKEN

# The model repo to download
ENV MODEL_REPO="mistralai/Mistral-7B-Instruct-v0.3"

# Install necessary Python dependencies
RUN microdnf -y install git git-lfs python3-pip && \
    microdnf clean all

COPY requirements.txt .

# Install Hugging Face libraries
RUN pip3 install -r requirements.txt

COPY download_model.py .

# Download the necessary model files (config.json, tokenizer.json, and safetensors)
RUN python3 download_model.py

# Final image containing only the essential model files
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4

# Copy only the necessary model files from the base image
COPY --from=base /models /models

# Set the user to 1001
USER 1001
