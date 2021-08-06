# APAH
Making containers(programs) to run like water.<br><br>
Making checkpointing facility available with any container (docker is used here to demonstrate)<br>
This contains the required configuration that one would need to setup their system in order to make fault tolerant or have the facility of live migration with them.<br><br>

Checkpoint restart a facility available in the docker only works with specific versions of docker. Rest it does not work and checking various debian system it does not work with the latest versions.<br>
This configuration is a solution to all those problem and also a demo how can we do load balancing on server-side w.r.t cpu utilization

The below listed folders consists of the two implemented systems:
1. simple_loop: It contains code for automated checkpoint and restore of a process on same node(container)
2. automated_checkpoint_restore: It contains code to build a prototype fault tolerant system using automated checkpoint and restore mechanism.

