#!/bin/bash
#$ -q unlimitq
#$ -m abe
#module load compilers/gcc/4.8.5 apps/mugqic_pipeline/2.1.1 mugqic/mugqic_R_packages/0.1_R_3.2.0

folder=distrib.neutral.fst.SCheteroNe-1st

mkdir "$folder"
cp bpfile $folder
cp spinput.txt $folder
cd "$folder"    
myposteriorfile=$(echo "../../Posteriors500_Pool-rob-pet_SC_hetero_hetero_030317_95CI") # Posteriors500_Pool-rob-pet_SC_hetero_hetero_030317_95CI

echo "H1	H2	H_total	He1	He2	He_total	fis	fst" > neutral.stats.txt
indsp1=$(echo "40") #2*nb ind sp1
indsp2=$(echo "26")
ntot=$(echo "$indsp1 + $indsp2" | bc)
nsp1a=$(head -2 $myposteriorfile | tail -1 | awk '{print $1}') # borne inf N1
nsp1b=$(tail -1 $myposteriorfile | awk '{print $1}') # borne sup N1
nsp2a=$(head -2 $myposteriorfile | tail -1 | awk '{print $2}')
nsp2b=$(tail -1 $myposteriorfile | awk '{print $2}')
nanc1=$(head -2 $myposteriorfile | tail -1 | awk '{print $3}')
nanc2=$(tail -1 $myposteriorfile | awk '{print $3}')
tau1=$(head -2 $myposteriorfile | tail -1 | awk '{print $4}')
tau2=$(tail -1 $myposteriorfile | awk '{print $4}')
ratio1=$(head -2 $myposteriorfile | tail -1 | awk '{print $6}')
ratio2=$(tail -1 $myposteriorfile | awk '{print $6}')
M1a=$(head -2 $myposteriorfile | tail -1 | awk '{print $11}')
M1b=$(tail -1 $myposteriorfile | awk '{print $11}')
M2a=$(head -2 $myposteriorfile | tail -1 | awk '{print $12}')
M2b=$(tail -1 $myposteriorfile | awk '{print $12}')
shape1a=$(head -2 $myposteriorfile | tail -1 | awk '{print $7}') # shapeNe
shape1b=$(tail -1 $myposteriorfile | awk '{print $7}')
shape2a=$(head -2 $myposteriorfile | tail -1 | awk '{print $8}')
shape2b=$(tail -1 $myposteriorfile | awk '{print $8}')
echo "/home/tleroy/work2/ABC/priorgen_posterior2prior_160217.py bpfile=bpfile n1=$nsp1a n1=$nsp1b n2=$nsp2a n2=$nsp2b nA=$nanc1 nA=$nanc2 tau=$tau1 tau=$tau2 RatioTsmallTsplit=$ratio1 RatioTsmallTsplit=$ratio2 M1=$M1a M1=$M1b M2=$M2a M2=$M2b shape1=$shape1a shape1=$shape1b shape2=$shape2a shape2=$shape2b model=SC nreps=1000000 Nvariation=hetero Mvariation=homo symMig=asym parameters=priorfile | /usr/local/bioinfo/src/divers_tools/sources_tleroy/msnsam/msnsam tbs 1 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -eM tbs 0 -ej tbs 2 1 -eN tbs tbs >> tmp.ms" > Rappel_CMD.txt
echo "N1	N2	Na	Tsplit	Tsc	shape1Ne	shape2Ne	propNtrlNe1	propNtrlNe2	M1	M2"  > priorfile_simuls.txt
for i in {1..500000}; do
	/home/tleroy/work2/ABC/priorgen_posterior2prior_160217.py bpfile=bpfile n1=$nsp1a n1=$nsp1b n2=$nsp2a n2=$nsp2b nA=$nanc1 nA=$nanc2 tau=$tau1 tau=$tau2 RatioTsmallTsplit=$ratio1 RatioTsmallTsplit=$ratio2 M1=$M1a M1=$M1b M2=$M2a M2=$M2b shape1=$shape1a shape1=$shape1b shape2=$shape2a shape2=$shape2b model=SC nreps=1 Nvariation=hetero Mvariation=homo symMig=asym parameters=priorfile | /usr/local/bioinfo/src/divers_tools/sources_tleroy/msnsam/msnsam tbs 1 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -eM tbs 0 -ej tbs 2 1 -eN tbs tbs > tmp.ms
	tail -1 priorfile >> priorfile_simuls.txt
	tail -$ntot tmp.ms > tmp.ms.2
	Rscript ~/work2/ABC/Pool/script.fst.he.neutr2.R tmp.ms.2 $indsp1 $indsp2
done


#rm tmp* seedms spinput.txt
#sed -i '/^$/d' $outfile
#awk '{print $30}' $outfile >> fst.100000
#rm error.txt spoutput.txt tmp.ms seedms 
