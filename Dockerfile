# 1. Python 3.10 tabanlı, hafif bir ortam
FROM python:3.10-slim

# 2. Sistem bağımlılıkları
RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 libgtk2.0-dev libgtk-3-dev

# 3. Çalışma dizini
WORKDIR /app

# 4. AUTOMATIC1111 Web UI klonla
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# 5. MODELi indir (çalışan alternatif: Flux Depth ControlNet V3)
RUN mkdir -p /app/models/Stable-diffusion && \
    curl -L -o /app/models/Stable-diffusion/flux-depth-controlnet-v3.safetensors \
    https://huggingface.co/XLabs-AI/flux-controlnet-depth-v3/resolve/main/flux-depth-controlnet-v3.safetensors

# 6. Python bağımlılıklarını yükle
RUN pip install -r requirements.txt

# 7. Torch GPU check kapat
ENV COMMANDLINE_ARGS="--listen --port 10000 --api --xformers --skip-torch-cuda-test"

# 8. Servisi başlat
CMD ["python", "launch.py"]
