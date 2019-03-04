#!/bin/bash
# This script do a quick check if one GPU or all GPUs are in good health.
# usage: ./sanity_check.sh 0   //check GPU 0
#        ./sanity_check.sh 1   //check GPU 1
#        ./sanity_check.sh     //check All GPUs in the system

workdir=`dirname $0`

if [ "$#" = "1" ]; then
	args="--device $1"
	echo -n "GPU #$1: "
	$workdir/cuda_memtest --stress --num_passes 10 --num_iterations 100   $args &>/dev/null && echo OK || echo ERROR
else
	N=$(ls /dev/nvidia?|wc -l)
	N=$((N-1))
	for i in `seq 0 $N`; do 
	echo -n "GPU #$i: "
	args="--device $i"
	$workdir/cuda_memtest --stress --num_passes 10 --num_iterations 100   $args &>/dev/null && echo OK || echo ERROR
	done
fi