#!/bin/bash

# 指定要检查的文件列表
FILES_TO_CHECK=("config.env" "config.gki.env" "config.rubens.env" "config.ginkgo.env" "config.gki_ksu.env" "config.rubens_ksu.env" "config.rubens_ksu.env" "config.gki_lxcd.env" "config.rubens_lxcd.env" "config.ginkgo_lxcd.env" "config.gki_ksulxcd.env" "config.rubens_ksulxcd.env" "config.ginkgo_ksulxcd.env")

# 获取最近一次提交中所有更改的文件列表
CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD)

# 初始化变量来存储更改的文件
CHANGED_FILE=""

# 检查指定的文件是否有更改
for file in "${FILES_TO_CHECK[@]}"; do
    if echo "$CHANGED_FILES" | grep -q "$file"; then
        # 如果已经找到一个更改的文件，则退出循环
        if [ -n "$CHANGED_FILE" ]; then
            echo "列表中有多个文件更改。"
            exit 1
        fi
        CHANGED_FILE=$file
    fi
done

# 如果列表中只有一个文件更改，则将其赋值给 GITHUB_ENV
if [ -n "$CHANGED_FILE" ]; then
    echo "文件 '$CHANGED_FILE' 是唯一更改的文件。"
    GITHUB_ENV=$CHANGED_FILE
else
    echo "没有文件更改。"
fi

# 输出 GITHUB_ENV 的值
echo "GITHUB_ENV: $GITHUB_ENV"
