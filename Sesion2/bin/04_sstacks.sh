#!/bin/bash
source ./config.sh

for file in $files
do
    sstacks -g -p 36 -b 1 -c $src/stacks/batch_1 \
             -s $src/stacks/${file} \
             -o $src/stacks/ &>> $src/stacks/Log
done
