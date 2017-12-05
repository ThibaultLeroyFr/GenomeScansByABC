# TL - 04/01/16 - thibault.leroy@pierroton.inra.fr
# pipeline mapping using bowtie2, picards & samtools
### qsub parameters
# par default job = 48h mais sinon -l s_cpu=120:00:00
#$ -l mem_free=30G
#$ -pe multithread 1
##################### TO BE EDITED ###############################
cdpwd=$(echo "/home/genoak/Thibault/projet_BAN")
ref=$(echo "/home/genoak/Thibault/ref/haplome_v2.3") # set the path to your reference # bowtie2-build ref needed!
racine=$(echo "/home/genoak/Thibault/projet_BAN/merged_C0SW") # set the racine
racine1=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_1_X_C1G53ACXX.IND2) # set the racine
racine2=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_1_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine3=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_2_X_C0URPACXX.IND9) # set the racine
racine4=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_2_X_C0URPACXX.IND9) # set the racine for all the outputs
racine5=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_2_X_D1DENACXX.IND2) # set the racine
racine6=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_2_X_D1DENACXX.IND2) # set the racine for all the outputs
racine7=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_2_X_C1G53ACXX.IND2) # set the racine
racine8=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_2_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine9=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_3_X_C1G53ACXX.IND2) # set the racine
racine10=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_3_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine11=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_4_X_C19M1ACXX.IND9) # set the racine
racine12=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_4_X_C19M1ACXX.IND9) # set the racine for all the outputs
racine13=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_4_X_C1G53ACXX.IND2) # set the racine
racine14=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_4_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine15=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_5_X_C1G53ACXX.IND2) # set the racine
racine16=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_5_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine17=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_6_X_C1G53ACXX.IND2) # set the racine
racine18=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_6_X_C1G53ACXX.IND2) # set the racine for all the outputs
racine19=$(echo /home/genoak/diskbiogeco/BAN/BAN_COSW_7_X_C1G53ACXX.IND2) # set the racine
racine20=$(echo /home/genoak/Thibault/projet_BAN/BAN_COSW_7_X_C1G53ACXX.IND2) # set the racine for all the outputs
#racine21=$(echo /home/genoak/diskbiogeco/BAN/BAN_AOSW_8_X_C197CACXX.IND7) # set the racine
#racine22=$(echo /home/genoak/Thibault/projet_BAN/BAN_AOSW_8_X_C197CACXX.IND7) # set the racine for all the outputs


############# NO CHANGES EXPECTED BELOW ##########################
# pair_end file name edition
change1=$(echo "$racine1" | sed 's/_X_/_1_/g')
change2=$(echo "$racine1" | sed 's/_X_/_2_/g')
change3=$(echo "$racine3" | sed 's/_X_/_1_/g')
change4=$(echo "$racine3" | sed 's/_X_/_2_/g')
change5=$(echo "$racine5" | sed 's/_X_/_1_/g')
change6=$(echo "$racine5" | sed 's/_X_/_2_/g')
change7=$(echo "$racine7" | sed 's/_X_/_1_/g')
change8=$(echo "$racine7" | sed 's/_X_/_2_/g')
change9=$(echo "$racine9" | sed 's/_X_/_1_/g')
change10=$(echo "$racine9" | sed 's/_X_/_2_/g')
change11=$(echo "$racine11" | sed 's/_X_/_1_/g')
change12=$(echo "$racine11" | sed 's/_X_/_2_/g')
change13=$(echo "$racine13" | sed 's/_X_/_1_/g')
change14=$(echo "$racine13" | sed 's/_X_/_2_/g')
change15=$(echo "$racine15" | sed 's/_X_/_1_/g')
change16=$(echo "$racine15" | sed 's/_X_/_2_/g')
change17=$(echo "$racine17" | sed 's/_X_/_1_/g')
change18=$(echo "$racine17" | sed 's/_X_/_2_/g')
change19=$(echo "$racine19" | sed 's/_X_/_1_/g')
change20=$(echo "$racine19" | sed 's/_X_/_2_/g')
pair_end1=$(echo "$change1""_clean.fastq.gz")
pair_end2=$(echo "$change2""_clean.fastq.gz")
pair_end3=$(echo "$change3""_clean.fastq.gz")
pair_end4=$(echo "$change4""_clean.fastq.gz")
pair_end5=$(echo "$change5""_clean.fastq.gz")
pair_end6=$(echo "$change6""_clean.fastq.gz")
pair_end7=$(echo "$change7""_clean.fastq.gz")
pair_end8=$(echo "$change8""_clean.fastq.gz")
pair_end9=$(echo "$change9""_clean.fastq.gz")
pair_end10=$(echo "$change10""_clean.fastq.gz")
pair_end11=$(echo "$change11""_clean.fastq.gz")
pair_end12=$(echo "$change12""_clean.fastq.gz")
pair_end13=$(echo "$change13""_clean.fastq.gz")
pair_end14=$(echo "$change14""_clean.fastq.gz")
pair_end15=$(echo "$change15""_clean.fastq.gz")
pair_end16=$(echo "$change16""_clean.fastq.gz")
pair_end17=$(echo "$change17""_clean.fastq.gz")
pair_end18=$(echo "$change18""_clean.fastq.gz")
pair_end19=$(echo "$change19""_clean.fastq.gz")
pair_end20=$(echo "$change20""_clean.fastq.gz")

