#For both black and white cohorts:

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/ -c ${chr};
done
