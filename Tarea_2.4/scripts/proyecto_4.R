outdir <- "C:/Users/camip/Bioinfo_f2/proyecto4"
dir.create(outdir, recursive = TRUE)
dir.exists(outdir)
outdir

## Mezcla medieval/ibérica
#definir poblacion
target4    <- "IBS.DG"
iberico    <- "Spain_Visigoth_Granada.AG"
norteafr   <- "Mozabite.DG"
sources4   <- c(iberico, norteafr, "YRI.DG")
outgroups4 <- c("Mbuti.DG", "Han.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG")

#Calcular f2_blocks
all_pops <- c(target4, sources4, outgroups4)
outdir   <- "C:/Users/camip/OneDrive/Desktop/Bioinfo"

extract_f2(pref = prefix, outdir = outdir, pops = all_pops,
           overwrite = TRUE, blgsize = 0.05, verbose = TRUE,
           maxmem = 1000)

f2_blocks <- f2_from_precomp(outdir)

#f3 de grupo externo
f3_iberia <- f3(f2_blocks, pop1 = "Mbuti.DG", pop2 = target4, pop3 = sources4)
print(f3_iberia)

#f4 de asimetría
f4_iberia1 <- f4(f2_blocks, pop1 = target4, pop2 = iberico, pop3 = norteafr, pop4 = "Mbuti.DG")
f4_iberia2 <- f4(f2_blocks, pop1 = target4, pop2 = iberico, pop3 = "YRI.DG", pop4 = "Mbuti.DG")
print(f4_iberia1)
print(f4_iberia2)

#qpWave
wave4 <- qpwave(f2_blocks, left = c(target4, sources4), right = outgroups4)
print(wave4$rankdrop)

#qpAdm de dos y tres vías
admix4_2way <- qpadm(f2_blocks, left = c(target4, sources4[1:2]), right = outgroups4, target = target4)
admix4_3way <- qpadm(f2_blocks, left = c(target4, sources4), right = outgroups4, target = target4)

summary(admix4_2way)
summary(admix4_3way)

view(admix4_2way$weights)
view(admix4_2way$popdrop)
view(admix4_3way$weights)
view(admix4_3way$popdrop)
