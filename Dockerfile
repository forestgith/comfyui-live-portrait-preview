# =============================================
# Fixed & Stable Dockerfile for LivePortrait
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Fix apt-get issues (common on RunPod)
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

# Download your source image
RUN wget --progress=dot:giga -O '/comfyui/input/source_image.png' \
    "https://cool-anteater-319.convex.cloud/api/storage/8d8d4f7c-c5cf-4d9f-8f71-ffd86ad219a1"

# Optional: Pre-install any missing dependencies for LivePortrait
RUN pip install --no-cache-dir \
    insightface==0.7.3 \
    onnxruntime-gpu \
    opencv-python-headless

# Set permissions
RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
