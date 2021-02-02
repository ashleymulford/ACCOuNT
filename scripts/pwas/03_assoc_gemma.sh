

declare -a drugs=("arac" "cape" "carbo" "cis" "dauno" "etop" "pacl" "peme")
declare -a models=("CAU" "ALL" "AFA" "CHN" "HIS")

#Use loop to run PrediXcan step two through GEMMA (accounts for relatedness)
for drug in ${drugs[@]}
  do
  for model in ${models[@]}
    do
    /usr/local/bin/gemma -g /home/ashley/LCL_chemotherapy/YRI/YRI_pwas_results/association_input/YRI_PCAIR_PAV_filtered_${model}_baseline_rho0.1_zpval0.05_gemma.txt -notsnp -p /home/ashley/LCL_chemotherapy/YRI/YRI_phenotypes/YRI_${drug}_bestpheno_noids.txt -k /home/ashley/LCL_chemotherapy/YRI/YRI_relationship_matrix_maf.cXX.txt -lmm 4 -o YRI_${drug}_PCAIR_PAV_filtered_${model}_baseline_rho0.1_zpval0.05
  done
done
