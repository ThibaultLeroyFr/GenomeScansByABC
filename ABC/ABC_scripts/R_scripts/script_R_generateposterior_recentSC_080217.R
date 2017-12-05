# TL - 090616
# Ce script permet de générer les posteriors sous le modèle SI avec bottleneck

#### infos

library(nnet)
setwd("~/work2/ABC/")
source("cv4estimations.R")
#source("nnetABC.r")
setwd("/home/tleroy/work2/ABC/Pool/rob-pet/4species")
outfile="Posteriors500_Pool-rob-pet_recentSC_hetero_hetero_030317_"
outfile95CI=paste(outfile,"95CI",sep="")

print(c(outfile,outfile95CI))
##### PART1: GENERATE POSTERIORS ###### 
#ss=c(2:32)
ss=c(2:20)
ncv=1 #nombre de validations
#target=read.table("target_rob-pet.txt",sep="\t",skip=2)
#tmp=as.numeric(read.table("target_rob-pet_pool.txt",skip=2)[ss])
#target=NULL
#for(i in 1:ncv){target=rbind(target, tmp)}
#target=as.numeric(read.table("target_rob-pet.txt")[ss])

# compilation
#for i in natives_cluster1_cluster2_2ndarycont_nobottleneck_Nhetero_Mhetero_v1_*; do cd $i; ls $i; less ABCstat.txt | tail -25000 >> sumup_2ndarycont_nobottleneck_Nhetero_Mhetero_v2_ABCstat.txt; echo "" >> sumup_2ndarycont_nobottleneck_Nhetero_Mhetero_v2_ABCstat.txt; echo priorfile | tail -25000 >> sumup_2ndarycont_nobottleneck_Nhetero_Mhetero_v2_ABCstat.txt; cd .. ; done

#tmp.stat=NULL
#tmp.parameters=NULL

#for(i in 1:500){ # au lieu de 1:251
#  tmp.stat=rbind(tmp.stat, matrix(scan(paste("rob-pet_recent2ndarycont_Nhetero_Mhetero_v1_",i,"/ABCstat.txt",sep=""), skip=2), byrow=T, ncol=20)[,ss])
#  tmp.parameters=rbind(tmp.parameters, matrix(scan(paste("rob-pet_recent2ndarycont_Nhetero_Mhetero_v1_",i,"/priorfile",sep=""), skip=1), byrow=T, ncol=17))
  #M1homoNheteroM=as.numeric(read.csv("250216.pub-pyr.strictisolation.Nhetero.Mhomo.sumup.ABCstat.sed", sep="\t")[,ss])
  #M1heteroNheteroM=as.numeric(read.csv("250216.pub-pyr.island.Nhomo.Mhetero.sumup.ABCstat.sed", sep="\t")[,ss])
#}
#print(nrow(tmp.stat))
#print(ncol(tmp.stat))
#print(nrow(tmp.parameters))
#print(ncol(tmp.parameters))
#### SC

#if(nrow(tmp.stat)==nrow(tmp.parameters)){
#  prior.tmp=cbind(tmp.stat, tmp.parameters)
  #prior=rbind(prior, prior.tmp)
#}
#prior=na.omit(prior.tmp)
#print(summary(prior))
#prior <- sapply(prior,as.numeric) 
#print(is.numeric(prior))
#print(nrow(prior))
#print(ncol(prior))
#abc_nnet_multivar(target=target, x=prior[, -(1:length(ss))], sumstat=prior[, 1:length(ss)], tol=500/(nrow(prior)), rejmethod=F, noweight=F, transf=rep("logit", ncol(prior)-length(ss)), bb=rbind(apply(prior[,-(1:length(ss))], MARGIN=2, FUN="min"), apply(prior[,-(1:length(ss))], MARGIN=2, FUN="max")), nb.nnet=25, size.nnet=10, trace=T, output=outfile)

########### GENERATE 95CI OF PARAMETERS ####
#header="N1	N2	Na	Tsplit	Tsc	ratioTscTsplit	shape1Ne	shape2Ne	propNtrlNe1	propNtrlNe2	M1	M2	shape1M1	shape2M1	shape1M2	shape2M2	propNtrlM1	propNtrlM2"
# open file containging posteriors
post <- read.table(paste(outfile,"1",sep=""), header=F, sep=" ", dec=".", na.strings="na")
# add column for the ratio
postrecent <- cbind(post$V1,post$V2,post$V3,post$V4,post$V5,post$V5/post$V4,post$V6,post$V7,post$V8,post$V9,post$V10,post$V11,post$V12,post$V13,post$V14,post$V15,post$V16,post$V17)
colnames(postrecent) <- c("N1", "N2","Na","Tsplit","Tsc","ratioTscTsplit","shape1Ne","shape2Ne","propNtrlNe1","propNtrlNe2","M1","M2","shape1M1","shape2M1","shape1M2","shape2M2","propNtrlM1","propNtrlM2")
postrecent <- as.data.frame(postrecent)
# def function 95CI
quantiles_95 <- function(x) {
  r <- quantile(x, probs=c(0.05, 0.25, 0.5, 0.75, 0.95))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}
