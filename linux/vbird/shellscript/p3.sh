#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "You should input 2 numbers, i wll multiplying them! \n"
read -p "first number: " first_number
read -p "second number: " second_number
result=$((${first_number} * ${second_number})) #變成 result = $((${first_number} * ${second_number}))會出錯
echo -e "\nThe result of ${first_number} * ${second_number} is ${result}"