#Create chr specific vcf files:
for chr in {1..22};
do plink --bfile /home/wheelerlab3/Data/ACCOuNT/ACCOuNT_PLINKfiles/ACCOuNTBLACKSfinal --chr ${chr} --recode vcf --out account_blacks_chr${chr};
done

#bgzip files:
for chr in {1..22};
do bgzip account_blacks_chr${chr}.vcf;
done

