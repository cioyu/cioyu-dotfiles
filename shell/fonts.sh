#!/bin/bash
FONTS=$(fc-list : family | tr ',' '\n' | sed 's/^ *//;s/ *$//' | sort -u | grep -v '^$')

SELECTED=$(echo "$FONTS" | gum filter --placeholder "输入关键词搜索字体...")

if [ -z "$SELECTED" ]; then
    echo "未选择任何字体。"
    exit 0
fi

echo ""
echo "字体名称: $SELECTED"
echo "----------------------------------------"

# 用 fc-match 拿到该字体对应的实际文件
FONT_FILE=$(fc-match -f "%{file}\n" "$SELECTED")

if [ -z "$FONT_FILE" ] || [ ! -f "$FONT_FILE" ]; then
    echo "未找到对应的字体文件。"
    exit 0
fi

echo "字体文件: $FONT_FILE"
echo ""

# 用 fc-query 查看这个文件的详细信息
fc-query "$FONT_FILE" | grep -E "family:|style:|fullname:|file:|lang:" | head -20
