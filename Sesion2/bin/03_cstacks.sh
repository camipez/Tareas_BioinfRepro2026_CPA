#!/bin/bash
source ./config.sh

samp=""
for file in $files
do
    samp+="-s $src/stacks/$file "
done

cstacks -g -p 36 -b 1 -n 1 -o $src/stacks $samp &>> $src/stacks/Log
