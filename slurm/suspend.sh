#!/bin/bash 



for hostSlurmd in $(scontrol show hostname $@)
do
	echo "Suspend $@" >> /tmp/suspend.log
	SLURMPID=$(ps aux | grep '-N $hostSlurmd' | awk '{print $2}' )
	CMD="kill -9 $SLURMPID"
	echo "Executing $CMD"
	eval $CMD
done



exit 0
