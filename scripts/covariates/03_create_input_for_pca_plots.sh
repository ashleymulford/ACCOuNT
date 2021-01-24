#For pca plots we want to plot the ACCOUnT cohort and the hapmap pops (YRI, CEU, and ASN) to confirm the pcs are correct.

#Example with Clop:

#Must run pca with all pops, start by merging plinkfiles:

#Tried to run merge command but gave an error about number of alleles in certain SNPs (output missnp file with ~300 SNPs)
plink --bfile pre_imputed_blacks_clop --bmerge /home/ashley/account/covariates/hapmap_pops_plinkfiles_for_pcs/hapmap.hg38 --make-bed --out pre_imputed_blacks_clop_hapmap_merged

#Removed problematic SNPs from hapmap file
plink --bfile hapmap.hg38 --exclude /home/ashley/account/vcfs/preimputation_plinkfiles/clop/pre_imputed_blacks_clop_hapmap_merged-merge.missnp --make-bed --out hapmap.hg38_excluded_snps

#Ran merge again, worked this time
plink --bfile pre_imputed_blacks_clop --bmerge /home/ashley/account/covariates/hapmap_pops_plinkfiles_for_pcs/hapmap.hg38_excluded_snps --make-bed --out pre_imputed_blacks_clop_hapmap_merged


#Run PCA with merged plinkfiles:
/home/ashley/king --mds -b pre_imputed_blacks_clop_hapmap_merged.bed --prefix blacks_clop_hapmap_merged_mds_

#Largest 10 Eigenvalues:
#57.69 18.20 12.76 2.39 0.37 0.37 0.37 0.37 0.37 0.37
