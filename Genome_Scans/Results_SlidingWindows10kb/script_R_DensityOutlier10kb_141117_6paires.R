# TL - 230217
# Ce script permet d'analyser les données de densité en outliers chez la paire Sessile-Pédonculé
setwd("/home/thibault/projet_BAN_4espèces-popoolation/4species_2017/")
#densout=read.table("BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean", header=TRUE)

### chr par chr
#setwd("/home/thibault/projet_BAN_4espèces-popoolation/4species_2017/")
### chr 1 test
pdf("6pairs_densOutlier_10kb_Chr_par_Chr_141217.pdf",20,18)
for (k in 1:12){
  sespeddensoutchr10kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb.clean.Chr",k,".sort.SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  pyrpetdensoutchr10kb=read.table(paste("./pyrpet_scanABC-based/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.pyr-pet.Slidwin10kb.Chr",k,".SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  pubpetdensoutchr10kb=read.table(paste("./pubpet_scanABC-based/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.pub-pet.Slidwin10kb.Chr",k,".SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  robpubdensoutchr10kb=read.table(paste("./robpub_scanABC-based/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.rob-pub.Slidwin10kb.Chr",k,".SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  robpyrdensoutchr10kb=read.table(paste("./robpyr_scanABC-based/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.rob-pyr.Slidwin10kb.Chr",k,".SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  pubpyrdensoutchr10kb=read.table(paste("./pubpyr_scanABC-based/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.pub-pyr.Slidwin10kb.Chr",k,".SlidWinwithatleast10SNPs",sep=""), header=FALSE)
  
  #  densoutchr2kb=read.table(paste("./sesped_scanABC-based/280317/Chr_par_Chr/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin2kb.clean.Chr",k,".sort",sep=""), header=FALSE)
  #  fst10kbchr=read.table(paste("./sesped_Fst10kb/Chr_par_Chr/COSW.dedup.pileupmerged_AOSW.dedup.pileup.sync.filteredMAF0.05_sw10kb_mincount10_mincfraction0.5_final.fst.sed.pseudoK.Chr0",k,".sort",sep=""), header=FALSE)
  
  # first colors
  #  col = rep(c("slateblue4","steelblue3"),6)
  #  col2 =rep(c("darkred","orangered3"), 6)
  #  col3 =rep(c("olivedrab","olivedrab3"), 6)
  #  col4 = rep(c("violetred4","violetred3"),6)
  #  col5 =rep(c("chocolate4","chocolate3"), 6)
  #  col6 =rep(c("yellow4","yellow3"), 6)
  
  plotA <- ggplot() +  geom_line(aes(x=sespeddensoutchr10kb$V26, y=sespeddensoutchr10kb$V22), colour="slateblue4")  + xlab(paste("Q.robur-Q.petraea - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotB <- ggplot() +  geom_line(aes(x=pyrpetdensoutchr10kb$V26, y=pyrpetdensoutchr10kb$V22), colour="darkred")  + xlab(paste("Q.pyrenaica-Q.petraea - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotC <- ggplot() +  geom_line(aes(x=pubpetdensoutchr10kb$V26, y=pubpetdensoutchr10kb$V22), colour="olivedrab4")  + xlab(paste("Q.pubescens-Q.petraea - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotD <- ggplot() +  geom_line(aes(x=robpubdensoutchr10kb$V26, y=robpubdensoutchr10kb$V22), colour="violetred2")  + xlab(paste("Q.robur-Q.pubescens - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotE <- ggplot() +  geom_line(aes(x=robpyrdensoutchr10kb$V26, y=robpyrdensoutchr10kb$V22), colour="chocolate4")  + xlab(paste("Q.robur-Q.pyrenaica - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  plotF <- ggplot() +  geom_line(aes(x=pubpyrdensoutchr10kb$V26, y=pubpyrdensoutchr10kb$V22), colour="goldenrod1")  + xlab(paste("Q.pubescens-Q.pyrenaica - position on Chr",k,sep="")) + ylim(0,1) + ylab("prop. of outliers\n(Gst > quantile0.9999)\n[SlidWin10kb]")+ theme(legend.position="none")+
    theme(axis.line = element_line(colour = 'black', size = 1.25), axis.ticks = element_line(colour = 'black', size = 1.25), 
          axis.text.x = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="black",size=12,angle=0,hjust=.5,vjust=.5,face="plain"),  
          axis.title.x = element_text(colour="black",size=14,angle=0,hjust=.5,vjust=.2,face="italic"),
          axis.title.y = element_text(colour="black",size=14,angle=90,hjust=.5,vjust=.5,face="italic"))
  
  
  grid.arrange(plotA,plotB,plotC,plotD,plotE,plotF, ncol=1)
}
dev.off()
