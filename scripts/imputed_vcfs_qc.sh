#For both black and white cohorts:

#Filter out SNPs with maf < 0.01:
for chr in {1..22};
do bcftools view -q 0.01:minor chr${chr}.dose.vcf.gz | bgzip -c > chr${chr}_maf01.vcf.gz;
done

#Filer out SNPs with r^2 < 0.8:
for chr in {1..21};
do 
done

