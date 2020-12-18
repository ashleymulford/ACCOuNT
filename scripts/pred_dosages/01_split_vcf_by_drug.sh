#generate list of IDs to keep based on individuals in each drug group
#format of ids is fid_iid
#keep all individuals in dosage files - will remove some individuals based on IBD QC from pheno data so they are skipped

#VCFs have been imputed, filtered, and are separated by chr
#Create sets of VCFs, keep individuals in each corresponding drug group:

#Example with Clop:
for chr in {1..22};
do vcftools --gzvcf /home/ashley/account/vcfs/blacks_imputed/all/chr${chr}_maf01_r28.vcf.gz --keep clop_ids_new.txt --recode --recode-INFO-all --out clop_chr${chr};
done

#will output unzipped vcfs - gzip vcfs afterwards for next step

#Do the above for every drug

#Note: populations were split by drug and all people with genotype data (and geno ids) that were found in the pheno file were included
#People in the pheno file could still have missing (NA) data for the phenotype.
