#TL - 150915 - thibault.leroy@pierroton.inra.fr
#$ -m abe
#$ -q unlimitq

# This scripts computes the proportion of outliers per genomic window
# Outlier were previously detected to have a Gst value above the 99.99% limit of the null envelope.
###########GENERAL INFO###########
cd ~/work2/projet_BAN/4species/Ses-Ped/
slidingwindows=$(echo "10000" | bc) #length of genomic segments to use (10kb in Leroy et al. submitted)
infileSNPinfo=$(echo "BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpositions")  # all SNPs
infileScaffoldSumStat=$(echo "haplome_v2.3_GCscaffold_090216_pourR.txt") #file containing les sumstats per scaffold (lengths, #ACGT, #N, ...)
infileslidingwindowsSumStat=$(echo "haplome_v2.3_GCsliwin10kb_090216_pourR.txt") # file containing sumstat for each windows of each scaffold
outfile=$(echo "BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_biallelic_sites_counts.hefst.out.outliers.withpos.Slidwin10kb") #outprefix
###########SCRIPT################"
# generate file with HZ snp per scaffold
for i in {0..9}; do 
	scaffoldname=$(echo "Sc000000""$i")
	grep "$scaffoldname" $infileSNPinfo > ./sespedscaffoldparscaffold/sesped.outliers.$scaffoldname
done
for i in {10..99}; do 
        scaffoldname=$(echo "Sc00000""$i")
        grep "$scaffoldname" $infileSNPinfo > ./sespedscaffoldparscaffold/sesped.outliers.$scaffoldname
done
for i in {100..999}; do 
        scaffoldname=$(echo "Sc0000""$i")
        grep "$scaffoldname" $infileSNPinfo > ./sespedscaffoldparscaffold/sesped.outliers.$scaffoldname
done
for i in {1000..1408}; do 
        scaffoldname=$(echo "Sc000""$i")
        grep "$scaffoldname" $infileSNPinfo > ./sespedscaffoldparscaffold/sesped.outliers.$scaffoldname
