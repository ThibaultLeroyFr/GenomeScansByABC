# TL - 050201
#$ -m abe
# This script transforms allele counts in inputs for AB
# define the number of haplotypes (2*nb individuals for diploids)
nbhaplopool1=$(echo "40" | bc)
nbhaplopool2=$(echo "26" | bc)
file=$(echo "BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.50Ksampling")
## LOCAL
LC_NUMERIC=C
LC_COLLATE=C

###initiate locus.ms
echo -e "./msnsam tbs 20 -s tbs -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -ej tbs 1 2 -eN tbs tbs\n3579 27011 59243" > locus.ms

### initiate header bpfile
echo "# Robur Petraea 40X 26X" > bpfile

# rm previous companion files (not required for ABC)
rm $file.summary_stats_polymorphicloci.txt
rm $file.SNPinfo

## for each locus, generate genetic information following the locus.ms format
nlocuspoly=$(echo "0" | bc)
nlocus=$(echo "0" | bc)
while read line; do
	nlocus=$(echo "$nlocus + 1" | bc)
	scaff=$(echo "$line" | awk '{print $1}') # scaff
	pos=$(echo "$line" | awk '{print $2}') # position
	pop1all1=$(echo "$line" | awk '{print $17}' | bc -l) # allele counts robur columns 17 (allele 1)
	pop1all2=$(echo "$line" | awk '{print $18}' | bc -l) # allele counts robur columns 18 (allele 2)
	pop2all1=$(echo "$line" | awk '{print $11}' | bc -l) # allele counts petraea columns 11 (allele 1)
	pop2all2=$(echo "$line" | awk '{print $12}' | bc -l) # allele counts petraea columns 12 (allele 2)
	freqall1pop1=$(echo "scale=4;$pop1all1/($pop1all1+$pop1all2)" | bc)
	freqall1pop2=$(echo "scale=4;$pop2all1/($pop2all1+$pop2all2)" | bc)
	freqall1_2pops=$(echo "scale=4;($pop1all1+$pop2all1)/($pop1all1+$pop1all2+$pop2all1+$pop2all2)" | bc)
	tmpnumberofall1pop1=$(echo "$freqall1pop1*$nbhaplopool1" | bc)
	tmpnumberofall1pop2=$(echo "$freqall1pop2*$nbhaplopool2" | bc)
	numberofall1pop1=$(printf '%.0f\n' $tmpnumberofall1pop1)
	numberofall2pop1=$(echo "$nbhaplopool1 - $numberofall1pop1" | bc)
	numberofall1pop2=$(printf '%.0f\n' $tmpnumberofall1pop2)
	numberofall2pop2=$(echo "$nbhaplopool2 - $numberofall1pop2" | bc)
	freqall1_2pops=$(echo "scale=4;($numberofall1pop1+$numberofall1pop2)/($numberofall1pop1+$numberofall2pop1+$numberofall1pop2+$numberofall2pop2)" | bc)
	if [ "$freqall1_2pops" == "1.0000" ] || [ "$freqall1_2pops" == "0" ]; then 
		echo "EXCLUDEDmonomorphe	$nlocus	$nlocuspoly	$scaff	$pos	$freqall1pop1	$freqall1pop2	$freqall1_2pops	$numberofall1pop1	$numberofall2pop1	$numberofall1pop2	$numberofall2pop2" >> $file.SNPinfo
	else
		nlocuspoly=$(echo "$nlocuspoly + 1" | bc)
		echo "ACCEPTEDpolymorphe	$nlocus	$nlocuspoly	$scaff	$pos	$freqall1pop1	$freqall1pop2	$freqall1_2pops	$numberofall1pop1	$numberofall2pop1	$numberofall1pop2	$numberofall2pop2" >> $file.SNPinfo
		# print 0 for each ref allele, 1 for alt alleles
		echo -e "\n//\t78\t1.58854\t1.58854\t111\t56\t22\t0.795745\t1.02097\t0.574558\t1.49299\t4.90703\t4.90703\t6.22109\nsegsites: 1\npositions:\t0.5" >> locus.ms
		printf "0\n%.0s" $(seq 1 $numberofall1pop1) >> locus.ms
		printf "1\n%.0s" $(seq 1 $numberofall2pop1) >> locus.ms
		printf "0\n%.0s" $(seq 1 $numberofall1pop2) >> locus.ms
		printf "1\n%.0s" $(seq 1 $numberofall2pop2) >> locus.ms
	fi	
done < $file

# initiate spinput & generate spinput.txt
echo -e "\n$nlocuspoly" > spinput.txt
printf "$nbhaplopool1\n$nbhaplopool2\n1\n%.0s" $(seq 1 $nlocuspoly) >> spinput.txt
echo -e "1\nlocus.ms" >> spinput.txt

# generate bpfile
printf '1\t%.0s' $(seq 1 $nlocuspoly) >> bpfile
echo -e "" >> bpfile
printf "$nbhaplopool1\t%.0s" $(seq 1 $nlocuspoly) >> bpfile
echo -e "" >> bpfile
printf "$nbhaplopool2\t%.0s" $(seq 1 $nlocuspoly) >> bpfile
echo -e "" >> bpfile

# summary
freqpoly=$(echo "scale=4;$nlocuspoly/$nlocus" | bc)
echo "$nlocus	$nlocuspoly	$freqpoly" >> $file.summary_stats_polymorphicloci.txt
