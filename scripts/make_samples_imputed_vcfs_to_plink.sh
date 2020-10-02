#Do for both pops:

#Convert vcf to ped/map, bed/bim/fam

for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --out chr${chr}_maf01_r28;
plink --file chr${chr}_maf01_r28 --make-bed --out chr${chr}_maf01_r28;
done

#Samples file for predixcan:
awk '{print $1, $2}' chr1_maf01_r28.fam > samples_blacks.txt


