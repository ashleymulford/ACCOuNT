#How to fix strand flip error (requires plink formatted files):
  #identify genome build
    #easiest way is to search for an rsid on https://www.ncbi.nlm.nih.gov/snp/

  #use this website to identify chip needed, input bim file and run:
    #http://mccarthy.well.ox.ac.uk/chipendium/ui/
  
  #download strand data (under strand and position files) - use corresponding chip and genome build:
    #https://www.well.ox.ac.uk/~wrayner/strand/index.html
    #use wget to download to your directory
  
  #download the following script:
  wget https://www.well.ox.ac.uk/~wrayner/strand/update_build.sh
  
  #run script to convert data to consistent strand/reduce strand flips:
  bash update_build.sh <bed-file-stem> <strand-file> <output-file-stem>
    #<bed-file-stem>	is the name of your binary ped set minus the .bed, .bim or .fam extension
    #<strand-file>	is appropriate strand file for you chip and current strand orientation (TOP, SOURCE, ILMN)
    #<output-file-stem>	is the name of the new output file to create again minus the .bed, .bim or .fam extension
  
  #once updated bed/bim/fam obtained proceed with making vcfs for imputation


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

#once imputation is complete download and renmae files:
  #go to results for wget command

#unzip with 7za
for chr in {1..22};
do 7za e chr_${chr}.zip;
done

