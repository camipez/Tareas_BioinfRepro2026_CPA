# `bin/` — Pipeline de Stacks modularizado

Versión modular del script de ejemplo del manual de Stacks (Actividad 6 de la Tarea 1.2). El script
original, que ejecutaba todos los pasos de corrido, se dividió en un subscript por paso más un script
maestro que los coordina.

## Archivos

| Archivo | Paso | Qué hace |
|---|---|---|
| `config.sh` | — | Variables compartidas (`src`, `files`, `threads`). Es el único archivo que hay que editar para cambiar de equipo o de muestras. |
| `01_alinear_gsnap.sh` | 1 | Alinea las lecturas `.fq` contra el genoma de referencia con GSnap y convierte el SAM a BAM. |
| `02_pstacks.sh` | 2 | Construye los loci de cada muestra con `pstacks`, asignando un ID numérico único. |
| `03_cstacks.sh` | 3 | Arma la lista de muestras y construye el catálogo con `cstacks`. |
| `04_sstacks.sh` | 4 | Compara los loci de cada muestra contra el catálogo con `sstacks`. |
| `05_populations.sh` | 5 | Calcula estadísticos poblacionales y exporta a STRUCTURE, PHYLIP y GenePop. |
| `master_pipeline.sh` | — | Ejecuta los cinco pasos en orden. |

La numeración de los archivos refleja el orden de ejecución.

## Uso

1. Editar `config.sh` con la ruta del proyecto, la lista de muestras y el número de procesadores.
2. Dar permisos de ejecución (solo la primera vez):

   ```bash
   chmod +x *.sh
   ```

3. Ejecutar el pipeline completo:

   ```bash
   bash master_pipeline.sh
   ```

   O bien un paso aislado, por ejemplo:

   ```bash
   bash 02_pstacks.sh
   ```

## Requisitos

`gsnap`, `samtools` y la suite Stacks (`pstacks`, `cstacks`, `sstacks`, `populations`) instalados y
disponibles en el `PATH`. El directorio indicado en `src` debe contener los subdirectorios
`samples/`, `aligned/` y `stacks/`, y el archivo `popmap`.

## Estructura de directorios esperada

```
$src/
├── samples/     <- lecturas crudas (.fq)
├── aligned/     <- alineamientos (.bam) generados en el paso 1
├── stacks/      <- loci, catálogo y resultados de los pasos 2 a 5
└── popmap       <- mapa de poblaciones usado por populations
```

## Nota

Los scripts no se ejecutaron sobre datos reales porque el equipo utilizado no tiene instalados
`gsnap`, `samtools` ni Stacks. El objetivo de la actividad era la organización modular del código.
