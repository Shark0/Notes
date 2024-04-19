#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input a number, I will count for 1 + 2 + ... + your input: " number
result=0
for (( i = 1; i <= ${number}; i = i + 1 ))
do
	result=$((${result} + ${i}))
done
echo "The result of '1 + 2 + 3 + ... + ${number}' is ==> ${result}"