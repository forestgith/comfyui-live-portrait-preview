# =============================================
# Clean Dockerfile for LivePortrait + ExpressionEditor
# Source image passed via API
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Fix apt and install system dependencies
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Install required custom nodes
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

RUN comfy node install --exit-on-fail ComfyUI-Expression-Editor --mode remote

# Optional: Extra dependencies for LivePortrait
RUN pip install --no-cache-dir \
    insightface==0.7.3 \
    onnxruntime-gpu \
    opencv-python-headless

# Permissions
RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
