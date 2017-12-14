# TL - 230217
# Ce script permet d'analyser les données de densité en outliers chez la paire Sessile-Pédonculé
setwd("/home/thibault/projet_BAN_4espèces-popoolation/4species_2017/sesped_scanABC-based/230217/")
densout=read.table("BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean", header=TRUE)

### chr par chr
setwd("/home/thibault/projet_BAN_4espèces-popoolation/4species_2017/")
### chr 1 test
pdf("Ses-ped_DensityOutliers_Chr_par_Chr_280317.pdf",20,18)
for (k in 1:9){
  densoutchr10kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean.Chr",k,".sort",sep=""), header=FALSE)
  densoutchr2kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin2kb.clean.Chr",k,".sort",sep=""), header=FALSE)
  fst10kbchr=read.table(paste("./sesped_Fst10kb/Chr_par_Chr/COSW.dedup.pileupmerged_AOSW.dedup.pileup.sync.filteredMAF0.05_sw10kb_mincount10_mincfraction0.5_final.fst.sed.pseudoK.Chr0",k,".sort",sep=""), header=FALSE)
  
  plotA <- ggplot() +  geom_line(aes(x=fst10kbchr$V8+5000, y=fst10kbchr$V6, colour=fst10kbchr$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("Fst Q.robur/Q. petraea\n[Sliding windows 10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotB <- ggplot() +  geom_line(aes(x=densoutchr10kb$V26+5000, y=densoutchr10kb$V20, colour=densoutchr10kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotC <- ggplot() +  geom_line(aes(x=densoutchr2kb$V26+5000, y=densoutchr2kb$V20, colour=densoutchr2kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.999)\n[SlidWin2kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  
  grid.arrange(plotA,plotB,plotC, ncol=1)
}

for (k in 10:12){
  densoutchr10kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean.Chr",k,".sort",sep=""), header=FALSE)
  densoutchr2kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin2kb.clean.Chr",k,".sort",sep=""), header=FALSE)
  fst10kbchr=read.table(paste("./sesped_Fst10kb/Chr_par_Chr/COSW.dedup.pileupmerged_AOSW.dedup.pileup.sync.filteredMAF0.05_sw10kb_mincount10_mincfraction0.5_final.fst.sed.pseudoK.Chr",k,".sort",sep=""), header=FALSE)
  
  plotA <- ggplot() +  geom_line(aes(x=fst10kbchr$V8+5000, y=fst10kbchr$V6, colour=fst10kbchr$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("Fst Q.robur/Q. petraea\n[Sliding windows 10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotB <- ggplot() +  geom_line(aes(x=densoutchr10kb$V26+1000, y=densoutchr10kb$V20, colour=densoutchr10kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotC <- ggplot() +  geom_line(aes(x=densoutchr2kb$V26+1000, y=densoutchr2kb$V20, colour=densoutchr2kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.999)\n[SlidWin2kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  
  grid.arrange(plotA,plotB,plotC, ncol=1)
}
dev.off()

### chr par chr sans fenêtres avec moins de 10 SNPs
setwd("/home/thibault/projet_BAN_4espèces-popoolation/4species_2017/")
### chr 1 test
pdf("Ses-ped_DensityOutliers_Chr_par_Chr_280317_sansWinless10SNPs.pdf",20,18)
for (k in 1:9){
  densoutchr10kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean.Chr",k,".sort.SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  densoutchr2kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin2kb.clean.Chr",k,".sort.SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  fst10kbchr=read.table(paste("./sesped_Fst10kb/Chr_par_Chr/COSW.dedup.pileupmerged_AOSW.dedup.pileup.sync.filteredMAF0.05_sw10kb_mincount10_mincfraction0.5_final.fst.sed.pseudoK.Chr0",k,".sort",sep=""), header=FALSE)
  
  plotA <- ggplot() +  geom_line(aes(x=fst10kbchr$V8+5000, y=fst10kbchr$V6, colour=fst10kbchr$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("\nFst Q.robur/Q. petraea\n[Sliding windows 10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotB <- ggplot() +  geom_line(aes(x=densoutchr10kb$V26+5000, y=densoutchr10kb$V20, colour=densoutchr10kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotC <- ggplot() +  geom_line(aes(x=densoutchr2kb$V26+1000, y=densoutchr2kb$V20, colour=densoutchr2kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.9999)\n[SlidWin2kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  
  grid.arrange(plotA,plotB,plotC, ncol=1)
}

for (k in 10:12){
  densoutchr10kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean.Chr",k,".sort.SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  densoutchr2kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin2kb.clean.Chr",k,".sort.SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  fst10kbchr=read.table(paste("./sesped_Fst10kb/Chr_par_Chr/COSW.dedup.pileupmerged_AOSW.dedup.pileup.sync.filteredMAF0.05_sw10kb_mincount10_mincfraction0.5_final.fst.sed.pseudoK.Chr",k,".sort",sep=""), header=FALSE)
  
  plotA <- ggplot() +  geom_line(aes(x=fst10kbchr$V8+5000, y=fst10kbchr$V6, colour=fst10kbchr$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("\nFst Q.robur/Q. petraea\n[Sliding windows 10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotB <- ggplot() +  geom_line(aes(x=densoutchr10kb$V26+5000, y=densoutchr10kb$V20, colour=densoutchr10kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotC <- ggplot() +  geom_line(aes(x=densoutchr2kb$V26+1000, y=densoutchr2kb$V20, colour=densoutchr2kb$V1))  + xlab(paste("position on Chr",k,sep="")) + ylim(0,1) + ylab("proportion of outliers\n(obs. Fst > neutral Fst quantile0.9999)\n[SlidWin2kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  
  grid.arrange(plotA,plotB,plotC, ncol=1)
}
dev.off()
