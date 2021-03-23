#association with gemma (TWAS)

declare -a drugs=("clop" "apix" "riva" "noac")
declare -a models=("ALL" "AFA")

#Use loop to run PrediXcan step two through GEMMA (accounts for relatedness)
for drug in ${drugs[@]}
  do
  for model in ${models[@]}
    do
    /usr/local/bin/gemma -g /home/ashley/account/twas_results/${drug}/assoc_gemma_input/blacks_${drug}_${model}_filtered_predicted_transcript_gemma.txt \
    -notsnp \
    -p /home/ashley/account/phenos/${drug}/${drug}_rn_pheno_no_ids.txt \
    -k /home/ashley/account/covariates/${drug}/blacks_${drug}.cXX.txt \
    -c /home/ashley/account/covariates/${drug}/${drug}_covariates.txt \
    -lmm 4 \
    -o ${drug}_rn_${model}_transcript
  done
done
