# AUTOMATED CHECKPOINT AND RESTORE
***

This prototype system aims to demonstrate the use of a checkpoint restore mechanism to create a fault-tolerant system that can be replicated at a larger level to suit high-performance applications

The system's general architecture would consist of several nodes connected via a central daemon where the processes running on a given node would be monitored and coordinated by the central daemon. All of these nodes will be equipped with a checkpoint-restore(CR) facility using CR software such as CRIU and then the central daemon would be responsible for migrating a checkpoint of a process on the node that is about to fail, to a healthy node and restore the process from the checkpointed instance, ensuring fault tolerance with minimal downtime.

To replicate the above instance, we have a setup of 2 Kali-Linux docker containers with CRIU installed, running on the Docker host, which acts as the central daemon.So out of the above 2 containers, container_1 and container_2, container_1 would be running a process and at the same time store and update the checkpoint of the process after regular intervals of time.<br />
Now the prime responsibility of the daemon, Docker host is to pull the checkpoints from the container_1 after regular intervals of time and at the same time monitor the CPU utilization of the container_1 to ensure the container isn't overloaded.<br />
At any point in time, if it feels the container is being overutilized and has the chance of breakdown, it immediately migrates the latest checkpoint of the process running at container_1 to container_2 and then container_2 runs the received checkpoints to cause the process to continue executing from the last saved state rather than restating the process again thereby achieving our intended results.

## Technologies
***
The following instance is developed using followinf technologies:
* [Docker](https://docs.docker.com/engine/install/): Version __
* [CRIU](https://criu.org/Installation): Version _.___
* Shell Scripts

The directory structure here consists of the following :
* container1
* container2
* daemon_storage
* controller.sh
