#!/bin/bash

PID=$(pidof simple_loop)


while true
do

sleep 10

#echo "################# $PID removing already existing files "

# echo "################# starting dump $PID "
criu dump -t $PID -D checkpoint/ -j -v4 -R 2>/dev/null
echo -e "\ncheckpointed current process\n"

#echo "################# trying restore"

#criu restore -D checkpoint/ -j
done

