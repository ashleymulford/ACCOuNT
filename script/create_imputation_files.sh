#Create chr specific ped/map files:
for chr in {1..22};
do plink --bfile /home/wheelerlab3/Data/ACCOuNT/ACCOuNT_PLINKfiles/ACCOuNTBLACKSfinal --chr ${chr} --recode --out account_blacks_chr${chr};
done

#GRCh38 requires chromosomes as "chr1" not "1" - convert with Rscript: 
Rscript edit_map.R

#Convert to VCF format:
for chr in {1..22};
do plink --file account_blacks_chr${chr} --recode vcf --out account_blacks_chr${chr};
done

#bgzip files:
for chr in {1..22};
do bgzip account_blacks_chr${chr}.vcf;
done

