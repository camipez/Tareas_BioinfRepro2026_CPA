rm(list=ls())
install.packages("devtools")
devtools::install_github("uqrmaie1/admixtools")
install.packages("remotes")
remotes::install_github("uqrmaie1/admixtools")

library(admixtools)
library(tidyverse)
library(ggplot2)
library(dplyr)
#Establecer el directorio de trabajo y cargar los metadatos.
setwd("C:/Users/camip/OneDrive/Desktop/Bioinfo")
#Cargar los metadatos
metadf <- read.table(
  "v62.0_1240k_public_metadata2.csv",
  header = TRUE,
  sep = ","
)
#definir datos de genotipo 
prefix <- "C:/Users/camip/OneDrive/Desktop/Bioinfo/v62.0_1240k_public"
#output F2
outdir_all <- "aadr_1000G_f2_all"

#Poblaciones seleccionadas
demo_pops <- c(
  "Altai_Neanderthal.DG",
  "Denisova.DG",
  "Russia_UstIshim_IUP.DG",
  "Luxembourg_Mesolithic.DG",
  "Turkey_Marmara_Barcin_N.AG",
  "Russia_Samara_EBA_Yamnaya.AG",
  "England_C_EBA.AG",
  "Germany_CordedWare.AG",
  "Mbuti.DG",
  "Papuan.DG",
  "CHB.DG",
  "Adygei.DG",
  "Basque.DG",
  "Druze.DG",
  "French.DG",
  "Italian_North.DG",
  "Italian_Sardinian.DG",
  "Orcadian.DG",
  "Russian.DG",
  "Sardinian.DG",
  "FIN.DG",
  "GBR.DG",
  "IBS.DG",
  "TSI.DG",
  "Chimp.REF",
  "MXL.DG",
  "Karitiana.DG",
  "PEL.DG",
  "Mixe.DG"
)
#Extraer estadísticas f2 utilizando únicamente transversiones
extract_f2(
  pref = prefix,
  outdir = outdir_all,
  pops = demo_pops,
  transitions = FALSE,
  transversions = TRUE,
  overwrite = TRUE,
  blgsize = 0.05,
  verbose = TRUE
)
#Extraer estadísticas f2 utilizando todos los sitios
extract_f2(
  pref = prefix,
  outdir = outdir_all,
  pops = demo_pops,
  overwrite = TRUE,
  blgsize = 0.05,
  verbose = TRUE
)
#Cargar los bloques f2 precalculados
f2_blocks_all <- f2_from_precomp(outdir_all)

##Estadistico F3 de mezcla
#Definir poblaciones 
popA <- c("MXL.DG", "PEL.DG", "Mixe.DG")
popB <- "IBS.DG"
popC <- "Karitiana.DG"

#Ejecutar la estadística f3
f3res <- f3(
  f2_blocks_all,
  popA,
  popB,
  popC
)
print(f3res)
##Estadístico f3 del grupo externo
#Definir poblaciones
popA <- "Luxembourg_Mesolithic.DG"

popB <- c(
  "Adygei.DG",
  "Basque.DG",
  "Druze.DG",
  "French.DG",
  "Italian_North.DG",
  "Italian_Sardinian.DG",
  "Orcadian.DG",
  "Russian.DG",
  "Sardinian.DG",
  "FIN.DG",
  "GBR.DG",
  "IBS.DG",
  "TSI.DG"
)

outg <- "Mbuti.DG"
#Ejecutar la estadística f3 del grupo externo
f3res <- f3(
  f2_blocks_all,
  outg,
  popA,
  popB
)
print(f3res)
#Ejecutar la estadística f3 del grupo externo
f3res <- f3(
  f2_blocks_all,
  outg,
  popA,
  popB
)
#Agregar información geográfica
f3res$pop3_region <- metadf$region[
  match(f3res$pop3, metadf$popid)
]
#Graficar los resultados
ggplot(
  f3res,
  aes(
    x = reorder(pop3, est),
    y = est,
    color = pop3_region
  )
) +
  geom_point(size = 3) +
  geom_errorbar(
    aes(
      ymin = est - se * 3,
      ymax = est + se * 3
    ),
    width = 0.2
  ) +
  scale_color_manual(
    values = c(
      "orange2",
      "steelblue1",
      "cyan4",
      "yellow2",
      "pink3"
    )
  ) +
  coord_flip() +
  labs(
    x = "Target population",
    y = expression(f[3]),
    color = "Region"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "right"
  )
##Estadístico f4 / Estadístico D
#definir poblaciones 
qpdstat(
  f2_blocks_all,
  pop1 = "GBR.DG",
  pop2 = "TSI.DG",
  pop3 = "Mbuti.DG",
  pop4 = "Chimp.REF"
)
#analizar varias poblaciones simultáneamente
f4res <- qpdstat(
  f2_blocks_all,
  pop1 = "GBR.DG",
  pop2 = c(
    "TSI.DG",
    "CHB.DG",
    "Mbuti.DG",
    "Papuan.DG"
  ),
  pop3 = "Altai_Neanderthal.DG",
  pop4 = "Chimp.REF"
)
print(f4res)

#Afinidad entre neandertales y denisovanos
qpdstat(
  f2_blocks_all,
  pop1 = "Altai_Neanderthal.DG",
  pop2 = "Denisova.DG",
  pop3 = "Papuan.DG",
  pop4 = "GBR.DG"
)

##QPWAVE
#Definir poblaciones
target <- "England_C_EBA.AG"

right_qpwave <- c(
  "Mbuti.DG",
  "Papuan.DG",
  "CHB.DG",
  "Denisova.DG",
  "Russia_UstIshim_IUP.DG"
)

#Ejecutar QPWAVE
wave <- qpwave(
  f2_blocks_all,
  left = c(
    target,
    "Turkey_Marmara_Barcin_N.AG",
    "Luxembourg_Mesolithic.DG",
    "Russia_Samara_EBA_Yamnaya.AG"
  ),
  right = right_qpwave
)

wave
##qpADM
#England_C_EBA.AG se puede modelar usando otras poblaciones?
adm <- qpadm(
  f2_blocks_all,
  left = c(
    target,
    "Turkey_Marmara_Barcin_N.AG",
    "Luxembourg_Mesolithic.DG",
    "Russia_Samara_EBA_Yamnaya.AG"
  ),
  right = right_qpwave,
  target = target
)
#Ver proporciones de ascendencia
view(adm$weights)

#Ver resultado modelo poblacional
view(adm$popdrop)

#Ejercicio extra con Germany
target <- "Germany_CordedWare.AG"

#ejecuto qpAdm
adm <- qpadm(
  f2_blocks_all,
  left = c(
    target,
    "Turkey_Marmara_Barcin_N.AG",
    "Luxembourg_Mesolithic.DG",
    "Russia_Samara_EBA_Yamnaya.AG"
  ),
  right = right_qpwave,
  target = target
)
# veo los resultados
view(adm$weights)
view(adm$popdrop)
