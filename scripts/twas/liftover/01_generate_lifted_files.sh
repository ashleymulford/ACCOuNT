#After downloading liftover file (hg38ToHg19.over.chain.gz)

#generate lifted file for all dosages, split by chr for each drug:
#converting from b38 to b37

declare -a drugs=("apix" "clop" "riva" "noac")
for drug in ${drugs[@]}
  do
  for chr in {1..22}
    do awk '{print $1 FS $3 FS $3+1 FS $2}' /home/ashley/account/dosages/blacks/${drug}/pred_dosages/${drug}_chr${chr}.dosage.txt > /home/ashley/account/liftover/lifted_dosages_b37/${drug}/prelifted_files/${drug}_chr${chr}_prelift.txt
    liftOver /home/ashley/account/liftover/lifted_dosages_b37/${drug}/prelifted_files/${drug}_chr${chr}_prelift.txt /home/ashley/LCL_chemotherapy/hg19ToHg38.over.chain.gz /home/ashley/account/liftover/lifted_dosages_b37/${drug}/lifted_files/${drug}_chr${chr}_lifted.txt /home/ashley/account/liftover/lifted_dosages_b37/${drug}/lifted_files/${drug}_chr${chr}_unmapped.txt;
  done
done


#dosage files must be unzipped for use

#next step: use lifted files to generate new dosage files in b37
