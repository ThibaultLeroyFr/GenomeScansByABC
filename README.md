# GenomeScansByABC
_This GitHub repository contains all datasets, scripts and programs used to perform demographically-explicit genome scans following Leroy et al. submitted._
_For any questions, please contact : thibault.leroy\_AT\_inra.fr_

### 1 SNP Calling & Filtering (./SNP\_calling\_filtering/)

_For each species, we provide the pipeline used for mapping, sorting & excluding duplicates ("1-script\_BAN\_mapping\_bowtie2\*")._

_After generating a synchronized pileup ("2-script\_samtools\_pileup\_4especes\_201216.sh" & "3-script\_mpileup2sync\_java\_BAN\_4species.sh"), we generated a RC file using popoolation2 ("4-script\_FreqSNP\_4especes\*") to filter SNPs and generate allele counts at each SNPs using a home-made script ("5-script\_filterSNPs\_generate\_allele\_count.sh")._

### 2 ABC
### 2A/PROGRAMS: (./ABC/ABC\_scripts/)
 
- To compile mscalc, the calculator of summary statistics (Ross-Ibarra et al. 2008; 2009; Roux et al. 2011):
 
 >gcc *.c -lm -o mscalc
 
- To compile msnsam, the coalescent simulator (Ross-Ibarra et al. 2008):
 
 >./clms
 
- Generator of priors<br>
_priorgen\_260415.py, prior generator for different scenarios (IM or SC)<br>priorgen\_recenttimes\_260415.py, prior generator for recent demographic events (recent SC in Leroy et al. submitted)_

To have more details: 
>priorgen\_260415.py -h <br>
priorgen\_recenttimes\_260415.py -h
  
 
### 2B/ DATASETS (./ABC/datasets\_50kSNPs)
 
All oak datasets used for our ABC analyses are available. For each pair of species, a bpfile, a spinput.txt and a "target" file containing the summary statistics for the real dataset are available. To perform the multilocus coalescent simulations, the bpfile & spinput.txt files are required (i.e. need to be in your current directory). 
  
The target file contains the 19 summary statistics calculated on each real dataset but only last 17 ones were used for selecting models and drawing posteriors in Leroy et al. 2017 (2 first ones are poorly informative for comparing IM & SC).

We also provide the procedure we used to generate datasets for ABC (see ABC/datasets\_50kSBOS/procedure\_to\_generate\_datasets/all\_freq\_generate\_counts\_rob-pet\_40X-26X.sh), this includes the original file containing allele counts at 50k SNP positions.

### 2C/ EXAMPLE: Multilocus coalescent simulations & R analyses:

Note that all following examples are shown for the Q.robur-Q.petraea pair (but the same strategy was used for all pairs).
 - Introduction

>2,000 multilocus simulations assuming an IM scenario between Q.robur & Q.petraea [i.e. number of SNPs (=44798) x number of simulations (=2,000) = 89,596,000] <br> Replicated 500 times to obtain 1 million simulations in Leroy et al. submitted (500 CPUs)

 - Bash script (note that here all programs are assumed to be in your bin directory):
 ```bash
mknod myfifo p
priorgen_260415.py bpfile=bpfile n1=0 n1=100 n2=0 n2=100 nA=0 nA=100 tau=0 tau=100 M1=0 M1=100 M2=0 M2=100 shape1=0 shape1=100 shape2=0 shape2=500 model=IM nreps=44798 Nvariation=hetero Mvariation=hetero symMig=asym parameters=priorfile | msnsam tbs 89596000 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -ej tbs 2 1 -eN tbs tbs >myfifo &
mscalc < myfifo
```
- Model Selection (see ./ABC/ABC\_scripts/R\_ModelChoice\_2models-IMvsSC\_heteroNe\_heteroM\_Pools\_rob-pet\_060217.Rscripts for an example)
- Generate posteriors (see /ABC/ABC\_scripts/script\_R\_generateposterior\_SC\_020817.R)
 
### 3 FST (./Fst\_10kb\_Sliding\_windows/)
Script used to compute Fst under Popoolation2 (./Fst\_10kb\_Sliding\_windows/script\_Popoolation\_Fst\_slidingwindows10kb\_4species.sh).

### 4 Null Envelopes (./Null\_Envelopes/)
To be performed backward simulations require posteriors (95% confidence intervals of parameters), a bpfile & spinput.txt (containing information for a single SNP and number of haplotypes per pair). To perform this analysis, we used a dedicated version of priorgen "priorgen\_posterior2prior\_160217.py").
Then backward simulations were performed (500,000 simulated SNPs x 10 times) to compute summary statistics (He, Gst) using the R script "script.fst.he.neutr2.R".
 ```bash
for i in {1..500000}; do
   priorgen_posterior2prior_160217.py bpfile=bpfile n1=$nsp1a n1=$nsp1b n2=$nsp2a n2=$nsp2b nA=$nanc1 nA=$nanc2 tau=$tau1 tau=$tau2 RatioTsmallTsplit=$ratio1 RatioTsmallTsplit=$ratio2 M1=$M1a M1=$M1b M2=$M2a M2=$M2b shape1=$shape1a shape1=$shape1b shape2=$shape2a shape2=$shape2b model=SC nreps=1 Nvariation=hetero Mvariation=homo symMig=asym parameters=priorfile | msnsam tbs 1 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -eM tbs 0 -ej tbs 2 1 -eN tbs tbs > tmp.ms
  tail -1 priorfile >> priorfile_simuls.txt
  tail -$ntot tmp.ms > tmp.ms.2
  Rscript script.fst.he.neutr2.R tmp.ms.2 $indsp1 $indsp2
done
```
Then we used a R script to generate neutral quantiles of Gst as a function of heterozygosity ("script\_skyline\_dfdistlike\_he\_fst\_Poolseq.R).

### 5 Genome scans (./Genome\_Scans/)
Based on the previous null envelopes, we then used the script "1-script\_detect\_outliers\_he\_fst.sh" to detect outliers and the script "2-script\_OutlierDensity\_slidingwindows.sh" to perform the sliding window approach. The last script requires some additional files concerning the length of scaffolds that was made available for the oak genome (see ./Genome\_Scans/companion\_genomic\_files/). For testing this script, we also include the status (outlier/neutral) of the first 200,000 SNPs as indicated in "/Genome\_Scans/companion\_genomic\_files/README.txt").
