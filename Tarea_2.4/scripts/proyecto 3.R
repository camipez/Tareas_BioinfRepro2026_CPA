metadf <- read.table(
  "v62.0_1240k_public_metadata2.csv",
  header = TRUE,
  sep = ","
)

prefix <- "v62.0_1240k_public"

##Poblamiento de las Américas
#definir los grupos
target3   <- c("Karitiana.DG", "Pima.DG", "Surui.DG", "PEL.DG", "Mixe.DG")
source3   <- c("USA_Anzick_realigned.SG", "USA_Ancient_Beringian.SG", "USA_Nevada_SpiritCave_11000BP.SG")
outgroup3 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")

#Calcular f2_blocks
all_pops <- c(target3, source3, outgroup3)
outdir   <- "aadr_1000G_f2_proyecto3"

extract_f2(pref = prefix, outdir = outdir, pops = all_pops,
           overwrite = TRUE, blgsize = 0.05, verbose = TRUE)

f2_blocks <- f2_from_precomp(outdir)

#F3 grupo externo
all_pops <- c(target3, source3, outgroup3)
outdir   <- "aadr_1000G_f2_proyecto3"

extract_f2(pref = prefix, outdir = outdir, pops = all_pops,
           overwrite = TRUE, blgsize = 0.05, verbose = TRUE)

f2_blocks <- f2_from_precomp(outdir)

#f4 de oleadas
f4_AB <- f4(f2_blocks, pop1 = source3[1], pop2 = source3[2], pop3 = target3, pop4 = "Mbuti.DG")
f4_AC <- f4(f2_blocks, pop1 = source3[1], pop2 = source3[3], pop3 = target3, pop4 = "Mbuti.DG")
f4_BC <- f4(f2_blocks, pop1 = source3[2], pop2 = source3[3], pop3 = target3, pop4 = "Mbuti.DG")
f4_AB
f4_AC
f4_BC

#f4 de afinidad australo-melanesia
f4_papuan <- f4(f2_blocks, pop1 = target3[1], pop2 = target3[-1], pop3 = "Papuan.DG", pop4 = "Mbuti.DG")
f4_papuan

#qpWave para los cinco grupos
wave3 <- map_dfr(target3, function(t) {
  qpwave(f2_blocks, left = c(t, source3), right = outgroup3)$rankdrop %>%
    mutate(objetivo = t)
})
view(wave3)

#qpAdm de dos y tres vías para los cinco grupos
pesos_A <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3[1:2]), right = outgroup3, target = t)$weights %>%
    mutate(objetivo = t)
})
pesos_B <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3[2:3]), right = outgroup3, target = t)$weights %>%
    mutate(objetivo = t)
})
pesos_3way <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3), right = outgroup3, target = t)$weights %>%
    mutate(objetivo = t)
})

ajuste_A <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3[1:2]), right = outgroup3, target = t)$popdrop %>%
    mutate(objetivo = t)
})
ajuste_B <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3[2:3]), right = outgroup3, target = t)$popdrop %>%
    mutate(objetivo = t)
})
ajuste_3way <- map_dfr(target3, function(t) {
  qpadm(f2_blocks, left = c(t, source3), right = outgroup3, target = t)$popdrop %>%
    mutate(objetivo = t)
})

view(pesos_A); view(ajuste_A)
view(pesos_B); view(ajuste_B)
view(pesos_3way); view(ajuste_3way)

