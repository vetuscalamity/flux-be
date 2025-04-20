# 1. Python 3.10 tabanlı, hafif bir ortam
FROM python:3.10-slim

# 2. Sistem paketleri
RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 libgtk2.0-dev libgtk-3-dev

# 3. Çalışma dizini
WORKDIR /app

# 4. AUTOMATIC1111 WebUI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# 5. Flux modeli indir
RUN mkdir -p /app/models/Stable-diffusion && \
    curl -L -o /app/models/Stable-diffusion/flux-v3.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

# 6. Python bağımlılıkları
RUN pip install -r requirements.txt

# 7. WebUI başlat (GPU testi bypass)
CMD ["python", "launch.py", "--listen", "--port", "10000", "--api", "--xformers", "--skip-torch-cuda-test"]
