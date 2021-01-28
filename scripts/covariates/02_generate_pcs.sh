#Principal Component Analysis with King:
#Use pre-imputed plinkfiles, get PCs for each drug group


#Example with Clop:

#QC data first:
/home/ryan/gwasqc_pipeline/shellscripts/01MissingnessFiltering -b /home/ashley/account/vcfs/preimputation_plinkfiles/clop/pre_imputed_blacks_clop --maf 0.01 -a -o /home/ashley/account/vcfs/preimputation_plinkfiles/clop/
#outputs a series of filtered files, use most filtered: 05filtered_HWE.bed

#Run KING:
/home/ashley/king --pca -b /home/ashley/account/vcfs/preimputation_plinkfiles/clop/missingness_hwe_steps/05filtered_HWE.bed --prefix blacks_clop_


#PCs for each drug saved in /home/ashley/account/covariates/
