#TWAS MESA models are in build 37 - must liftover dosages to build 37 from build 38 first and then map to rsids - see liftover folder for scripts

#(re-)gzip all dosage files after liftover (both b37 and b38)

#Predict transcript levels for four drug groups using AFA and ALL MESA models

declare -a drugs=("apix" "clop" "riva" "noac")
declare -a model_pops=("AFA" "ALL")

for model_pop in ${model_pops[@]}
  do
  for drug in ${drugs[@]}
    do
    python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
    --model_db_path /home/ashley/MESA_dbs/${model_pop}_imputed_10_peer_3_pcs_v2.db \
    --text_genotypes /home/ashley/account/liftover/lifted_dosages_b37/${drug}/b37_dosages/${drug}_chr*_rsid_b37.dosage.txt.gz \
    --text_sample_ids /home/ashley/account/dosages/blacks/${drug}/samples_${drug}.txt \
    --prediction_output /home/ashley/account/twas_results/${drug}/predicted_levels/blacks_${drug}_${model_pop}_filtered_predicted_transcript.txt
  done
done



#Predict transcript levels for four drug groups using relavent mashr models

declare -a drugs=("apix" "clop" "riva" "noac")
declare -a model_tiss=("Whole_Blood" "Heart_Atrial_Appendage" "Heart_Left_Ventricle" "Liver")

for tiss in ${model_tiss[@]}
  do
  for drug in ${drugs[@]}
    do
    python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
    --model_db_path /home/ashley/gtex_v8_mashr_eqtl_dbs/mashr_${tiss}.db \
    --text_genotypes /home/ashley/account/liftover/lifted_dosages_b37/${drug}/b37_dosages/${drug}_chr*_rsid_b37.dosage.txt.gz \
    --text_sample_ids /home/ashley/account/dosages/blacks/${drug}/samples_${drug}.txt \
    --prediction_output /home/ashley/account/twas_results/${drug}/predicted_levels/blacks_${drug}_${tiss}_filtered_predicted_transcript.txt
  done
done
