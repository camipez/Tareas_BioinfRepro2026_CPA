#!/bin/bash
source ./config.sh

i=1
for file in $files
do
    pstacks -p 36 -t bam -m 3 -i $i \
              -f $src/aligned/${file}.bam \
              -o $src/stacks/
    let "i+=1"
done
