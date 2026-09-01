#!/bin/bash
# Script maestro: corre todo el pipeline de Stacks, paso por paso

echo "Paso 1: Alineando con GSnap..."
bash 01_alinear_gsnap.sh

echo "Paso 2: Corriendo pstacks..."
bash 02_pstacks.sh

echo "Paso 3: Construyendo catalogo con cstacks..."
bash 03_cstacks.sh

echo "Paso 4: Corriendo sstacks..."
bash 04_sstacks.sh

echo "Paso 5: Calculando estadisticas de poblaciones..."
bash 05_populations.sh

