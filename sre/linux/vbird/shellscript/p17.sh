#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
until [ "${yn}" == "yes" -o "${yn}" == "YES" ]; do
  read -p "Please input yes/YES to stop this program: " yn
done
echo "You input the correct answer."
