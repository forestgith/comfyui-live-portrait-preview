# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# install custom nodes into comfyui
RUN comfy node install --exit-on-fail comfyui-advancedliveportrait --mode remote

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/

# user-provided inputs override the auto-generated placeholders above.
RUN wget --progress=dot:giga -O '/comfyui/input/source_image.png' "https://cool-anteater-319.convex.cloud/api/storage/8d8d4f7c-c5cf-4d9f-8f71-ffd86ad219a1"
