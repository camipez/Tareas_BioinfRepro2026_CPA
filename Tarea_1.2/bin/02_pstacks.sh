#!/bin/bash
#
# 02_pstacks.sh
# -------------
# Paso 2 del pipeline: construye los loci (stacks) de cada muestra a partir de
# los alineamientos, asignando a cada una un identificador numerico unico.
#
# Entrada:  $src/aligned/<muestra>.bam
# Salida:   archivos de loci por muestra en $src/stacks/
# Uso:      bash 02_pstacks.sh
# Autor:    Camila Astorga
# Fecha:    2026-09-01

source "$(dirname "$0")/config.sh"

# El contador i asigna un ID distinto a cada muestra procesada
i=1
for file in $files
do
    pstacks -p "$threads" -t bam -m 3 -i "$i" \
            -f "$src/aligned/${file}.bam" \
            -o "$src/stacks/"
    let "i+=1"
done
