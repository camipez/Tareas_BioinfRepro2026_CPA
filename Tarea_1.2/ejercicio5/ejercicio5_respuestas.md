# Ejercicio 5 — Análisis del script de Stacks

Script analizado: ejemplo del [manual de Stacks](https://catchenlab.life.illinois.edu/stacks/manual/#phand).

## 1. ¿Cuántos pasos tiene este script?

Tiene **5 pasos**, delimitados por sus cinco bloques comentados (que empiezan con `#`):

1. Alinear con GSnap y convertir a BAM.
2. Correr `pstacks`.
3. Armar la lista de muestras para `cstacks`.
4. Construir el catálogo con `cstacks` y parear cada muestra con `sstacks`.
5. Calcular estadísticas de poblaciones con `populations`.

## 2. ¿Qué línea deberías cambiar para correrlo en tu propio equipo?

La línea `src=$HOME/research/project`, porque define la carpeta base donde el script busca los datos
de entrada y escribe todos los resultados, y esa ruta no existe en otra computadora. También habría
que revisar la ruta del genoma en `gsnap` (`-D ...`), los nombres de las muestras en `$files` y el
número de procesadores (`-p 36` / `-t 36`) según los núcleos de la CPU disponible.

## 3. ¿A qué equivale `$HOME`?

Es una variable de ambiente definida por el sistema operativo con la ruta de la carpeta personal del
usuario (en mi equipo, `/c/Users/camip`). Se comprueba con `echo $HOME`.

## 4. ¿Qué paso del análisis hace el programa `gsnap`?

Hace el **alineamiento**: toma las lecturas crudas (`.fq`) y las alinea contra un genoma de
referencia, produciendo un archivo `.sam` que luego se convierte a `.bam` con `samtools`.

## 5. ¿Qué hace en términos generales cada uno de los loops?

- **Loop 1:** alinea cada muestra con `gsnap`, convierte el `.sam` a `.bam` y borra el `.sam`
  intermedio para ahorrar espacio.
- **Loop 2:** corre `pstacks` en cada muestra, asignándole un ID numérico que aumenta de 1 en 1.
- **Loop 3:** no analiza datos; solo concatena texto para armar la lista de flags `-s ruta` que se le
  pasará completa a `cstacks`.
- **Loop 4:** corre `sstacks` en cada muestra contra el catálogo ya construido.
