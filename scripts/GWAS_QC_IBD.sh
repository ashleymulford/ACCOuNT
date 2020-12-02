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

plink --file chr1_maf01_r28 --merge-list mergelist.txt --make-bed --out black_imputed_filtered_allchr

#make ped/map:
plink --bfile black_imputed_filtered_allchr --recode --out black_imputed_filtered_allchr


# Run Rscript to separate by drug: 
