#!/bin/bash

CACHE_DIR="$HOME/.cache/fastfetch-neko"
CURRENT_IMG="$CACHE_DIR/current.png"
NEXT_IMG="$CACHE_DIR/next.png"
API_URL="https://api.nekosia.cat/api/v1/images/catgirl"

mkdir -p "$CACHE_DIR"

# 第一次运行时，如果没有当前图片，先同步下载一张
if [ ! -f "$CURRENT_IMG" ]; then
    IMAGE_URL=$(curl -s "$API_URL" | jq -r '.results[0].url')
    curl -s -o /tmp/neko-dl.tmp "$IMAGE_URL"
    convert /tmp/neko-dl.tmp -strip "$CURRENT_IMG" 2>/dev/null
    rm -f /tmp/neko-dl.tmp
fi

# 1. 先用当前图片显示 fastfetch
fastfetch --kitty "$CURRENT_IMG" --logo-width 30 --logo-height 20

# 2. 后台下载下一张，处理成 PNG 替换 current
(
    IMAGE_URL=$(curl -s "$API_URL" | jq -r '.image.compressed.url')
    curl -s -o /tmp/neko-dl.tmp "$IMAGE_URL"
    convert /tmp/neko-dl.tmp -strip "$NEXT_IMG" 2>/dev/null
    mv -f "$NEXT_IMG" "$CURRENT_IMG"
    rm -f /tmp/neko-dl.tmp
) &
