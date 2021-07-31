#!/bin/bash

echo -e "Deleting old checkpoints\n"
rm -rfv checkpoint/* 2>/dev/null
echo -e "\n"

PID=$(pidof simple_loop)


while [[ $PID -eq $(pidof simple_loop) ]]
do

sleep 10

#echo "$PID removing already existing files "

# echo "starting dump $PID "
criu dump -t $PID -D checkpoint/ -j -v4 -R 2>/dev/null
echo -e "\ncheckpointed current process\n"
done
