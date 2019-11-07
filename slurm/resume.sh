#!/bin/bash

exec >> /tmp/suspend.log
exec 2>> /tmp/suspend.log


for hostSlurmd in $(scontrol show hostname $@)
do
	echo "Resume $hostSlurmd" 
	if [ $(ps aux | grep "slurmd -b -N $hostSlurmd" | grep -v grep | wc -l ) -ne 0 ]
	then
		echo "Exist - killing 1st"
		PIDSLURM=$(ps aux | grep "slurmd -b -N $hostSlurmd"| grep -v grep | awk '{print $2}' )
		CMD="kill -9 $PIDSLURM"
		echo "executing $CMD"
		eval $CMD
	fi
	CMD="/mnt/slurm/sbin/slurmd -b -N $hostSlurmd"
	echo executing $CMD
	eval $CMD
done

sleep 3

exit 0 
