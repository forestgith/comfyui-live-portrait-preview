# =============================================
# Ultra-Minimal Dockerfile - Cache Breaker v3
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Strong cache breaker
RUN echo "Cache breaker - 2026-05-10 03:10 v3"

# Install git + basics
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends \
    git git-lfs ffmpeg libsm6 libxext6 libgl1 && \
    rm -rf /var/lib/apt/lists/*

# Install only the essential node
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
