#Predict transcript levels for four drug groups using AFA and ALL MESA models

#NOAC:

declare -a drugs=("apix" "clop" "riva" "noac")
declare -a model_pops=("AFA" "ALL")

for model_pop in ${model_pops[@]}
  do
  for drug in ${drugs[@]}
    do
    python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
    --model_db_path /home/wheelerlab3/Data/MESA_dbs/${model_pop}_filtered_cpos_hg38.db  \
    --text_genotypes /home/ashley/account/dosages/blacks/${drug}/pred_dosages/${drug}_chr*.dosage.txt.gz \
    --text_sample_ids /home/ashley/account/dosages/blacks/${drug}/samples_${drug}.txt \
    --prediction_output /home/ashley/account/pwas_results/blacks/${drug}/predicted_levels/blacks_${drug}_${model_pop}_filtered_transcript.txt
  done
done
