#!/bin/sh
ip='192.168.0.1'
t=$(date +%Y-%m-%d_%H:%M)
r=`ping $ip -nc 5|tail -2|head -1`
echo $r>/code/stop
col=`awk -F, '{print $2}' /code/stop`
count=`awk -F, '{print $2}' /code/stop|awk '{print $1}'`
echo [ $t ] $r [$col] [$count] >>/code/status.log
if [ $count -eq 0 ] 
then 
    echo $t stop >/code/close.log
    /sbin/shutdown -h now
elif [ $count -lt 5 ]
    then echo 'wait'
fi
