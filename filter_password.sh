#!/bin/bash

# 检查参数数量
if [ $# -ne 2 ]; then
  echo "Usage: $0 input_file output_file"
  echo "Example: $0 passwords.txt strong_passwords.txt"
  exit 1
fi

# 弱密码规则设定
min_length=8
special_chars='[!@#$%^&*()]'

# 使用参数指定输入和输出文件的路径
input_file="$1"
output_file="$2"

# 创建一个空的输出文件
> $output_file

# 遍历输入文件中的每一行（即密码），检查其是否为弱密码
while IFS= read -r password; do
  length=${#password}
  has_digit=$(grep -E '[0-9]' <<< "$password")
  has_upper=$(grep -E '[A-Z]' <<< "$password")
  has_lower=$(grep -E '[a-z]' <<< "$password")
  has_special=$(grep -E "$special_chars" <<< "$password")

  # 如果密码满足所有规则（长度、数字、大写字母、小写字母、特殊字符），则将其写入输出文件
  if [[ $length -ge $min_length && -n $has_digit && -n $has_upper && -n $has_lower && -n $has_special ]]; then
    echo "$password" >> $output_file
  fi
done < $input_file
