#!/bin/bash

# 指定要检查的文件列表
FILES_TO_CHECK=("file1" "file2" "file3")

# 获取最近一次提交中所有更改的文件列表
CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD)

# 遍历指定的文件列表
for file in "${FILES_TO_CHECK[@]}"; do
    # 检查当前文件是否在更改的文件列表中
    if echo "$CHANGED_FILES" | grep -q "$file"; then
        echo "文件 '$file' 有更改。"
        # 将有更改的文件赋值给 GITHUB_ENV
        GITHUB_ENV=$file
        # 这里可以添加您想要执行的命令，例如：
        echo "当前 GITHUB_ENV: $GITHUB_ENV"
        # 如果需要在这里执行命令，可以取消下一行的注释
        # some_command_to_run
    fi
done
