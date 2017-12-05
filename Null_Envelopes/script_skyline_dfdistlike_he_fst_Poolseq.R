# TL - 060317

# to be changed
setwd("/home/tleroy/work2/ABC/Pool/rob-pet/4species/neutral_envelope/")
dfSCh <- read.table("compil_neutral_stats_RecentSC_heteroNe.txt",sep="\t",skip=1)
nameoutfile="rob-pet_quantiles_He-Fst_compil_neutral_stats_RecentSC_heteroNe.txt"

#### compute quantile per class SC scenario hetero PoolSeq

x=0 # initiate x 
y=0 # initiate y
z = NULL
while(x < 0.5) { # loop while incrémentée de 0.05, si pas de 0.05, à réduire avec la quantité de données pour plus de précision
  x <- x+0.02 # borne max
  print(x)
  print(y)
  v=NULL
  for (i in 1:nrow(dfSCh)){ # pour toutes les valeurs 
    if (dfSCh[i,6] <= x ){ # hetot en colonne 6
      if(dfSCh[i,6] > y){ 
        v = rbind(v, dfSCh[i,]) # value with name
      }
    } 
  }
  # imprimer les résultats des quantiles pour chaque milieu de classe (x-0.025, si l'incrémentation est de 0.05)
  z = rbind(z, c(x,nrow(v),quantile(v[,8], probs=c(0.005,0.025,0.25,0.5,0.75,0.975,0.99,0.995,0.999,0.9999,1,1),na.rm=T)))
  print(z)
  y <- y+0.02 # borne min
}
#z=tail(z,nrow(z)-1)
z <- as.data.frame(z)
names(z)[1] <- "midclass"
names(z)[2] <- "effectifs"
names(z)[3] <- "quant_5pm"
names(z)[4] <- "quant_25pm"
names(z)[5] <- "quant_250pm"
names(z)[6] <- "median"
names(z)[7] <- "quant_750pm"
names(z)[8] <- "quant_975pm"
names(z)[9] <- "quant_990pm"
names(z)[10] <- "quant_995pm"
names(z)[11] <- "quant_999pm"
names(z)[12] <- "quant_9999dpm"
names(z)[13] <- "max"
print("########MATRIX#########")
print(z)
write(z, file = nameoutfile)
pdf("rob-pet_quantiles_He-Fst_compil_neutral_stats_RecentSC_heteroNe.pdf",8,8)
plot(z$quant_995pm~z$midclass,type="l",xlab="He",ylab="Fst",lty=2) # 
points(z$quant_5pm~z$midclass,type="l",lty=1) # add a line to a plot
dev.off()

