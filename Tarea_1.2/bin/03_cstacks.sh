#!/bin/bash
#
# 03_cstacks.sh
# -------------
# Paso 3 del pipeline: arma la lista de muestras y construye con ella el
# catalogo de loci comun a todas.
#
# Entrada:  archivos de loci por muestra en $src/stacks/
# Salida:   catalogo batch_1.* en $src/stacks/ y registro en $src/stacks/Log
# Uso:      bash 03_cstacks.sh
# Autor:    Camila Astorga
# Fecha:    2026-09-01

source "$(dirname "$0")/config.sh"

# Se concatena un flag -s por muestra para pasarselos todos juntos a cstacks
samp=""
for file in $files
do
    samp+="-s $src/stacks/$file "
done

# '&>>' agrega toda la salida (normal y de error) al archivo Log
cstacks -g -p "$threads" -b 1 -n 1 -o "$src/stacks" $samp &>> "$src/stacks/Log"
