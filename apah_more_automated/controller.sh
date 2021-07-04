while true
do
docker cp hopeful_pike:/simple_loop/checkpoint/. ~/w1 2>/dev/null
if [[ -z "$(ls -A ~/w1)" ]] ; then
	echo "Checkpoint files not available.."
else
	echo -e "\nNew Checkpoint pulled from container 1 to host"
	var=`docker stats hopeful_pike --no-stream --format {{.CPUPerc}} 2>/dev/null`
	#echo CPU Utilization is ${var%.*}
	num=${var%.*}
	if [[ num -gt 1 ]] ; then
        	echo -e "CPU over-utilizing...\nNeeds to be started at another ideal node"
		docker cp ~/w1/. dazzling_mirzakhani:/simple_loop/restore
		echo -e "\nCheckpoint files transferred to node 2"
	        break
	else
        	echo -e "CPU state at node 1 is fine, keep monitoring\n"
	fi
fi
sleep 5
done
