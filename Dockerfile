# =============================================
# Fixed Dockerfile for LivePortrait + ExpressionEditor
# =============================================

FROM runpod/worker-comfyui:5.8.4-base

# Install system dependencies (especially git)
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Install custom nodes using comfy-cli (more reliable)
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

# Install ExpressionEditor node (required for your workflow)
RUN comfy node install --exit-on-fail ComfyUI-Expression-Editor --mode remote

# Optional: Install other useful nodes
# RUN comfy node install --exit-on-fail ComfyUI-Manager --mode remote

# Download your source image
RUN wget --progress=dot:giga -O '/comfyui/input/source_image.png' \
    "https://cool-anteater-319.convex.cloud/api/storage/8d8d4f7c-c5cf-4d9f-8f71-ffd86ad219a1"

# Pre-warm models if needed (optional)
# RUN comfy model download --name insightface --type insightface || true

# Set correct permissions
RUN chown -R root:root /comfyui && chmod -R 755 /comfyui

EXPOSE 8188
WORKDIR /comfyui

CMD ["comfy", "launch", "--listen", "0.0.0.0", "--port", "8188"]
