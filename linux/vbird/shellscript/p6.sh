#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input (Y/N): " yn
[ "${yn}" == "Y" -o "${yn}" == "y" ] && echo "Yes!" && exit 0
[ "${yn}" == "N" -o "${yn}" == "n" ] && echo "No!" && exit 0
echo "I don't know what your choice is" && exit 0