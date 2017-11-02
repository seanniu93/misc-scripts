#!/usr/bin/env bash

echo ">>>> 4 threads"
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=4 run

echo ">>>> 1 thread"
sysbench --test=cpu --cpu-max-prime=20000 --num-threads=1 run
