# TL - 040117
# -q unlimitq
#$ -m abe
#$ -pe parallel_smp 24
java -Xmx4g -jar /usr/local/bioinfo/src/popoolation2/popoolation2_1201/mpileup2sync.jar --input /home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup --output /home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup.sync --fastq-type sanger --min-qual 20 --threads 24
