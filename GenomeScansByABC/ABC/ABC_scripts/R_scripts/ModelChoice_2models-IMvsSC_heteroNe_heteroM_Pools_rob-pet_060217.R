library(nnet)

# load sources
source("cv4abc.R")

# dir real data
setwd("/home/tleroy/work2/ABC/Pool/rob-pet/4species")

ss=4:20 # sumstats: last 17 columns
# target (sumstats for the real dataset)
target=read.table("target_rob-pet_pool.txt",skip=2,h=F)
target=as.numeric(target)

# real dataset - sumstat checking
print("### target###")
print(summary(target))
print(nrow(target))
print(ncol(target))


# load sumstats for all simulated simulations
M1heteroNheteroM=NULL
M2heteroNheteroM=NULL

print("### simulations ###")
for(i in 1:250){
  M1heteroNheteroM=rbind(M1heteroNheteroM, matrix(scan(paste("rob-pet_island_Nhetero_Mhetero_v1_",i,"/ABCstat.txt",sep=""), skip=2), byrow=T, ncol=20)[,ss])
  M2heteroNheteroM=rbind(M2heteroNheteroM, matrix(scan(paste("rob-pet_2ndarycont_Nhetero_Mhetero_v1_",i,"/ABCstat.txt",sep=""), skip=2), byrow=T, ncol=20)[,ss])
}

# replace NA (by means)
for(i in 1:ncol(M1heteroNheteroM)){
  M1heteroNheteroM[which(M1heteroNheteroM[,i]=="NaN"),i]=mean(M1heteroNheteroM[,i], na.rm=T)
  M2heteroNheteroM[which(M2heteroNheteroM[,i]=="NaN"),i]=mean(M2heteroNheteroM[,i], na.rm=T)
}

# perform several ABC by replicating the same target
obs=matrix(rep(target[ss],20), byrow=T, nrow=20)
# generate a vector of models
x=c(rep(1:2, each=nrow(M1heteroNheteroM)))

#perform ABC 
# tol = 1000 best simulations / total number of simulations (2*500*2000) = 1000/2000000 = 0.0005
res=model_selection_abc_nnet(target=obs, x=x, sumstat=rbind(M1heteroNheteroM,M2heteroNheteroM), tol=1000/(2*nrow(M1heteroNheteroM)), noweight=F, rejmethod=F, nb.nnet=20, size.nnet=8, output="ModelChoice_Pool_rob-pet_IMvsSC_HeteroNeHeteroNm_Pool_020317_17stats")
