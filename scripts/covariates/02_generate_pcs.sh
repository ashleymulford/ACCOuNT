#Principal Component Analysis with King:
#Use pre-imputed plinkfiles, get PCs for each drug group

#Example with clop:
/home/ashley/king --pca -b pre_imputed_blacks_clop.bed --prefix blacks_clop_pca_

#Note: currently having issue with riva and warf - getting 0.00 for eigen values and pcs
#clop and apix output fine

#With mds instead of pca:
/home/ashley/king --mds -b pre_imputed_blacks_clop.bed --prefix blacks_clop_mds_

#This works for all drugs - no 0 values

#main diff between output of --pca and --mds:
#--pca produces eigen values ~1500-900
#--mds produces eigen values ~0.3-0.1
#10 pcs in file output are of similar scale though (decimals between +1 and -1)



plink --bfile pre_imputed_blacks_clop_hapmap_merged --indep-pairwise 50 5 0.2 --out pre_imputed_blacks_clop_hapmap_merged
plink -bfile pre_imputed_blacks_clop_hapmap_merged --extract pre_imputed_blacks_clop_hapmap_merged.prune.in --make-bed --out pre_imputed_blacks_clop_hapmap_merged_pruned
/home/ashley/king --pca -b pre_imputed_blacks_clop_hapmap_merged_pruned.bed --prefix blacks_clop_hapmap_merged_pruned_pca_




