#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
function printInput() {
    echo -n "Your choice is "
}
echo "This program will print your selection !"
read -p "Input your choice: " choice
case ${choice} in
"one")
	printInput; echo ${choice} | tr 'a-z' 'A-Z'
	;;
"two")
	printInput; echo ${choice} | tr 'a-z' 'A-Z'
	;;
"three")
	printInput; echo ${choice} | tr 'a-z' 'A-Z'
	;;
*)
	echo "Usage ${0} {one|two|three}"
	;;
esac