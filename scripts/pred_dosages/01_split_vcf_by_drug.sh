#generate list of IDs to keep based on individuals in each drug group
#format of ids is fid_iid
#remove some individuals based on IBD QC

#VCFs have been imputed, filtered, and are separated by chr
#Create sets of VCFs, keep individuals in each corresponding drug group:

#Example with Clop:
for chr in {1..22};
do vcftools --gzvcf /home/ashley/account/vcfs/blacks_imputed/chr${chr}_maf01_r28.vcf.gz --keep clop_ids_new_filt.txt --recode --out clop_chr${chr};
done
