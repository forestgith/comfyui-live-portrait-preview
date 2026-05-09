# =============================================
# Minimal & Stable Dockerfile for AdvancedLivePortrait
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Install only essential system packages
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Install the main custom node (this includes ExpressionEditor + LivePortrait)
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

# Set correct permissions
RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
