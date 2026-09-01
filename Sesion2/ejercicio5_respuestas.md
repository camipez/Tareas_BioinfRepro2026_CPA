¿Cuántos pasos tiene? Tiene 5 pasos, comienzan con un ''#'', los cuales son 
1) alinear con GSnap y convertir a BAM, 
2) pstacks
3) armar la lista de muestras para cstacks
4) construir el catálogo con cstacks y hacer match con sstacks
5) populations.
¿Qué línea cambiarías para correrlo en tu equipo? src=$HOME/research/project — define dónde están tus datos y a dónde se escribe el output, debo poner mi directorio. 
También revisaría la ruta del genoma en gsnap (-D ...), los nombres en $files, y -p 36/-t 36.
¿A qué equivale $HOME? Es una variable de entorno con la ruta de la carpeta de usuario
¿Qué hace gsnap? Alinea las lecturas crudas (.fq) contra un genoma de referencia, produciendo un .sam, es el paso de alineamiento.
¿Qué hace cada loop?
Loop 1: alinea cada muestra con gsnap, convierte .sam→.bam, borra el .sam.
Loop 2: corre pstacks en cada muestra, asignándole un ID numérico que sube de 1 en 1.
Loop 3: solo concatena texto para armar la lista de flags -s ruta que se le pasará a cstacks.
Loop 4: corre sstacks en cada muestra contra el catálogo ya construido.
