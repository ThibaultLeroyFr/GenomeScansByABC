# TL - 09/01/17
#$ -m abe
#$ -q unlimitq
echo "$(tput setaf 4)
############Pool-Seq Allele Count v0.1 Thibault Leroy - thibault.leroy@pierroton.inra.fr ############
$(tput setaf 1)This script extracts allele counts per locus and per population, excluded sites with a MAF lower than a cutoff
beta-testing  $(tput sgr 0)" 

### CHANGE TO YOUR PATH###
pwd_inputfile=$(echo "/home/tleroy/work2/projet_BAN/4species/BAN_4especes_PipelineBowtie2.pileup.sync.freqSNP_rc_00")
tmp00=$(echo "/home/tleroy/work2/projet_BAN/4species/tmp00")
#number_of_populations=$(echo "8") # un jour je le ferai...
cutoffMAF=$(echo "0.02") # MAF used for SNPs in the whole dataset

## step 1: basic transformations ####
#Extract only biallelic sites
pwd_biallelic_sites=$(echo "$pwd_inputfile""_biallelic_sites")
awk '$4== "2" {print $0}' $pwd_inputfile > $pwd_biallelic_sites

#extract major and minor alleles per locus and per pop + replace "/" by "	"
pwd_biallelic_sites_extended=$(echo "$pwd_biallelic_sites""_extended")
rm $pwd_biallelic_sites_extended
while read line; do echo "$line" > $tmp00; major=$(awk '{print $8}' $tmp00); transfomajor=$(echo "$major" | sed 's/A/A	/g' | sed 's/C/C	/g' | sed 's/G/G	/g' | sed 's/T/T	/g' | sed 's/N/N	/g');  minor=$(awk '{print $9}' $tmp00); transfominor=$(echo "$minor" | sed 's/A/A	/g' | sed 's/C/C	/g' | sed 's/G/G	/g' | sed 's/T/T	/g' | sed 's/N/N	/g');  before=$(echo "$major	$minor"); after=$(echo "$major	$transfomajor$minor	$transfominor"); printable=$(awk '{print $0}' $tmp00 | sed "s/$before/$after/g" | sed 's;/;	;g'); echo "$printable" >> $pwd_biallelic_sites_extended; done < $pwd_biallelic_sites
# step 3: main loops ####
# count reference alleles - attention le nombre de colomnes dépend du nombre de populations, ici uniquement pour 8 pops.
pwd_biallelic_sites_controlbugs=$(echo "$pwd_biallelic_sites""_controlbugs") # contrôle des bugs du script: verif des 8 loops
pwd_biallelic_sites_counts_infosites=$(echo "$pwd_biallelic_sites""_infosites") # info sites générale
pwd_biallelic_sites_counts_infotest=$(echo "$pwd_biallelic_sites""_infotest") # contrôle des bugs du script: verif test fin du script (assez redondant avec infosites, à désactiver par l'utilisateur)
pwd_biallelic_sites_counts=$(echo "$pwd_biallelic_sites""_counts") # sortie standard sous la forme count_ref count_alt totalref+alt
pwd_biallelic_sites_counts_excludedMAF=$(echo "$pwd_biallelic_sites""_counts_excludedMAF") # sortie standard sous la forme count_ref count_alt totalref+alt
pwd_biallelic_sites_counts_excludedNA=$(echo "$pwd_biallelic_sites""_counts_excludedNA") # sortie standard sous la forme count_ref count_alt totalref+alt
pwd_biallelic_sites_counts2n_excludedNA=$(echo "$pwd_biallelic_sites""_counts2n_excludedNA") #une ligne pour l'allele ref (avec count_ref & totalref+alt), une ligne pour l'allele alt (avec count_alt & totalref+alt) - ça sera probablement plus simple pour faire des analyses sous bayenv par la suite
rm $pwd_biallelic_sites_controlbugs $pwd_biallelic_sites_counts $pwd_biallelic_sites_counts2n $pwd_biallelic_sites_counts_excludedMAF $pwd_biallelic_sites_counts2n_excludedMAF $pwd_biallelic_sites_counts_infosites $pwd_biallelic_sites_counts_infotest
echo "scaffold	position	allref	allcount	majorall	minorall	sumdeletions	SNPtype	MostFreqAllPerPop	SecondMostFreqAllPerPop	refcount_pop1	altcount_pop1	refaltcount_pop1	refcount_pop2	altcount_pop2	refaltcount_pop2	refcount_pop3	altcount_pop3	refaltcount_pop3	refcount_pop4	altcount_pop4	refaltcount_pop4" > $pwd_biallelic_sites_counts	
while read line; do
	echo "$line" > $tmp00
	ref=$(awk '{print $3}' $tmp00)
	position=$(awk '{print $1"	"$2"	"$3"	"$4"	"$5"	"$6"	"$7"	"$8"	"$9"	"$14}' $tmp00)
	expectedmajor=$(awk '{print $5}' $tmp00)
	expectedminor=$(awk '{print $6}' $tmp00)
	majorall_pop1=$(awk '{print $10}' $tmp00)
	majorall_pop2=$(awk '{print $11}' $tmp00)
	majorall_pop3=$(awk '{print $12}' $tmp00)
	majorall_pop4=$(awk '{print $13}' $tmp00)
	minorall_pop1=$(awk '{print $15}' $tmp00) # décalage d'une colomne pour passer le $minor voir dans le fichier $pwd_biallelic_sites_extended
	minorall_pop2=$(awk '{print $16}' $tmp00)
	minorall_pop3=$(awk '{print $17}' $tmp00)
	minorall_pop4=$(awk '{print $18}' $tmp00)
	#echo "$ref	$expectedminor	$expectedmajor	$majorall_pop1	$minorall_pop1	$majorall_pop2	$minorpop2 $majorall_pop3... $position"
	count_ref_pop1=$(echo "")
	count_alt_pop1=$(echo "")
	count_ref_alt_pop1=$(echo "")
	count_ref_pop2=$(echo "")
	count_alt_pop2=$(echo "")
	count_ref_alt_pop2=$(echo "")
	count_ref_pop3=$(echo "")
	count_alt_pop3=$(echo "")
	count_ref_alt_pop3=$(echo "")
	count_ref_pop4=$(echo "")
	count_alt_pop4=$(echo "")
	count_ref_alt_pop4=$(echo "")
	# loop pop1
	if [ "$minorall_pop1" == "$expectedminor" ] || [ "$minorall_pop1" == "$expectedmajor" ] || [ "$minorall_pop1" == "N" ]; then
		if [ "$ref" == "$majorall_pop1" ]; then
			count_ref_pop1=$(awk '{print $19}' $tmp00)
			count_alt_pop1=$(awk '{print $27}' $tmp00)
			count_ref_alt_pop1=$(echo "$count_ref_pop1 + $count_alt_pop1" | bc)
		elif [ "$ref" == "$minorall_pop1" ]; then
			count_ref_pop1=$(awk '{print $27}' $tmp00)
			count_alt_pop1=$(awk '{print $19}' $tmp00)
			count_ref_alt_pop1=$(echo "$count_ref_pop1 + $count_alt_pop1" | bc)
		elif [ "$majorall_pop1" == "$minorall_pop1" ]; then
			count_ref_pop1=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_alt_pop1=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_ref_alt_pop1=$(echo "NA") 
			echo "cas 2: majorall_pop1 == minorall_pop1 pour $majorall_pop1 == $minorall_pop1 à la position $position" >> $pwd_biallelic_sites_controlbugs
		elif [ "$minorall_pop1" == "N" ]; then
			echo "cas 3: minorall_pop1 == N où $majorall_pop1 != $ref à la position $position" >> $pwd_biallelic_sites_controlbugs
			if [ "$ref" == "$majorall_pop1" ]; then
				count_ref_pop1=$(awk '{print $19}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop1=$(awk '{print $27}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop1=$(echo "$count_ref_pop1 + $count_alt_pop1" | bc)
			else
				count_ref_pop1=$(awk '{print $27}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop1=$(awk '{print $19}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop1=$(echo "$count_ref_pop1 + $count_alt_pop1" | bc)
			fi
		else
			count_ref_pop1=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_alt_pop1=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_ref_alt_pop1=$(echo "NA")
			echo "autre cas à analyser: majorall_pop1=$majorall_pop1 minorall_pop1=$minorall_pop1 ref=$ref position=$position" >> $pwd_biallelic_sites_controlbugs
		fi
	else # 3eme allele retenu à ce locus alors que le site est attendu biallelic, ça veut probablement suggérer un locus monomorphe pour le major et une erreur de séquençage retenue. Néanmoins dans le doute je ne conserve pas ces sites
		count_ref_pop1=$(echo "NA") 
		count_alt_pop1=$(echo "NA")
		count_ref_alt_pop1=$(echo "NA")
		echo "cas 1: minorall_pop1 == $minorall_pop1 != $expectedmajor ou $expectedminor à la position $position" >> $pwd_biallelic_sites_controlbugs
	fi
	# loop pop2
	if [ "$minorall_pop2" == "$expectedminor" ] || [ "$minorall_pop2" == "$expectedmajor" ] || [ "$minorall_pop2" == "N" ]; then
		if [ "$ref" == "$majorall_pop2" ]; then
			count_ref_pop2=$(awk '{print $21}' $tmp00)
			count_alt_pop2=$(awk '{print $29}' $tmp00)
			count_ref_alt_pop2=$(echo "$count_ref_pop2 + $count_alt_pop2" | bc)
		elif [ "$ref" == "$minorall_pop2" ]; then
			count_ref_pop2=$(awk '{print $29}' $tmp00)
			count_alt_pop2=$(awk '{print $21}' $tmp00)
			count_ref_alt_pop2=$(echo "$count_ref_pop2 + $count_alt_pop2" | bc)
		elif [ "$majorall_pop2" == "$minorall_pop2" ]; then
			count_ref_pop2=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_alt_pop2=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_ref_alt_pop2=$(echo "NA") 
			echo "cas 2: majorall_pop2 == minorall_pop2 pour $majorall_pop2 == $minorall_pop2 à la position $position" >> $pwd_biallelic_sites_controlbugs
		elif [ "$minorall_pop2" == "N" ]; then
			echo "cas 3: minorall_pop1 == N où $majorall_pop2 != $ref à la position $position" >> $pwd_biallelic_sites_controlbugs
			if [ "$ref" == "$majorall_pop2" ]; then
				count_ref_pop2=$(awk '{print $21}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop2=$(awk '{print $29}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop2=$(echo "$count_ref_pop2 + $count_alt_pop2" | bc)
			else
				count_ref_pop2=$(awk '{print $29}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop2=$(awk '{print $21}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop2=$(echo "$count_ref_pop2 + $count_alt_pop2" | bc)
			fi
		else
			count_ref_pop2=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_alt_pop2=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_ref_alt_pop2=$(echo "NA")
			echo "autre cas à analyser: majorall_pop2=$majorall_pop2 minorall_pop2=$minorall_pop2 ref=$ref position=$position" >> $pwd_biallelic_sites_controlbugs
		fi
	else # 3eme allele retenu à ce locus alors que le site est attendu biallelic, ça veut probablement suggérer un locus monomorphe pour le major et une erreur de séquençage retenue. Néanmoins dans le doute je ne conserve pas ces sites
		count_ref_pop2=$(echo "NA") 
		count_alt_pop2=$(echo "NA")
		count_ref_alt_pop2=$(echo "NA")
		echo "cas 1: minorall_pop2 == $minorall_pop2 != $expectedmajor ou $expectedminor à la position $position" >> $pwd_biallelic_sites_controlbugs
	fi
	# loop pop3
	if [ "$minorall_pop3" == "$expectedminor" ] || [ "$minorall_pop3" == "$expectedmajor" ] || [ "$minorall_pop3" == "N" ]; then
		if [ "$ref" == "$majorall_pop3" ]; then
			count_ref_pop3=$(awk '{print $23}' $tmp00)
			count_alt_pop3=$(awk '{print $31}' $tmp00)
			count_ref_alt_pop3=$(echo "$count_ref_pop3 + $count_alt_pop3" | bc)
		elif [ "$ref" == "$minorall_pop3" ]; then
			count_ref_pop3=$(awk '{print $31}' $tmp00)
			count_alt_pop3=$(awk '{print $23}' $tmp00)
			count_ref_alt_pop3=$(echo "$count_ref_pop3 + $count_alt_pop3" | bc)
		elif [ "$majorall_pop3" == "$minorall_pop3" ]; then
			count_ref_pop3=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_alt_pop3=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_ref_alt_pop3=$(echo "NA") 
			echo "cas 2: majorall_pop3 == minorall_pop3 pour $majorall_pop3 == $minorall_pop3 à la position $position" >> $pwd_biallelic_sites_controlbugs
		elif [ "$minorall_pop3" == "N" ]; then
			echo "cas 3: minorall_pop1 == N où $majorall_pop3 != $ref à la position $position" >> $pwd_biallelic_sites_controlbugs
			if [ "$ref" == "$majorall_pop3" ]; then
				count_ref_pop3=$(awk '{print $23}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop3=$(awk '{print $31}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop3=$(echo "$count_ref_pop3 + $count_alt_pop3" | bc)
			else
				count_ref_pop3=$(awk '{print $31}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop3=$(awk '{print $23}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop3=$(echo "$count_ref_pop3 + $count_alt_pop3" | bc)
			fi
		else
			count_ref_pop3=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_alt_pop3=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_ref_alt_pop3=$(echo "NA")
			echo "autre cas à analyser: majorall_pop3=$majorall_pop3 minorall_pop3=$minorall_pop3 ref=$ref position=$position" >> $pwd_biallelic_sites_controlbugs
		fi
	else # 3eme allele retenu à ce locus alors que le site est attendu biallelic, ça veut probablement suggérer un locus monomorphe pour le major et une erreur de séquençage retenue. Néanmoins dans le doute je ne conserve pas ces sites
		count_ref_pop3=$(echo "NA") 
		count_alt_pop3=$(echo "NA")
		count_ref_alt_pop3=$(echo "NA")
		echo "cas 1: minorall_pop3 == $minorall_pop3 != $expectedmajor ou $expectedminor à la position $position" >> $pwd_biallelic_sites_controlbugs
	fi
	# loop pop4
	if [ "$minorall_pop4" == "$expectedminor" ] || [ "$minorall_pop4" == "$expectedmajor" ] || [ "$minorall_pop4" == "N" ]; then
		if [ "$ref" == "$majorall_pop4" ]; then
			count_ref_pop4=$(awk '{print $25}' $tmp00)
			count_alt_pop4=$(awk '{print $33}' $tmp00)
			count_ref_alt_pop4=$(echo "$count_ref_pop4 + $count_alt_pop4" | bc)
		elif [ "$ref" == "$minorall_pop4" ]; then
			count_ref_pop4=$(awk '{print $33}' $tmp00)
			count_alt_pop4=$(awk '{print $25}' $tmp00)
			count_ref_alt_pop4=$(echo "$count_ref_pop4 + $count_alt_pop4" | bc)
		elif [ "$majorall_pop4" == "$minorall_pop4" ]; then
			count_ref_pop4=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_alt_pop4=$(echo "NA") # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
			count_ref_alt_pop4=$(echo "NA") 
			echo "cas 2: majorall_pop4 == minorall_pop4 pour $majorall_pop4 == $minorall_pop4 à la position $position" >> $pwd_biallelic_sites_controlbugs
		elif [ "$minorall_pop4" == "N" ]; then
			echo "cas 3: minorall_pop1 == N où $majorall_pop4 != $ref à la position $position" >> $pwd_biallelic_sites_controlbugs
			if [ "$ref" == "$majorall_pop4" ]; then
				count_ref_pop4=$(awk '{print $25}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop4=$(awk '{print $33}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop4=$(echo "$count_ref_pop4 + $count_alt_pop4" | bc)
			else
				count_ref_pop4=$(awk '{print $33}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_alt_pop4=$(awk '{print $25}' $tmp00) # éliminer les cas "N" et "N" pour major et minor (faible couverture?)
				count_ref_alt_pop4=$(echo "$count_ref_pop4 + $count_alt_pop4" | bc)
			fi
		else
			count_ref_pop4=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_alt_pop4=$(echo "NA") # cas où l'allèle de référence ne serait ni le major ni le minor, devrait être très très très rare
			count_ref_alt_pop4=$(echo "NA")
			echo "autre cas à analyser: majorall_pop4=$majorall_pop4 minorall_pop4=$minorall_pop4 ref=$ref position=$position" >> $pwd_biallelic_sites_controlbugs
		fi
	else # 3eme allele retenu à ce locus alors que le site est attendu biallelic, ça veut probablement suggérer un locus monomorphe pour le major et une erreur de séquençage retenue. Néanmoins dans le doute je ne conserve pas ces sites
		count_ref_pop4=$(echo "NA") 
		count_alt_pop4=$(echo "NA")
		count_ref_alt_pop4=$(echo "NA")
		echo "cas 1: minorall_pop4 == $minorall_pop4 != $expectedmajor ou $expectedminor à la position $position" >> $pwd_biallelic_sites_controlbugs
	fi
	echo "position=$position	count_ref_pop1=$count_ref_pop1	count_alt_pop1=$count_alt_pop1	count_total_pop1=$count"
	if [ "$count_alt_pop1" == "NA" ] || [ "$count_alt_pop2" == "NA" ] || [ "$count_alt_pop3" == "NA" ] || [ "$count_alt_pop4" == "NA" ]; then
		echo "$position: no test because this site contains NA information at least for one population" >> $pwd_biallelic_sites_counts_infotest
		echo "$position: this site contains NA information at least for one population - sites were excluded for this version of the script alt_pop1= $count_alt_pop1 alt_pop2= $count_alt_pop2  alt_pop3= $count_alt_pop3 alt_pop4= $count_alt_pop4 alt_pop5= $count_alt_pop5 alt_pop6= $count_alt_pop6 alt_pop7= $count_alt_pop7 alt_pop8= $count_alt_pop8" >> $pwd_biallelic_sites_counts_infosites
		echo "$position	$count_ref_pop1	$count_alt_pop1	$count_ref_alt_pop1	$count_ref_pop2	$count_alt_pop2	$count_ref_alt_pop2	$count_ref_pop3	$count_alt_pop3	$count_ref_alt_pop3	$count_ref_pop4	$count_alt_pop4	$count_ref_alt_pop4" >> $pwd_biallelic_sites_counts_excludedNA
	else
		total_count_alt=$(echo "$count_alt_pop1" + "$count_alt_pop2" + "$count_alt_pop3" + "$count_alt_pop4" | bc)
		total_all_count=$(echo "$count_ref_alt_pop1" + "$count_ref_alt_pop2" + "$count_ref_alt_pop3" + "$count_ref_alt_pop4" | bc)
		cutoff=$(echo "$cutoffMAF * $total_all_count" | bc)
		test=$(echo "$total_count_alt > $cutoff && $cutoff > 20" | bc) #400x4x0.0125
		if [ $test = '1' ]; then
			echo  "$position: test ACCEPTED cutoff=$cutoff total_count_alt=$total_count_alt total_all_count=$total_all_count" >> $pwd_biallelic_sites_counts_infotest
			echo "$position accepted car $total_count_alt (avec $total_all_count * $cutoffMAF) est supérieur à $cutoff" >> $pwd_biallelic_sites_counts_infosites	
			echo "$position	$count_ref_pop1	$count_alt_pop1	$count_ref_alt_pop1	$count_ref_pop2	$count_alt_pop2	$count_ref_alt_pop2	$count_ref_pop3	$count_alt_pop3	$count_ref_alt_pop3	$count_ref_pop4	$count_alt_pop4	$count_ref_alt_pop4" >> $pwd_biallelic_sites_counts
		elif  [ $test != '1' ]; then
			echo "$position: test REJECTED cutoff=$cutoff total_count_alt=$total_count_alt total_all_count=$total_all_count" >> $pwd_biallelic_sites_counts_infotest
			echo "$position excluded car $total_count_alt (avec $total_all_count * $cutoffMAF) est inférieur à $cutoff" >> $pwd_biallelic_sites_counts_infosites
			echo "$position	$count_ref_pop1	$count_alt_pop1	$count_ref_alt_pop1	$count_ref_pop2	$count_alt_pop2	$count_ref_alt_pop2	$count_ref_pop3	$count_alt_pop3	$count_ref_alt_pop3	$count_ref_pop4	$count_alt_pop4	$count_ref_alt_pop4" >> $pwd_biallelic_sites_counts_excludedMAF
		else
			echo "$position: test REJECTED (other) cutoff=$cutoff total_count_alt=$total_count_alt total_all_count=$total_all_count"  >> $pwd_biallelic_sites_counts_infotest
			echo "ELSE à $position excluded car $total_count_alt (avec $total_all_count * $cutoffMAF) pour une raison inconne cutoff = $cutoff alt_pop1= $count_alt_pop1 alt_pop2= $count_alt_pop2  alt_pop3= $count_alt_pop3 alt_pop4= $count_alt_pop4" >> $pwd_biallelic_sites_counts_infosites
		fi
	fi
done < $pwd_biallelic_sites_extended
