#both pops:


python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
--model_db_path /home/ryan/topmed/proteome/dapg_net_CORRECT_WINDOWS/current_dbs/PAV_filteredAFA_WG_baseline_rho0.1_zpval0.05.db \
--text_genotypes /home/ashley/account/dosages/blacks/pred_dosages/chr*.maf0.01.r20.8.dosage.txt.gz \
--text_sample_ids /home/ashley/account/dosages/blacks/samples_blacks.txt \
--prediction_output /home/ashley/account/pwas_results/blacks/predicted_levels/blacks_PAV_filteredAFA_WG_baseline_rho0.1_zpval0.05.txt


python3 /home/wheelerlab3/MetaXcan/software/Predict.py \
--model_db_path /home/ryan/topmed/proteome/dapg_net_CORRECT_WINDOWS/current_dbs/PAV_filteredALL_WG_baseline_rho0.1_zpval0.05.db \
--text_genotypes /home/ashley/account/dosages/whites/pred_dosages/chr*.maf0.01.r20.8.dosage.txt.gz \
--text_sample_ids /home/ashley/account/dosages/whites/samples_whites.txt \
--prediction_output /home/ashley/account/pwas_results/whites/predicted_levels/whites_PAV_filteredALL_WG_baseline_rho0.1_zpval0.05.txt
