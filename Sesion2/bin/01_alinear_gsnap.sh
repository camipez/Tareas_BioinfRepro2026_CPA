#!/bin/bash
source ./config.sh

for file in $files
do
    gsnap -t 36 -n 1 -m 5 -i 2 --min-coverage=0.90 \
            -A sam -d gac_gen_broads1_e64 \
            -D ~/research/gsnap/gac_gen_broads1_e64 \
            $src/samples/${file}.fq > $src/aligned/${file}.sam
    samtools view -b -S -o $src/aligned/${file}.bam $src/aligned/${file}.sam
    rm $src/aligned/${file}.sam
done
