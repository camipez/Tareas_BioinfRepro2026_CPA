#!/bin/bash
#
# 05_populations.sh
# -----------------
# Paso 5 del pipeline: calcula los estadisticos poblacionales y exporta los
# resultados en varios formatos de uso comun (STRUCTURE, PHYLIP, GenePop).
#
# Entrada:  $src/stacks/ (catalogo y coincidencias) y $src/popmap
# Salida:   archivos de resultados en $src/stacks/
# Uso:      bash 05_populations.sh
# Autor:    Camila Astorga
# Fecha:    2026-09-01

source "$(dirname "$0")/config.sh"

populations -t "$threads" -b 1 -P "$src/stacks/" -M "$src/popmap" \
            -p 9 -f p_value -k -r 0.75 -s \
            --structure --phylip --genepop
