#add ids to b37 dosages

declare -a drugs=("apix" "clop" "riva" "noac")
for drug in ${drugs[@]}
  do
  for chr in {1..22}
    do python 03_liftover_dosages_add_ids.py --input /home/ashley/account/liftover/lifted_dosages_b37/${drug}/b37_dosages/${drug}_chr${chr}_b37.dosage.txt --output /home/ashley/account/liftover/lifted_dosages_b37/${drug}/b37_dosages/${drug}_chr${chr}_b37_ids.dosage.txt
  done
done
