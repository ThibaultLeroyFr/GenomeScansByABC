# GenomeScansByABC
This GitHub repository contains all datasets, scripts and programs used to perform demographically-explicit genome scans following Leroy et al. submitted
For any questions, please contact : thibault.leroy\_AT\_inra.fr

## 1 ABC
### 1A/PROGRAMS: ABC/ABC_SCRIPTS/
 
- To compile mscalc, the calculator of summary statistics (Ross-Ibarra et al. 2008; 2009; Roux et al. 2011):
 
 >gcc *.c -lm -o mscalc
 
- To compile msnsam, the coalescent simulator (Ross-Ibarra et al. 2008):
 
 >./clms
 
- Generator of priors
>priorgen\_260415.py, prior generator for different scenarios (IM or SC)\npriorgen\_recenttimes\_260415.py, prior generator for recent demographic events (recent SC in Leroy et al. submitted)

To have more details: 
>priorgen\_260415.py -h <br>
priorgen\_recenttimes\_260415.py -h
  
 
### 1B/ DATASETS ABC/datasets\_50kSNPs
 
All oak datasets used for our ABC analyses are available. For each pair of species, a bpfile, a spinput.txt and a "target" file containing the summary statistics for the real dataset are available. To perform the multilocus coalescent simulations, the bpfile & spinput.txt files are required (i.e. need to be in your current directory). 
  
The target file contains the 19 summary statistics calculated on each real dataset but only last 17 ones were included in Leroy et al. 2017.

We also provide the procedure we used to generate datasets for ABC (see ABC/datasets\_50kSBOS/procedure\_to\_generate\_datasets/all\_freq\_generate\_counts\_rob-pet\_40X-26X.sh)

### 1C/ EXAMPLE: Multilocus coalescent simulations (all following examples are shown for the Q.robur-Q.petraea pair):
 - Introduction

>2,000 multilocus simulations assuming an IM scenario between Q.robur & Q.petraea [i.e. number of SNPs (=44798) x number of simulations (=2,000) = 8,9596,000] <br> replicated 500 times to obtain 1 million simulations in Leroy et al. submitted (500 CPUs)

 - Bash script (note that here all programs are assumed to be in your bin directory):
 ```bash
mknod myfifo p
priorgen_260415.py bpfile=bpfile n1=0 n1=100 n2=0 n2=100 nA=0 nA=100 tau=0 tau=100 M1=0 M1=100 M2=0 M2=100 shape1=0 shape1=100 shape2=0 shape2=500 model=IM nreps=44798 Nvariation=hetero Mvariation=hetero symMig=asym parameters=priorfile | msnsam tbs 89596000 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -ej tbs 2 1 -eN tbs tbs >myfifo &
mscalc < myfifo
```
- Model Selection (see ./ABC/ABC\_scripts/R\_ModelChoice\_2models-IMvsSC\_heteroNe\_heteroM\_Pools\_rob-pet\_060217.Rscripts for an example)
- Generate posteriors (see /ABC/ABC\_scripts/script\_R\_generateposterior\_SC\_020817.R)
 
