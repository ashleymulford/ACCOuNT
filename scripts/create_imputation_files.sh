#For both black and white cohorts:

#Genome build 38
#Chip: Multi-EthnicGlobal_A1 (identified with http://mccarthy.well.ox.ac.uk/chipendium/ui/)

#Download script/strand files here: https://www.well.ox.ac.uk/~wrayner/strand/index.html 
wget https://www.well.ox.ac.uk/~wrayner/strand/update_build.sh
wget https://www.well.ox.ac.uk/~wrayner/strand/Multi-EthnicGlobal_A1-b38-strand.zip


#Convert to same strand:
bash update_build.sh ACCOuNTBLACKSfinal Multi-EthnicGlobal_A1-b38.strand ACCOuNTBLACKSfinal_updated

#Convert bed/bim/fam to chr specific VCF files:
for chr in {1..22};
do plink --bfile ACCOuNTBLACKSfinal_updated --chr ${chr} --recode vcf --out account_blacks_chr${chr}_updated;
done

#GRCh38 requires chromosomes as "chr1" not "1" - convert with awk: 
for chr in {1..22};
do awk '{if($0 !~ /^#/) print "chr"$0; else print $0}' account_blacks_chr${chr}_updated.vcf > account_blacks_chrchr${chr}_updated.vcf;
done

#bgzip files:
for chr in {1..22};
do bgzip account_blacks_chrchr${chr}_updated.vcf;
done

#qc and imputation performed: https://imputation.biodatacatalyst.nhlbi.nih.gov/#!pages/home

#once imputation is complete download files:
  #go to results for wget command

#unzip with 7za
7za e chr_#.zip;
  #enter password (from email)
  #produces two gzipped files (leave gzipped to save space)  

