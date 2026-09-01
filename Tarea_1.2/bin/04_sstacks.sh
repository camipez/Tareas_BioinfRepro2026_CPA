#!/bin/bash
#
# 04_sstacks.sh
# -------------
# Paso 4 del pipeline: compara los loci de cada muestra contra el catalogo
# construido en el paso anterior.
#
# Entrada:  catalogo $src/stacks/batch_1 y loci por muestra
# Salida:   archivos de coincidencias en $src/stacks/
# Uso:      bash 04_sstacks.sh
# Autor:    Camila Astorga
# Fecha:    2026-09-01

source "$(dirname "$0")/config.sh"

for file in $files
do
    sstacks -g -p "$threads" -b 1 -c "$src/stacks/batch_1" \
            -s "$src/stacks/${file}" \
            -o "$src/stacks/" &>> "$src/stacks/Log"
done
