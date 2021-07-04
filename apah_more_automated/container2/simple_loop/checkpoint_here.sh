#!/bin/bash

PID=$(pidof simple_loop)

sleep 10

echo "################# $PID removing already existing files "
rm -rfv checkpoint/*
echo "################# starting dump $PID "
criu dump -t $PID -D checkpoint/ -j -v4
echo "#################  dumped all the files"

 
echo "################# trying restore"

criu restore -D checkpoint/ -j
