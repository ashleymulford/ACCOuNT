#Do for both pops:

#Convert vcf to ped/map, bed/bim/fam

for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --out chr${chr}_maf01_r28;
plink --file chr${chr}_maf01_r28 --make-bed --out chr${chr}_maf01_r28;
done

#Samples file for predixcan:
awk '{print $1, $2}' chr1_maf01_r28.fam > samples_blacks.txt


#For Clop:

for chr in {1..22};
do plink --vcf clop_chr${chr}.recode.vcf.gz --recode --out clop_chr${chr};
plink --file clop_chr${chr} --make-bed --out clop_chr${chr};
done

#Samples file for predixcan:
awk '{print $1, $2}' clop_chr1.fam > samples_blacks_clop.txt


