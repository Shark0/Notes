#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

case ${1} in
"hello")
  echo "Hello, how are your?"
  ;;
"")
  echo "Hello, you must input parameters, ex> ${0} some_word?"
  ;;
*)
  echo "Usage ${0} hello"
  ;;
esac