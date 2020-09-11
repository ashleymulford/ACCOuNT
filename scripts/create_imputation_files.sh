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

#Imputation successful for chrs 21,22

#Imputation failed for chrs 19,20 - due to the following error:
  #Error: More than 10000 obvious strand flips have been detected. Please check strand. Imputation cannot be started!


#once imputation is complete download and renmae files:
wget https://imputation.biodatacatalyst.nhlbi.nih.gov/share/results/138cfce60db2f4da992af59349a8dfa1/chr_22.zip

##problem unzipping - unsupported compression method 99 (refers to Adavanced Encryption Standard encryption)
  ## need another software like 7zip to unzip imputted files
for chr in {1..22};
do unzip chr_${chr}.zip;
done

for chr in {1..22};
do chr_${chr}.zip > account_blacks_chr{chr}_imputed.vcf
done
