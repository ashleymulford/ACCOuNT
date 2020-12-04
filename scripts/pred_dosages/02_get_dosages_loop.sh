#For both black and white cohorts:

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/clop/ -c ${chr};
done

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/apix/ -c ${chr};
done

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/riva/ -c ${chr};
done

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/noac/ -c ${chr};
done

for chr in {1..22};
do python /home/ashley/account/scripts/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/warf/ -c ${chr};
done
