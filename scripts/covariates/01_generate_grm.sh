#Create Relatedness Matrix with GEMMA - one per drug group
#Use pre-imputation plinkfiles

#Create bed/bim/fam for each drug based on indiividual list:

#Example with clop:
plink --bfile /home/ashley/account/vcfs/preimputation_plinkfiles/ACCOuNTBLACKSfinal_updated --keep /home/ashley/account/vcfs/blacks_imputed/clop/clop_ids_filt.txt --make-bed --out pre_imputed_blacks_clop

#Generate Relatedness Matrices:
#use excluded_snps file, generated when plotting pcs
#change all phenos from missing (-9) to 1 in fam file (find/replace with nano)
#Example with clop:
gemma -bfile pre_imputed_blacks_clop_excluded_snps -gk 1 -o blacks_clop

#Generate Similarity/Relatedness Matirces:
#Examples with clop:
plink --bfile pre_imputed_blacks_clop --cluster --matrix --out blacks_clop


gemma -bfile pre_imputed_blacks_noac_excluded_snps -gk 1 -o blacks_noac
