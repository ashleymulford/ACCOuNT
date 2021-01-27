#generate list of IDs to keep based on individuals in each drug group
#format of ids is fid_iid
#Remove some individuals based on IBD QC:
#Clop: remove MP-7440 and MP-7442 (came up as twins but are not, remove both)
#Apix: remove MP-8428-2 (genotyped wrong, came up as twins with MP-8429-2 but not)
#Warf: remove MP-8429-2 (genotyped wrong, came up as twins with MP-8428-2 but not)
#Riva: keep all


#VCFs have been imputed, filtered, and are separated by chr
#Create sets of VCFs, keep individuals in each corresponding drug group:

#Example with Clop:
for chr in {1..22};
do vcftools --gzvcf /home/ashley/account/vcfs/blacks_imputed/all/chr${chr}_maf01_r28.vcf.gz --keep clop_ids_new_filt.txt --recode --recode-INFO-all --out clop_chr${chr};
done

#will output unzipped vcfs - gzip vcfs afterwards for next step

#Do the above for every drug

#Note: populations were split by drug and all people with genotype data (and geno ids) that were found in the pheno file were included except those removed due to IBD QC findings.
#final counts (genotype data): clop - 141, apix - 132, warf - 296, riva - 102
#People in the pheno file could still have missing (NA) data for the phenotype.
