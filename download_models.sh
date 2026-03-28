#!/bin/sh
set -e

# Télécharge un fichier si absent, possibilité de forcer le nom de fichier
download_urls() {
    local dest_dir="$1"; shift
    mkdir -p "$dest_dir"

    while [ "$#" -gt 0 ]; do
        local url="$1"; shift
        local forced_name="$1"; shift || true  # argument optionnel

        if [ -n "$forced_name" ]; then
            local target="$dest_dir/$forced_name"
        else
            local target="$dest_dir/$(basename "${url%%\?*}")"
        fi

        echo "➡️ Téléchargement (reprise si interrompu) : $target"
        aria2c -c -x 16 -s 16 -k 1M  --console-log-level=error -d "$dest_dir" -o "$(basename "$target")" "$url"
    done
}

#############################################
# LISTES DES TÉLÉCHARGEMENTS
#############################################

# UNET
download_urls /models/unet \
  "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q4_K_M.gguf" "Wan2.2-I2V-A14B-HighNoise-Q4_K_M.gguf" \
  "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q4_K_M.gguf" "Wan2.2-I2V-A14B-LowNoise-Q4_K_M.gguf" \
  "https://huggingface.co/QuantStack/Qwen-Image-Edit-2509-GGUF/resolve/main/Qwen-Image-Edit-2509-Q8_0.gguf" "Qwen-Image-Edit-2509-Q8_0.gguf" \
  "https://huggingface.co/unsloth/Z-Image-Turbo-GGUF/resolve/main/z-image-turbo-Q8_0.gguf" "z_image_turbo-Q8_0.gguf"

# CLIP
#download_urls /models/clip \

# TEXT ENCODERS
download_urls /models/text_encoders \
  "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors" "umt5-xxl-enc-fp8_e4m3fn.safetensors" \
  "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors" "qwen_2.5_vl_7b_fp8_scaled.safetensors" \
  "https://huggingface.co/Lockout/qwen3-4b-heretic-zimage/resolve/main/qwen-4b-zimage-hereticV2-q8.gguf" "qwen-4b-zimage-hereticV2-q8.gguf"

# VAE
download_urls /models/vae \
  "https://huggingface.co/Aitrepreneur/FLX/resolve/main/wan_2.1_vae.safetensors?download=true" "wan_2.1_vae.safetensors" \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors" "wan2.2_vae.safetensors" \
  "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors" "qwen_image_vae.safetensors" \
  "https://huggingface.co/Tongyi-MAI/Z-Image-Turbo/resolve/main/vae/diffusion_pytorch_model.safetensors" "zimage-ae.safetensors" \
  "https://huggingface.co/John6666/wai-nsfw-illustrious-sdxl-v150-sdxl/resolve/main/vae/diffusion_pytorch_model.safetensors" "sdxl_ae.safetensors"

# DIFFUSION MODELS
#download_urls /models/diffusion_models \

# CLIP VISION
#download_urls /models/clip_vision \

# CHECKPOINTS
download_urls /models/checkpoints \
  "https://huggingface.co/Aero666/Biglove.Xl4/resolve/main/bigLove_xl4.safetensors" "bigLove_xl4.safetensors" \
  "https://huggingface.co/John6666/wai-nsfw-illustrious-sdxl-v150-sdxl/resolve/main/unet/diffusion_pytorch_model.safetensors" "wai-nsfw-illustrious-sdxl-v150-sdxl"

# LORAS
download_urls /models/loras \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors" "wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors" \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors" "wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors" \
  "https://huggingface.co/litzyfitzy/WAN_DR34ML4Y/resolve/main/DR34ML4Y_I2V_14B_HIGH.safetensors" "DR34ML4Y_I2V_14B_HIGH.safetensors" \
  "https://huggingface.co/litzyfitzy/WAN_DR34ML4Y/resolve/main/DR34ML4Y_I2V_14B_LOW.safetensors" "DR34ML4Y_I2V_14B_LOW.safetensors" \
  "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-2509/Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors" "Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors" \
  "https://huggingface.co/tianweiy/DMD2/resolve/main/dmd2_sdxl_4step_lora_fp16.safetensors" "dmd2_sdxl_4step_lora_fp16.safetensors"
