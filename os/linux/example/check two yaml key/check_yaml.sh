#!/bin/bash

# 定義兩個 YAML 檔案
file1="config_map1.yaml"
file2="config_map2.yaml"

# 提取 key（使用 awk 過濾出冒號之前的 key），並去重排序
awk -F: '{gsub(/^[ \t]+|[ \t]+$/, "", $1); if($1 != "" && $1 !~ /^#/) print $1}' "$file1" | sort -u > keys_file1.txt
awk -F: '{gsub(/^[ \t]+|[ \t]+$/, "", $1); if($1 != "" && $1 !~ /^#/) print $1}' "$file2" | sort -u > keys_file2.txt

# 使用 awk 比較兩個 key 檔案
echo "=== 出現在 file1.yaml 但不在 file2.yaml 的 key ==="
awk 'NR==FNR {a[$1]; next} !($1 in a)' keys_file2.txt keys_file1.txt

echo "=== 出現在 file2.yaml 但不在 file1.yaml 的 key ==="
awk 'NR==FNR {a[$1]; next} !($1 in a)' keys_file1.txt keys_file2.txt

# 清理暫存文件
rm -f keys_file1.txt keys_file2.txt