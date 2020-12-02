#Steps to run GWAS QC IBD - identify relatedness in the cohort

#Starting with imputed VCFs:

#Convert VCFs to PLINK format: produces bed/bim/fam and ped/map files
for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --make-bed --out chr${chr}_maf01_r28;
done

#combine all chrs into one file:
for i in {1..22}
do
echo chr${i}_maf01_r28 >> mergelist.txt
done

plink --file chr1_maf01_r28 --merge-list mergelist.txt --make-bed --out blacks_imputed_filtered_allchr

#make ped/map:
plink --bfile blacks_imputed_filtered_allchr --recode --out blacks_imputed_filtered_allchr

# Run Rscript to separate by drug: gwas_qc_separate_ped_by_drug.R
#creates four ped files with individuals grouped by drug taken (same map file is fine, notes snp info not people)

#make bed/bim/fam files for each drug:
plink --ped blacks_clop.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_clop
plink --ped blacks_apix.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_apix
plink --ped blacks_riva.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_riva
plink --ped blacks_warf.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_warf
