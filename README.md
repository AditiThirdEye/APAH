# APAH
Making containers(programs) to run like water.<br><br>
Making checkpointing facility available with any container (docker is used here to demonstrate)<br>
This contains the required configuration that one would need to setup their system in order to make fault tolerant or have the facility of live migration with them.<br><br>

Checkpoint restart a facility available in the docker only works with sepcific versions of docker. Rest it does not work and checking various debian system it does not work with the latest versions.<br>
This configuration is a solution to all those problem and also a demo how can we do load balancing on server-side w.r.t cpu utilization

