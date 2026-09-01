#!/bin/bash
#
# 01_alinear_gsnap.sh
# -------------------
# Paso 1 del pipeline: alinea las lecturas crudas contra el genoma de
# referencia con GSnap y convierte el resultado de SAM a BAM.
#
# Entrada:  $src/samples/<muestra>.fq
# Salida:   $src/aligned/<muestra>.bam
# Uso:      bash 01_alinear_gsnap.sh
# Autor:    Camila Astorga
# Fecha:    2026-09-01

source "$(dirname "$0")/config.sh"

for file in $files
do
    # Alineamiento contra el genoma de referencia; produce un SAM
    gsnap -t "$threads" -n 1 -m 5 -i 2 --min-coverage=0.90 \
          -A sam -d gac_gen_broads1_e64 \
          -D ~/research/gsnap/gac_gen_broads1_e64 \
          "$src/samples/${file}.fq" > "$src/aligned/${file}.sam"

    # Conversion a BAM (formato binario, mucho mas compacto)
    samtools view -b -S -o "$src/aligned/${file}.bam" "$src/aligned/${file}.sam"

    # Se elimina el SAM intermedio para ahorrar espacio en disco
    rm "$src/aligned/${file}.sam"
done
