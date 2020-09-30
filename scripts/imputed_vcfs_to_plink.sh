
#Convert vcf to ped/map, bed/bim/fam, frq

for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --out chr${chr}_maf01_r28;
plink --file chr${chr}_maf01_r28 --make-bed --out chr${chr}_maf01_r28;
plink --file chr${chr}_maf01_r28 -freq --out chr${chr}_maf01_r28;
done