# compute 95%CI
N1 <- quantiles_95(postrecent$N1)
head(N1)
N2 <- quantiles_95(postrecent$N2)
head(N2)
Na <- quantiles_95(postrecent$Na)
Tsplit <- quantiles_95(postrecent$Tsplit)
Tsc <- quantiles_95(postrecent$Tsc)
ratioTscTsplit <- quantiles_95(postrecent$ratioTscTsplit)
shape1Ne <- quantiles_95(postrecent$shape1Ne)
shape2Ne <- quantiles_95(postrecent$shape2Ne)
propNtrlNe1 <- quantiles_95(postrecent$propNtrlNe1)
propNtrlNe2 <- quantiles_95(postrecent$propNtrlNe2)
M1 <- quantiles_95(postrecent$M1)
M2 <- quantiles_95(postrecent$M2)
shape1M1 <- quantiles_95(postrecent$shape1M1)
shape2M1 <- quantiles_95(postrecent$shape2M1)
shape1M2 <- quantiles_95(postrecent$shape1M2)
shape2M2 <- quantiles_95(postrecent$shape2M2)
propNtrlM1 <- quantiles_95(postrecent$propNtrlM1)
propNtrlM2 <- quantiles_95(postrecent$propNtrlM2)

# transformer la sortie en dataframe
N1 <- data.frame(N1)
head(N1)
N2 <- data.frame(N2)
head(N2)
Na <- data.frame(Na)
Tsplit <- data.frame(Tsplit)
Tsc <- data.frame(Tsc)
ratioTscTsplit <- data.frame(ratioTscTsplit)
shape1Ne <- data.frame(shape1Ne)
shape2Ne <- data.frame(shape2Ne)
propNtrlNe1 <- data.frame(propNtrlNe1)
propNtrlNe2 <- data.frame(propNtrlNe2)
M1 <- data.frame(M1)
M2 <- data.frame(M2)
shape1M1 <- data.frame(shape1M1)
shape2M1 <- data.frame(shape2M1)
shape1M2 <- data.frame(shape1M2)
shape2M2 <- data.frame(shape2M2)
propNtrlM1 <- data.frame(propNtrlM1)
propNtrlM2 <- data.frame(propNtrlM2)

a1 <- cbind("N1",N1[1,1],N1[3,1],N1[5,1]) #95%
print(a1)
a2 <- cbind("N2",N2[1,1],N2[3,1],N2[5,1]) #95%
print(a2)
a3 <- cbind("Na",Na[1,1],Na[3,1],Na[5,1]) #95%
a4 <- cbind("Tsplit",Tsplit[1,1],Tsplit[3,1],Tsplit[5,1]) #95%
a5 <- cbind("Tsc",Tsc[1,1],Tsc[3,1],Tsc[5,1]) #95%
a5.1 <- cbind("ratioTscTsplit",ratioTscTsplit[1,1],ratioTscTsplit[3,1],ratioTscTsplit[5,1]) #95%
a6 <- cbind("shape1Ne",shape1Ne[1,1],shape1Ne[3,1],shape1Ne[5,1]) #95%
a7 <- cbind("shape2Ne",shape2Ne[1,1],shape2Ne[3,1],shape2Ne[5,1]) #95%
a8 <- cbind("propNtrlNe1",propNtrlNe1[1,1],propNtrlNe1[3,1],propNtrlNe1[5,1]) #95%
a9 <- cbind("propNtrlNe2",propNtrlNe2[1,1],propNtrlNe2[3,1],propNtrlNe2[5,1]) #95%
a10 <- cbind("M1",M1[1,1],M1[3,1],M1[5,1]) #95%
a11 <- cbind("M2",M2[1,1],M2[3,1],M2[5,1]) #95%
a12 <- cbind("shape1M1",shape1M1[1,1],shape1M1[3,1],shape1M1[5,1]) #95%
a13 <- cbind("shape2M1",shape2M1[1,1],shape2M1[3,1],shape2M1[5,1]) #95%
a14 <- cbind("shape1M2",shape1M2[1,1],shape1M2[3,1],shape1M2[5,1]) #95%
a15 <- cbind("shape2M2",shape2M2[1,1],shape2M2[3,1],shape2M2[5,1]) #95%
a16 <- cbind("propNtrlM1",propNtrlM1[1,1],propNtrlM1[3,1],propNtrlM1[5,1]) #95%
a17 <- cbind("propNtrlM2",propNtrlM2[1,1],propNtrlM2[3,1],propNtrlM2[5,1]) #95%
posterior95CI <- rbind(a1,a2,a3,a4,a5,a5.1,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17)
write(posterior95CI, file = outfile95CI ,ncol=18,sep="\t")

