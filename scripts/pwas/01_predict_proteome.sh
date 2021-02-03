#Run PrediXcan with all drug groups and protein models:

declare -a drugs=("clop" "apix" "riva" "warf")
declare -a model_pops=("AFA" "ALL" "CAU" "CHN" "HIS")

for model_pop in ${model_pops[@]}
  do
  for drug in ${drugs[@]}
    do
    python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
    --model_db_path /home/ryan/TOPMed_Proteome/dbs_out/${model_pop}_PCAIR_baseline_models_PAV_filtered_rho0.1_zpval0.05.db \
    --text_genotypes /home/ashley/account/dosages/blacks/${drug}/pred_dosages/${drug}_chr*.dosage.txt.gz \
    --text_sample_ids /home/ashley/account/dosages/blacks/${drug}/samples_${drug}.txt \
    --prediction_output /home/ashley/account/pwas_results/blacks/${drug}/predicted_levels/blacks_${drug}_PCAIR_PAV_filtered_${model_pop}_baseline_rho0.1_zpval0.05.txt
  done
done

