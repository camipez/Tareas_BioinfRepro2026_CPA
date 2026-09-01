#!/bin/bash
#
# master_pipeline.sh
# ------------------
# Script maestro: ejecuta los cinco pasos del pipeline de Stacks en el orden
# correcto. Cada paso vive en su propio subscript, de modo que tambien puede
# ejecutarse por separado para probarlo o repetirlo sin correr todo de nuevo.
#
# Uso:      bash master_pipeline.sh
# Requiere: gsnap, samtools y la suite Stacks instalados y en el PATH.
#           Las rutas y la lista de muestras se definen en config.sh.
# Autor:    Camila Astorga
# Fecha:    2026-09-01

# 'set -e' detiene el pipeline si algun paso falla, para no arrastrar errores
set -e

BIN="$(dirname "$0")"

echo "Paso 1/5: Alineando con GSnap y convirtiendo a BAM..."
bash "$BIN/01_alinear_gsnap.sh"

echo "Paso 2/5: Construyendo loci por muestra con pstacks..."
bash "$BIN/02_pstacks.sh"

echo "Paso 3/5: Construyendo el catalogo con cstacks..."
bash "$BIN/03_cstacks.sh"

echo "Paso 4/5: Pareando muestras contra el catalogo con sstacks..."
bash "$BIN/04_sstacks.sh"

echo "Paso 5/5: Calculando estadisticos poblacionales con populations..."
bash "$BIN/05_populations.sh"

echo "Pipeline completado."
