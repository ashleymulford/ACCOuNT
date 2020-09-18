#Filter out SNPs with maf < 0.01

for chr in {1..22};
do bcftools view -q 0.01:minor chr${chr}.dose.vcf.gz | bgzip -c > chr${chr}_maf01.vcf.gz;
done

