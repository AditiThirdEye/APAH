#!/bin/bash
echo -e "Waiting...\n"
while true
do
sleep 5
if [[ ! -z "$(ls -A restore)" ]] ; then
echo -e "\nReceived checkpoint\n"
echo -e "\nRestoring received process...\n"
break
fi
done
criu restore -D restore/ -j 2>/dev/null
