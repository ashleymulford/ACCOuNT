#Association Studies with GEMMA for all predicted levels for all drug groups

declare -a drugs=("clop" "apix" "riva")
declare -a models=("CAU" "ALL" "AFA" "CHN" "HIS")

#Use loop to run PrediXcan step two through GEMMA (accounts for relatedness)
for drug in ${drugs[@]}
  do
  for model in ${models[@]}
    do
    /usr/local/bin/gemma -g /home/ashley/account/pwas_results/blacks/${drug}/assoc_input_gemma/blacks_${drug}_PCAIR_PAV_filtered_${model}_WG_baseline_rho0.1_zpval0.05_gemma.txt \
    -notsnp \
    -p /home/ashley/account/phenos/${drug}/${drug}_pheno_noids.txt \
    -k /home/ashley/account/covariates/${drug}/blacks_${drug}.cXX.txt \
    -c /home/ashley/account/covariates/${drug}/${drug}_covariates.txt \
    -lmm 4 \
    -o ${drug}_PCAIR_PAV_filtered_${model}_WG_baseline_rho0.1_zpval0.05
  done
done
