# TL - 200117
# -m abe
#$ -q unlimitq

# This script identifies outlier SNPs in the real dataset (those SNPs with an observed Gst value above the 0.999 or 0.9999 quantiles of the null distribution)
rm BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers

# for each SNP in the real dataset
while read line; do
	Heobs=$(echo $line | awk '{print $6}' | bc)
	fstobs=$(echo $line | awk '{print $8}' )
	maxHe=$(echo "0.5" | bc)
	if [ "$fstobs" != "NA" ]; then
		if [ "$Heobs" != "$maxHe" ]; then
			res=$(awk -v var="$Heobs" '$2 > var {print $0}' rob-pet_quantiles_He-Fst_compil_neutral_stats_RecentSC_heteroNe.final | awk -v var2="$Heobs" '$1 <= var2 {print $0}')
		else
			res=$(awk -v var="$Heobs" '$2 >= var {print $0}' rob-pet_quantiles_He-Fst_compil_neutral_stats_RecentSC_heteroNe.final | awk -v var2="$Heobs" '$1 <= var2 {print $0}')
		fi
	else
		echo -n ""
	fi
	# then report only the critical Fst value of res
	quant_5pm=$(echo "$res" | awk '{print $4}' | bc)
	quant_25pm=$(echo "$res" | awk '{print $5}' | bc)
	quant_250pm=$(echo "$res" | awk '{print $6}' | bc)
	quant_750pm=$(echo "$res" | awk '{print $8}' | bc)
	quant_975pm=$(echo "$res" | awk '{print $9}' | bc)
	quant_990pm=$(echo "$res" | awk '{print $10}' | bc)
	quant_995pm=$(echo "$res" | awk '{print $11}' | bc)
	quant_999pm=$(echo "$res" | awk '{print $12}' | bc)
	quant_9999pdm=$(echo "$res" | awk '{print $13}' | bc)
	quant_max=$(echo "$res" | awk '{print $14}' | bc)
	# perform test to identify outliers
	if [ "$fstobs" != "NA" ]; then
		if [[ "$fstobs" == *"e"* ]]; then # remove case where fstobs is very very low (e-5 or e-6)
			echo "neutral999pm	neutral9999pdm	neutralMaxObsNeutral	$fstobs	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
		else
			fstobs2=$(echo "$fstobs" | bc)
			if echo "$fstobs2 $quant_999pm" | awk '{exit $1>$2?0:1}'; then # if Gst > quantile 0.999; do ; else
				if echo "$fstobs2 $quant_9999pdm" | awk '{exit $1>$2?0:1}'; then # if Gst > quantile 0.9999; do ; else
					if echo "$quant_max" | awk '{exit $1>$2?0:1}'; then
						echo "outlier999pm	outlier9999pdm	outlierMaxObsNeutral	$fstobs	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
					else
						echo "outlier999pm	outlier9999pdm	neutralMaxObsNeutral	$fstobs	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
					fi
				else
					echo "outlier999pm	neutral9999pdm	neutralMaxObsNeutral	$fstobs	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
				fi
			else
				echo "neutral999pm	neutral9999pdm	neutralMaxObsNeutral	$fstobs	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
			fi
		fi
	else
		echo "NA	NA	NA	NA	$quant_999pm	$quant_9999pdm	$quant_max	$line" >> BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out.outliers
	fi
done < BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00_biallelic_sites_counts.hefst.out
