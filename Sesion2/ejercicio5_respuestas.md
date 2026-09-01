**1. ¿Cuantos pasos tiene este script?**

Tiene 5 pasos, delimitados por sus 5 bloques comentados (que empiezan con #):

1. Alinear con GSnap y convertir a BAM.
2. Correr pstacks.
3. Armar la lista de muestras para cstacks.
4. Construir el catalogo con cstacks y hacer match de cada muestra con sstacks.
5. Calcular estadisticas de poblaciones con populations.

**2. ¿Que linea deberias cambiar para correrlo en tu propio equipo?**

La linea `src=$HOME/research/project`, porque define la carpeta base donde el script busca los datos de entrada y escribe todos los resultados; esa ruta no existe en otra computadora. Tambien revisaria la ruta del genoma en gsnap (-D ...), los nombres en $files, y -p 36/-t 36 segun los nucleos de mi CPU.

**3. ¿A que equivale $HOME?**

Es una variable de ambiente con la ruta de la carpeta de usuario. Se comprueba con `echo $HOME`.

**4. ¿Que hace el programa gsnap?**

Alinea las lecturas crudas (.fq) contra un genoma de referencia, produciendo un .sam — es el paso de alineamiento.

**5. ¿Que hace cada loop?**

- Loop 1: alinea cada muestra con gsnap, convierte .sam a .bam, borra el .sam.
- Loop 2: corre pstacks en cada muestra, asignandole un ID numerico que sube de 1 en 1.
- Loop 3: solo concatena texto para armar la lista de flags -s ruta que se le pasara a cstacks.
- Loop 4: corre sstacks en cada muestra contra el catalogo ya construido.
