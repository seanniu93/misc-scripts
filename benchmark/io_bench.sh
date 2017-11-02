#!/usr/bin/env bash

tests=(
seqwr
seqrd
seqrewr
rndrd
rndwr
rndrw
)

s=2G
m=60

for t in "${tests[@]}"; do
  echo ">>>> testing $t"
  sysbench --test=fileio --file-total-size=$s prepare
  sysbench --test=fileio --file-total-size=$s --file-test-mode=$t --init-rng=on --max-time=$m --max-requests=0 run
  sysbench --test=fileio --file-total-size=$s cleanup
done
