cho -e "Deleting old checkpoints\n"
rm -rf daemon_storage/* 2>/dev/null
docker exec container_1 rm -rf  /simple_loop/checkpoint/* 2>/dev/null
echo -e "\n"

while true
do
docker cp container_1:/simple_loop/checkpoint/. daemon_storage 2>/dev/null
if [[ -z "$(ls -A ~/daemon_storage)" ]] ; then
        echo "Checkpoint files not available.."
else
        echo -e "\nNew Checkpoint pulled from container 1 to host"
        var=`docker stats container_2 --no-stream --format {{.CPUPerc}} 2>/dev/null`
        #echo CPU Utilization is ${var%.*}
        num=${var%.*}
        threshold=1 #cpu threshold
        if [[ $num -eq $threshold ]] ; then
                echo -e "CPU over-utilizing...\nNeeds to be started at another ideal node"
                docker cp daemon_storage/. container_2:/simple_loop/restore
                echo -e "\nCheckpoint files transferred to container 2"
                break
        else
                echo -e "CPU state at container 1 is fine, keep monitoring\n"
        fi
fi
sleep 5
done
