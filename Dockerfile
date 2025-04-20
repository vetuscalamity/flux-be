# 1. Python 3.10 tabanlı, hafif bir ortam
FROM python:3.10-slim

# 2. Gerekli sistem paketlerini yükle
RUN apt update && apt install -y git wget curl libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 libgtk2.0-dev libgtk-3-dev

# 3. Çalışma dizini oluştur
WORKDIR /app

# 4. AUTOMATIC1111 WebUI’yi klonla
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# 5. Model klasörü oluştur ve Flux modelini indir
RUN mkdir -p /app/models/Stable-diffusion && \
    wget -O /app/models/Stable-diffusion/flux-v3.safetensors https://huggingface.co/SimianLuo/Flux-V3/resolve/main/flux-v3.safetensors

# 6. Python bağımlılıklarını kur
RUN pip install -r requirements.txt

# 7. Web UI’yi API modunda başlat
CMD ["python", "launch.py", "--listen", "--port", "10000", "--api", "--xformers"]
