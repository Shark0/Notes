#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "Please input (Y/N): " yn

if [ "${yn}" == "Y" ] || [ "${yn}" == "y" ]; then
  echo "Yes!"
  exit 0
fi
if [ "${yn}" == "N" ] || [ "${yn}" == "n" ]; then
  echo "No!"
  exit 0
fi
echo "I don't know your choice is" && exit 0;