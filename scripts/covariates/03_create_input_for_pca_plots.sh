#For pca plots we want to plot the ACCOuNT cohort and the hapmap pops (YRI, CEU, and ASN) to confirm the pcs are correct.

#Example with Clop:

#Must run pca with all pops, start by merging plinkfiles:

#attempt merge - fails, use missnp output to exclude bad snps
plink --bfile /home/ashley/account/vcfs/preimputation_plinkfiles/clop/missingness_hwe_steps/05filtered_HWE --bmerge /home/ashley/account/covariates/hapmap_pops_plinkfiles_for_pcs/hapmap.hg38 --make-bed --out pre_imputed_blacks_clop_hapmap_merged

#exclude bad snps from both files
plink --bfile hapmap.hg38 --exclude /home/ashley/account/vcfs/preimputation_plinkfiles/clop/pre_imputed_blacks_clop_hapmap_merged-merge.missnp --make-bed --out hapmap.hg38_excluded_snps
plink --bfile /home/ashley/account/vcfs/preimputation_plinkfiles/clop/missingness_hwe_steps/05filtered_HWE --exclude pre_imputed_blacks_clop_hapmap_merged-merge.missnp --make-bed --out pre_imputed_blacks_clop_excluded_snps

#merge new files
plink --bfile pre_imputed_blacks_clop_excluded_snps --bmerge /home/ashley/account/covariates/hapmap_pops_plinkfiles_for_pcs/hapmap.hg38_excluded_snps --make-bed --out pre_imputed_blacks_clop_hapmap_excluded_snps_merged

#Run PCA with merged plinkfiles:
/home/ashley/king --pca -b pre_imputed_blacks_clop_hapmap_excluded_snps_merged.bed --prefix blacks_clop_hapmap_merged_

#Largest 10 Eigenvalues:
#3569.71 2389.00 646.99 590.33 494.22 488.86 487.72 486.80 485.43 485.22
