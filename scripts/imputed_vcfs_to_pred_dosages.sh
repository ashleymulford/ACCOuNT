
#Convert vcf to ped/map

for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --out chr${chr}_maf01_r28;
done
