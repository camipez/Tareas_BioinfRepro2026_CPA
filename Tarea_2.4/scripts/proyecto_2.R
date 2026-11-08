##¿Se puede modelar la estepa como mezcla de Irán Neolítico y EHG?
#Definir los grupos
target2   <- c("Russia_MLBA_Sintashta.AG", "Kazakhstan_Maitan_MLBA_Alakul.AG", "Russia_LBA_Srubnaya_Alakul.SG")
source2   <- c("Iran_GanjDareh_N.AG", "Russia_Sidelkino_HG.SG")
outgroup2 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")

#calcular F2blocks
all_pops <- c(target2, source2, outgroup2)
outdir   <- "aadr_1000G_f2_proyecto2"

extract_f2(pref = prefix, outdir = outdir, pops = all_pops,
           overwrite = TRUE, blgsize = 0.05, verbose = TRUE)

f2_blocks <- f2_from_precomp(outdir)

#f3 de grupo externo
f3_results <- f3(f2_blocks, pop1 = "Mbuti.DG", pop2 = target2, pop3 = source2)
f3_results

#f4 de asimetría
f4_results <- f4(f2_blocks, pop1 = target2, pop2 = source2[2], pop3 = source2[1], pop4 = "Mbuti.DG")
f4_results

#qpWave para los tres grupos
wave2 <- map_dfr(target2, function(t) {
  qpwave(f2_blocks, left = c(t, source2), right = outgroup2)$rankdrop %>%
    mutate(objetivo = t)
})
view(wave2)

#qpAdm para los tres grupos
pesos_2 <- map_dfr(target2, function(t) {
  qpadm(f2_blocks, left = c(t, source2), right = outgroup2, target = t)$weights %>%
    mutate(objetivo = t)
})
ajuste_2 <- map_dfr(target2, function(t) {
  qpadm(f2_blocks, left = c(t, source2), right = outgroup2, target = t)$popdrop %>%
    mutate(objetivo = t)
})

print(pesos_2, n = Inf)
print(ajuste_2, n = Inf)
