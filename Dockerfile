# 1. Python 3.10 tabanlı, hafif bir ortam
FROM python:3.10-slim

RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 libgtk2.0-dev libgtk-3-dev

WORKDIR /app

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

RUN mkdir -p /app/models/Stable-diffusion && \
    curl -L -o /app/models/Stable-diffusion/flux-v3.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

RUN pip install -r requirements.txt

# 🔥 BU KISIM EN KRİTİK: Torch GPU test bypass
ENV COMMANDLINE_ARGS="--listen --port 10000 --api --xformers --skip-torch-cuda-test"

CMD ["python", "launch.py"]
