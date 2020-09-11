#Create chr specific VCF files:
for chr in {1..22};
do plink --bfile /home/wheelerlab3/Data/ACCOuNT/ACCOuNT_PLINKfiles/ACCOuNTBLACKSfinal --chr ${chr} --recode vcf --out account_blacks_chr${chr};
done

#GRCh38 requires chromosomes as "chr1" not "1" - convert with awk: 
for chr in {1..22};
do awk '{if($0 !~ /^#/) print "chr"$0; else print $0}' account_blacks_chr${chr}.vcf > account_blacks_chrchr${chr}.vcf;
done

#bgzip files:
for chr in {1..22};
do bgzip account_blacks_chrchr${chr}.vcf;
done

