#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

eat[1]="賣噹噹漢堡"
eat[2]="肯爺爺炸雞"
eat[3]="彩虹日式便當"
eat[4]="越油越好吃大雅"
eat[5]="想不出吃啥學餐"
eat[6]="太師父便當"
eat[7]="池上便當"
eat[8]="懷念火車便當"
eat[9]="一起吃泡麵"
eat_count=9

eated_list_count=0
while [ "${eated_list_count}" -lt 3 ]; do
        check=$(( ${RANDOM} * ${eat_count} / 32767 + 1 ))
        is_selected=0
        if [ "${eated_list_count}" -ge 1 ]; then
                for i in $(seq 1 ${eated_list_count} )
                do
                        if [ ${eated_list[$i]} == $check ]; then
                                is_selected=1
                        fi
                done
        fi
        if [ ${is_selected} == 0 ]; then
                echo "your may eat ${eat[${check}]}"
                eated_list_count=$(( ${eated_list_count} + 1 ))
                eated_list[${eated_list_count}]=${check}
        fi
done 