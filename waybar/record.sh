#!/bin/bash

RECORD_DIR="$HOME/Videos/屏幕录制"
mkdir -p "$RECORD_DIR"

# ---- 状态模式：供 Waybar 查询 ----
if [ "$1" = "--status" ]; then
    if pgrep -x wf-recorder > /dev/null; then
        echo "⏺"
    else
        echo "~"
    fi
    exit 0
fi

# ---- 点击模式：切换录制 ----
if pgrep -x wf-recorder > /dev/null; then
    # 正在录制，停止
    pkill -SIGINT wf-recorder
else
    # 未录制，开始
    TIMESTAMP=$(date "+%Y-%m-%d %H%M%S")
    wf-recorder -f "$RECORD_DIR/屏幕录制 $TIMESTAMP.mp4" &
fi

# 通知 Waybar 立刻刷新 custom/record 模块
pkill -RTMIN+8 waybar