done
# header de l'outfile
echo "scaffold	min_win	max_win	GCrate	Nrate	numberofSNPs	numberofSNPsWithHeSup0.1	numberofSNPsWithHeSup0.2	numberofoutliers999pmAllHe numberofoutlier999pmHeSup0.1	numberofoutlier999pmHeSup0.2	numberofoutliers9999pdmAllHe	numberofoutlier9999pdmHeSup0.1	numberofoutliers9999pdmHeSup0.2	proportionofoutliers999allHe	proportionofoutliers99Sup9He0.1	proportionofoutliers999HeSup0.2	proportionofoutliers999SupHe0.1amongSNPwithHeSup0.1	proportionofoutliers999SupHe0.2amongSNPwithHeSup0.2	proportionofoutliers9999allHe	proportionofoutliers9999HeSup0.1	proportionofoutliers9999HeSup0.2	proportionofoutliers9999SupHe0.1amongSNPwithHeSup0.1	proportionofoutliers9999SupHe0.2amongSNPwithHeSup0.2" > $outfile
# loop per each scaffold (= each file)
for i in ./sespedscaffoldparscaffold/sesped.outliers.*; do
	less $i | head -1 > ./sespedscaffoldparscaffold/tmpheader
	scaffold=$(awk '{print $1}' ./sespedscaffoldparscaffold/tmpheader)
	grep "$scaffold" $infileScaffoldSumStat > ./sespedscaffoldparscaffold/tmpsumstatscaff # find summary statistic of the scaffold
	atgc=$(awk '{print $4}' ./sespedscaffoldparscaffold/tmpsumstatscaff) # scaffold: number of ACGT bases
	n=$(awk '{print $5}' ./sespedscaffoldparscaffold/tmpsumstatscaff) # scaffold: number of N 
	totalscaffoldlength1=$(echo "$atgc + $n" |bc)
	totalscaffoldlength2=$(echo "$totalscaffoldlength1" | bc) # total length of the investigated scaffold
	numberofwindows=$(echo "($totalscaffoldlength2 - $slidingwindows ) / $slidingwindows" | bc) # total number of windows for the investigated scaffold
	#echo "totalscaffoldlength=$totalscaffoldlength numberofwindows=$numberofwindows"
	countermini=$(echo "0" | bc)
	countermini2=$(echo "1" | bc)
	countermax=$(echo "$slidingwindows" | bc)
	# loop de sliding windows
	for j in $(eval echo "{1..$numberofwindows}"); do 
		awk -v threshold="$countermax" '$2 <= threshold' $i | awk -v threshold2="$countermini" '$2 > threshold2' >> tmpcounter
		numberofSNPs=$(less tmpcounter | wc -l)
		numberofSNPsHe01=$(less tmpcounter | awk '$16 >= 0.1 {print $0}' | wc -l)
		numberofSNPsHe02=$(less tmpcounter | awk '$16 >= 0.2 {print $0}' | wc -l)
		numberofoutliers999=$(grep "outlier999pm" tmpcounter | wc -l)
		numberofoutliers999He01=$(grep "outlier999pm" tmpcounter | awk '$16 >= 0.1 {print $0}' | wc -l)
		numberofoutliers999He02=$(grep "outlier999pm" tmpcounter | awk '$16 >= 0.2 {print $0}' | wc -l)
		numberofoutliers9999=$(grep "outlier9999pdm" tmpcounter | wc -l)
		numberofoutliers9999He01=$(grep "outlier9999pdm" tmpcounter | awk '$16 >= 0.1 {print $0}' | wc -l)
		numberofoutliers9999He02=$(grep "outlier9999pdm" tmpcounter | awk '$16 >= 0.2 {print $0}' | wc -l)
		### if no outliers found, report 0
		if [[ -z "$numberofoutliers999" ]]; then
			numberofoutliers999=$(echo "0" | wc -l)
		fi
		if [[ -z "$numberofoutliers999He01" ]]; then
			numberofoutliers999He01=$(echo "0" | wc -l)
		fi
		if [[ -z "$numberofoutliers999He02" ]]; then
			numberofoutliers999He02=$(echo "0" | wc -l)
		fi
		if [[ -z "$numberofoutliers9999" ]]; then
			numberofoutliers9999=$(echo "0" | wc -l)
		fi
		if [[ -z "$numberofoutliers9999He01" ]]; then
			numberofoutliers9999He01=$(echo "0" | wc -l)
		fi
		if [[ -z "$numberofoutliers9999He02" ]]; then
			numberofoutliers9999He02=$(echo "0" | wc -l)
		fi
		rm tmpcounter
		start_res_windows=$(grep "$scaffold	$countermini2	" $infileslidingwindowsSumStat) 
		echo "$start_res_windows" > tmpstartres
		gcrate=$(awk '{if ($6 == "") print "NA"; else print $6}' tmpstartres) 
		nrate=$(awk '{if ($7 == "") print "NA"; else print $7}'  tmpstartres)	
		# check if > $numberofSNPs is >1
		if [ "$numberofSNPs" == "0" ]; then
			numberofSNPs=$(echo "0" | wc -l)
			echo "$scaffold	$countermini	$countermax	$gcrate	$nrate	$numberofSNPs	$numberofSNPsHe01	$numberofSNPsHe02	$numberofoutliers999	$numberofoutliers999He01	$numberofoutliers999He02	$numberofoutliers9999	$numberofoutliers9999He01	$numberofoutliers9999He02	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA" >> $outfile 
		else
			if [ "$numberofSNPsHe02" == "0" ]; then
				if [ "$numberofSNPsHe01" == "0" ]; then
					$numberofSNPsHe01=$(echo "0" | wc -l)
					$numberofSNPsHe02=$(echo "0" | wc -l)
					proportionofoutliers9999=$(echo "$numberofoutliers9999 / $numberofSNPs" | bc -l) 
					proportionofoutliers9999He01=$(echo "$numberofoutliers9999He01 / $numberofSNPs" | bc -l) 
					proportionofoutliers9999He02=$(echo "$numberofoutliers9999He02 / $numberofSNPs" | bc -l)
					proportionofoutliers999=$(echo "$numberofoutliers999 / $numberofSNPs" | bc -l) 
					proportionofoutliers999He01=$(echo "$numberofoutliers999He01 / $numberofSNPs" | bc -l)  
					proportionofoutliers999He02=$(echo "$numberofoutliers999He02 / $numberofSNPs" | bc -l)
					echo "$scaffold	$countermini	$countermax	$gcrate	$nrate	$numberofSNPs	$numberofSNPsHe01	$numberofSNPsHe02	$numberofoutliers999	$numberofoutliers999He01	$numberofoutliers999He02	$numberofoutliers9999	$numberofoutliers9999He01	$numberofoutliers9999He02	$proportionofoutliers999	$proportionofoutliers999He01	$proportionofoutliers999He02	NA	NA	$proportionofoutliers9999	$proportionofoutliers9999He01	$proportionofoutliers9999He02	NA	NA" >> $outfile 
				else
					$numberofSNPsHe02=$(echo "0" | wc -l)
					proportionofoutliers9999=$(echo "$numberofoutliers9999 / $numberofSNPs" | bc -l) 
					proportionofoutliers9999He01=$(echo "$numberofoutliers9999He01 / $numberofSNPs" | bc -l) 
					proportionofoutliers9999He02=$(echo "$numberofoutliers9999He02 / $numberofSNPs" | bc -l)
					proportionofoutliers999=$(echo "$numberofoutliers999 / $numberofSNPs" | bc -l) 
					proportionofoutliers999He01=$(echo "$numberofoutliers999He01 / $numberofSNPs" | bc -l)  
					proportionofoutliers999He02=$(echo "$numberofoutliers999He02 / $numberofSNPs" | bc -l)
					proportionofoutliers9999He01amongSNPhe01=$(echo "$numberofoutliers9999He01 / $numberofSNPsHe01" | bc -l)
					proportionofoutliers999He01amongSNPhe01=$(echo "$numberofoutliers999He01 / $numberofSNPsHe01" | bc -l)
					echo "$scaffold	$countermini	$countermax	$gcrate	$nrate	$numberofSNPs	$numberofSNPsHe01	$numberofSNPsHe02	$numberofoutliers999	$numberofoutliers999He01	$numberofoutliers999He02	$numberofoutliers9999	$numberofoutliers9999He01	$numberofoutliers9999He02	$proportionofoutliers999	$proportionofoutliers999He01	$proportionofoutliers999He02	$proportionofoutliers999He01amongSNPhe01	NA	$proportionofoutliers9999	$proportionofoutliers9999He01	$proportionofoutliers9999He02	$proportionofoutliers9999He01amongSNPhe01	NA" >> $outfile
				fi
			else
				proportionofoutliers9999=$(echo "$numberofoutliers9999 / $numberofSNPs" | bc -l) 
				proportionofoutliers9999He01=$(echo "$numberofoutliers9999He01 / $numberofSNPs" | bc -l) 
				proportionofoutliers9999He02=$(echo "$numberofoutliers9999He02 / $numberofSNPs" | bc -l)
				proportionofoutliers9999He01amongSNPhe01=$(echo "$numberofoutliers9999He01 / $numberofSNPsHe01" | bc -l) 
				proportionofoutliers9999He02amongSNPhe02=$(echo "$numberofoutliers9999He02 / $numberofSNPsHe02" | bc -l)  
				proportionofoutliers999=$(echo "$numberofoutliers999 / $numberofSNPs" | bc -l) 
				proportionofoutliers999He01=$(echo "$numberofoutliers999He01 / $numberofSNPs" | bc -l)  
				proportionofoutliers999He02=$(echo "$numberofoutliers999He02 / $numberofSNPs" | bc -l)
				proportionofoutliers999He01amongSNPhe01=$(echo "$numberofoutliers999He01 / $numberofSNPsHe01" | bc -l) 
				proportionofoutliers999He02amongSNPhe02=$(echo "$numberofoutliers999He02 / $numberofSNPsHe02" | bc -l)
				echo "$scaffold	$countermini	$countermax	$gcrate	$nrate	$numberofSNPs	$numberofSNPsHe01	$numberofSNPsHe02	$numberofoutliers999	$numberofoutliers999He01	$numberofoutliers999He02	$numberofoutliers9999	$numberofoutliers9999He01	$numberofoutliers9999He02	$proportionofoutliers999	$proportionofoutliers999He01	$proportionofoutliers999He02	$proportionofoutliers999He01amongSNPhe01	$proportionofoutliers999He02amongSNPhe02	$proportionofoutliers9999	$proportionofoutliers9999He01	$proportionofoutliers9999He02	$proportionofoutliers9999He01amongSNPhe01	$proportionofoutliers9999He02amongSNPhe02" >> $outfile 
			fi
		fi
		countermini=$((countermini+$slidingwindows))
		countermini2=$((countermini2+$slidingwindows))
		countermax=$((countermax+$slidingwindows))
	done
done
