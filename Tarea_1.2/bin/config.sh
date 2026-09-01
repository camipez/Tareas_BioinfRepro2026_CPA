#!/bin/bash
#
# config.sh
# ---------
# Variables compartidas por todos los subscripts del pipeline de Stacks.
# Este es el UNICO archivo que hay que editar para correr el pipeline en otro
# equipo o con otro conjunto de muestras.
#
# Uso:      no se ejecuta directamente; cada subscript lo carga con 'source'.
# Autor:    Camila Astorga
# Curso:    BioinfinvRepro 2026 - Unidad 1, Sesion 2
# Fecha:    2026-09-01

# Directorio base del proyecto. Debe contener los subdirectorios samples/,
# aligned/ y stacks/, y el archivo popmap.
export src=$HOME/research/project

# Lista de muestras a procesar (un nombre por linea, sin la extension .fq).
export files="sample_01
sample_02
sample_03"

# Numero de procesadores a usar. Ajustar segun los nucleos del equipo.
export threads=36
