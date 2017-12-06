# GenomeScansByABC
This GitHub respository contains all datasets, scripts and programs used to perform demographically-explicit genome scans following Leroy et al. submitted
For any questions, please contact : thibault.leroy_AT_inra.fr

## 1 ABC
### 1A/PROGRAMS: ABC/ABC_SCRIPTS/
 
- To compile mscalc, the calculator of summary statistics (Ross-Ibarra et al. 2008; 2009; Roux et al. 2011):
 
 gcc *.c -lm -o mscalc
 
- To compile msnsam, the coalescent simulator (Ross-Ibarra et al. 2008):
 
 ./clms
 
- Generator of priors
priorgen_260415.py, prior generator for different scenarios (IM or SC)
priorgen_recenttimes_260415.py, prior generator for recent demographic events (recent SC in Leroy et al. submitted)

To have more details: 
priorgen_260415.py -h
priorgen_recenttimes_260415.py -h
  
 
### 1B/ DATASETS ABC/datasets_50kSNPs
 
All oak datasets used for our ABC analyses are available. For each pair of clusters, a bpfile, a spinput.txt and a file containing the summary statistics for the real dataset are available. To perform the multilocus coalescent simulations, the bpfile & spinput.txt files are required (i.e. need to be in your current directory). 
  
The target file contains the 19 summary statistics calculated on each real dataset.

### 1C/ EXAMPLE: Multilocus coalescent simulations (all following examples are shown for the Q.robur-Q.petraea pair):
 - Introduction

>2000 multilocus simulations assuming an IM scenario between Q.robur & QQ.petraea [i.e. number of SNPs (=44798) x number of simulations (=2000) = 1,360,000]

>Number of SNPs = 2nd line of the "spinput.txt" file

 - Bash script (note that here all programs are assumed to be in your bin directory):

> mknod myfifo p
 
> priorgen4_recentbottle.py bpfile=bpfile n1=0 n1=100 n2=0 n2=100 nA=0 nA=100 tau=0 tau=100 bottleneck=N taubottle=0 taubottle=10 alpha1=1 alpha1=1 alpha2=1 alpha2=1 M1=0 M1=100 M2=0 M2=100 shape1=0 shape1=100 shape2=0 shape2=500 model=AM nreps=20000 Nvariation=hetero Mvariation=hetero symMig=asym parameters=priorfile | msnsam tbs 1360000 -s 1 -I 2 tbs tbs 0 -m 1 2 tbs -m 2 1 tbs -n 1 tbs -n 2 tbs -ema tbs 2 0 tbs tbs 0 -ej tbs 2 1 -eN tbs tbs >myfifo &
 
> mscalc < myfifo
 
