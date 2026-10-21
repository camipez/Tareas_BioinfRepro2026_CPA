
data<- read.table(file="MDS_merge2.mds",header=TRUE)
race<- read.table(file="ethnicityfile.txt",header=TRUE)
datafile<- merge(data,race,by=c("IID"))
head(datafile)

pdf("MDS.pdf",width=7,height=7)

datafile$color <- sapply(as.character(datafile$ethnicity), switch,
                     EUR="blue",
                     ASN="yellow4",
                     AMR="brown",
                     AFR="green",
                     AYM="orange",
                     MAP="darkgreen")

datafile$pch <- ifelse(datafile$ethnicity %in% c("AYM", "MAP"), 3, 1)

plot(datafile[,4],datafile[,5],type="p", xlab="MDS Component 2", ylab="MDS Component 3",pch=datafile$pch, cex=0.5, col=datafile$color)

legend("topright", pch=c(1,1,1,1,3,3),c("EUR","ASN","AMR","AFR","AYM","MAP"),col=c("blue","yellow4","brown","green", "orange","darkgreen"),bty="o",cex=1)

