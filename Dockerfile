# =============================================
# Clean & Stable Dockerfile for LivePortrait
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Install system dependencies
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Install the main custom node (includes ExpressionEditor)
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

# Extra dependencies often needed by LivePortrait
RUN pip install --no-cache-dir \
    insightface==0.7.3 \
    onnxruntime-gpu \
    opencv-python-headless

# Set permissions
RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
