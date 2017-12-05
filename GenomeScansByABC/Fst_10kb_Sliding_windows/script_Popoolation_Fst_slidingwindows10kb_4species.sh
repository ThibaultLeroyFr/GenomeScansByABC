# TL - 130516
#$ -l mem=50G
#$ -l h_vmem=100G
#$ -m abe
# sliding windows 10kb
# 1=sessile (26 haplotypes) 2= pubescent (36 haplotypes) 3= pédonculé(40 haplotypes) 4=tauzin(40 haplotypes)
fst-sliding.pl --input /home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.withoutheader.sync --output /home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.withoutheader.sync.fst10kb --min-count 10 --min-coverage 50 --max-coverage 2000 --min-covered-fraction 0.0001 --window-size 10000 --step-size 10000 --pool-size 26,36,40,40
