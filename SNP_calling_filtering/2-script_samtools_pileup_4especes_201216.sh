# TL - 201216
#$ -m abe
#$ -q unlimitq
samtools mpileup -f /home/tleroy/work2/ref/haplome_v2.3.fa /home/tleroy/work2/projet_BAN/merged_AOSW.dedup /home/tleroy/work2/projet_BAN/merged_BOSW.dedup /home/tleroy/work2/projet_BAN/merged_COSW.dedup /home/tleroy/work2/projet_BAN/merged_DOSW.dedup > /home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup
