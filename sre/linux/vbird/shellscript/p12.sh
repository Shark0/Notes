#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "This program will try to calculate :"
echo "How many days before your demobilization date..."
read -p "Please input your demobilization date (YYYYMMDD ex>20150716): " input_date

date_day=$(echo ${input_date} |grep '[0-9]\{8\}')
if [ "${date_day}" == "" ]; then
	echo "You input the wrong date format...."
	exit 1
fi

declare -i date_demobilization_second=$(date --date="${input_date}" +%s)
declare -i date_now_second=$(date +%s)
declare -i date_total_second=$((${date_demobilization_second}-${date_now_second}))
declare -i date_day=$((${date_total_second}/60/60/24))
if [ "${date_total_second}" -lt "0" ]; then
	echo "You had been demobilization before: " $((-1*${date_day})) " ago"
else
	declare -i date_hour=$(($((${date_total_second}-${date_day}*60*60*24))/60/60))
	echo "You will demobilize after ${date_day} days and ${date_hour} hours."
fi