mail -s "saruman : pipeline - step 1: mapping" "thibault.leroy@pierroton.inra.fr"
# bowtie2 analysis, outputs bam files
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end1 -2 $pair_end2 -t --un-gz $racine2.v2haplo | samtools view -Shb /dev/stdin > $racine2.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end3 -2 $pair_end4 -t --un-gz $racine4.v2haplo | samtools view -Shb /dev/stdin > $racine4.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end5 -2 $pair_end6 -t --un-gz $racine6.v2haplo | samtools view -Shb /dev/stdin > $racine6.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end7 -2 $pair_end8 -t --un-gz $racine8.v2haplo | samtools view -Shb /dev/stdin > $racine8.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end9 -2 $pair_end10 -t --un-gz $racine10.v2haplo | samtools view -Shb /dev/stdin > $racine10.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end11 -2 $pair_end12 -t --un-gz $racine12.v2haplo | samtools view -Shb /dev/stdin > $racine12.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end13 -2 $pair_end14 -t --un-gz $racine14.v2haplo | samtools view -Shb /dev/stdin > $racine14.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end15 -2 $pair_end16 -t --un-gz $racine16.v2haplo | samtools view -Shb /dev/stdin > $racine16.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end17 -2 $pair_end18 -t --un-gz $racine18.v2haplo | samtools view -Shb /dev/stdin > $racine18.v2haplo.bam
bowtie2 -p12 -k1 -q --sensitive -x $ref -1 $pair_end19 -2 $pair_end20 -t --un-gz $racine20.v2haplo | samtools view -Shb /dev/stdin > $racine20.v2haplo.bam


# picard sort
#mkdir /home/genoak/Thibault/projet_BAN/tmpSort2
sorting=$(echo "/share/apps/picard-tools-1.106/SortSam.jar")
java -Xmx9g -jar $sorting INPUT= $racine2.v2haplo.bam OUTPUT=$racine2.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine4.v2haplo.bam OUTPUT=$racine4.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine6.v2haplo.bam OUTPUT=$racine6.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine8.v2haplo.bam OUTPUT=$racine8.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine10.v2haplo.bam OUTPUT=$racine10.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine12.v2haplo.bam OUTPUT=$racine12.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine14.v2haplo.bam OUTPUT=$racine14.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine16.v2haplo.bam OUTPUT=$racine16.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine18.v2haplo.bam OUTPUT=$racine18.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate
java -Xmx9g -jar $sorting INPUT= $racine20.v2haplo.bam OUTPUT=$racine20.v2haplo.bam.pisorted TMP_DIR=/home/genoak/Thibault/projet_BAN/tmpSort2 SORT_ORDER=coordinate

#mail -s "saruman: pipeline - step 2: picard dedup starts" "thibault.leroy@pierroton.inra.fr"
#rm $cdpwd*.v2haplo.bam
#rm -r /home/genoak/Thibault/projet_BAN/tmpSort
# picard MarkDuplicates
dedup=$(echo "/share/apps/picard-tools-1.106/MarkDuplicates.jar")
mkdir /home/genoak/Thibault/projet_BAN/tmp_dedup2
java -Xmx4g -jar $dedup INPUT=$racine2.v2haplo.bam.pisorted OUTPUT=$racine2.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine2.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine4.v2haplo.bam.pisorted OUTPUT=$racine4.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine4.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine6.v2haplo.bam.pisorted OUTPUT=$racine6.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine6.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine8.v2haplo.bam.pisorted OUTPUT=$racine8.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine8.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine10.v2haplo.bam.pisorted OUTPUT=$racine10.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine10.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine12.v2haplo.bam.pisorted OUTPUT=$racine12.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine12.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine14.v2haplo.bam.pisorted OUTPUT=$racine14.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine14.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine16.v2haplo.bam.pisorted OUTPUT=$racine16.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine16.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine18.v2haplo.bam.pisorted OUTPUT=$racine18.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine18.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true
java -Xmx4g -jar $dedup INPUT=$racine20.v2haplo.bam.pisorted OUTPUT=$racine20.v2haplo.bam.pisorted.dedup TMP_DIR=/home/genoak/Thibault/projet_BAN/tmp_dedup2 METRICS_FILE=$racine20.v2haplo.bam.pisorted.dedup.metrix.txt VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 REMOVE_DUPLICATES=true

rm $cdpwd.v2haplo.bam.pisorted
rm -r /home/genoak/Thibault/projet_BAN/tmp_dedup
# samtools merge
samtools merge $racine.dedup $racine2.v2haplo.bam.pisorted.dedup $racine4.v2haplo.bam.pisorted.dedup $racine6.v2haplo.bam.pisorted.dedup $racine8.v2haplo.bam.pisorted.dedup $racine10.v2haplo.bam.pisorted.dedup $racine12.v2haplo.bam.pisorted.dedup $racine14.v2haplo.bam.pisorted.dedup $racine16.v2haplo.bam.pisorted.dedup $racine18.v2haplo.bam.pisorted.dedup $racine20.v2haplo.bam.pisorted.dedup
#mail -s "saruman: AOSW pipeline - step 2: dedup + merging is finished" "thibault.leroy@pierroton.inra.fr"
# samtools mpileup
#pair_end1=$(echo "$change1""_clean.fastq.gz")
#pair_end2=$(echo "$change2""_clean.fastq.gz")
#samtools mpileup -f $ref.fa $racine.dedup > $racine.dedup.pileup
