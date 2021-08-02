# AUTOMATED CHECKPOINT AND RESTORE
***

This prototype system aims to demonstrate the use of a checkpoint restore mechanism to create a fault-tolerant system that can be replicated at a larger level to suit high-performance applications

The system's general architecture would consist of several nodes connected via a central daemon where the processes running on a given node would be monitored and coordinated by the central daemon. All of these nodes will be equipped with a checkpoint-restore(CR) facility using CR software such as CRIU and then the central daemon would be responsible for migrating a checkpoint of a process on the node that is about to fail, to a healthy node and restore the process from the checkpointed instance, ensuring fault tolerance with minimal downtime.

To replicate the above instance, we have a setup of 2 Kali-Linux docker containers with CRIU installed, running on the Docker host, which acts as the central daemon.So out of the above 2 containers, container_1 and container_2, container_1 would be running a process and at the same time store and update the checkpoint of the process after regular intervals of time.<br />
Now the prime responsibility of the daemon, Docker host is to pull the checkpoints from the container_1 after regular intervals of time and at the same time monitor the CPU utilization of the container_1 to ensure the container isn't overloaded.<br />
At any point in time, if it feels the container is being overutilized and has the chance of breakdown, it immediately migrates the latest checkpoint of the process running at container_1 to container_2 and then container_2 runs the received checkpoints to cause the process to continue executing from the last saved state rather than restating the process again thereby achieving our intended results.

## Technologies
***
The following instance is developed using following technologies:
* [Docker](https://docs.docker.com/engine/install/): Version __
* [CRIU](https://criu.org/Installation): Version _.___
* Shell Scripting

## Setup
***
After cloning the repository, the automated_checkpoint_restore directory consists the setup of the proposed system. <br />
This directory structure consists of the following:
* container1
  * Dockerfile
  * simple_loop 
* container2
  * Dockerfile
  * simple_loop 
* daemon_storage
* controller.sh

#### container1
It contains the essential files required to setup our first container which are:
* Dockerfile: Dockerfile to create container_1 with required specifications.
* simple_loop: This is a directory that will be copied in our container_1 and consists of files and folders for running and checkpointing our test process.

#### container2
It contains the essential files required to setup our second container which are:
* Dockerfile: Dockerfile to create container_2 with required specifications.
* simple_loop: This is a directory that will be copied in our container_2 and consists of files and folders for restoring a given test process.

#### daemeon_storage
An empty directory that acts as a storage for daemon where the checkpoints retrieved from container_1 will be stored

#### controller.sh
The coordinating shell script that performs following tasks:
* Retrieves updated checkpoints from container_1 once available
* Monitors the cpu state of container_1
* Transfers latest retrieved checkpoints to container_2 for restore if cpu utilization of container_1 exceeds a given threshold value

#### simple_loop
This directory name is common in both directories container1 and container2, and this directory will be a part of both the containers that help to run and manage the process.
In our case the process is associated with simple counting program that prints integers from 0 to 99 with a delay of 1s.<br />
A detailed structure is as follows:
* simple_loop.cpp: A simple CPP thread program that prints integers from 0 to 99.
* simple_loop: executable object file of simple_loop.cpp
* checkpoint_here.sh: Shell Script to checkpoint the given process and update in storage after regular intervals of time here 
* apah.sh: Shell script that will manage initate execution of both simple_loop program and checkpoint_here.sh
* checkpoint(directory): Directory where the checkpoints of process are stored by checkpoint_here.sh
* restore_here.sh: Shell Script that automates the restoration of a process once checkpoints are received from daemon
* restore: Directory where the checkpoints transferred by daemon(controller.sh) are stored in container_2.

## Steps to simulate the system
To demonstrate the working of above follow the given steps:
1. Clone the repository
2. Move into automated_checkpoint_restore directory
3. Create the images for container_1 and container_2 
    1. For container_1
      * Move to directory container1
      * Build image from Dockerfile by typing the command as follows:<br />
      `docker build .` <br /><br />
      `docker run --privileged -it --name container_1 [container_image_id] /bin/sh`<br />
    2. For container_2
      * Move to directory container2
      * Build image from Dockerfile by typing the command as follows:<br />
      `docker build .` <br /><br />
      `docker run --privileged -it --name container_2 [container_image_id] /bin/sh`<br />
    3. 
    
     
