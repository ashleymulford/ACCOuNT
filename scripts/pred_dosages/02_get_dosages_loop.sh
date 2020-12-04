#make dosages for each drug group:

for chr in {1..22};
do python /home/ashley/account/vcfs/blacks_imputed/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/clop/ -c ${chr} -d clop;
done

for chr in {1..22};
do python /home/ashley/account/vcfs/blacks_imputed/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/apix/ -c ${chr} -d apix;
done

for chr in {1..22};
do python /home/ashley/account/vcfs/blacks_imputed/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/riva/ -c ${chr} -d riva;
done

for chr in {1..22};
do python /home/ashley/account/vcfs/blacks_imputed/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/noac/ -c ${chr} -d noac;
done

for chr in {1..22};
do python /home/ashley/account/vcfs/blacks_imputed/vcf_to_dosage.py -i /home/ashley/account/vcfs/blacks_imputed/warf/ -c ${chr} -d warf;
done
