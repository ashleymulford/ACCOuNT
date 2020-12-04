#generate list of IDs to keep based on individuals in each drug group
#format of ids is fid_iid

#VCFs have been imputed, filtered, and are separated by chr
#Create 5 sets of VCFs, keep individuals in each corresponding drug group:

for chr in {1..22};
do vcftools --gzvcf /home/ashley/account/vcfs/blacks_imputed/chr${chr}_maf01_r28.vcf.gz --keep clop_ids_new.txt --recode --out clop_chr${chr};
done
