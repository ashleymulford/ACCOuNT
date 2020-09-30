#Do for both pops:

#Convert vcf to ped/map, bed/bim/fam

for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --out chr${chr}_maf01_r28;
plink --file chr${chr}_maf01_r28 --make-bed --out chr${chr}_maf01_r28;
done

#Samples file for predixcan:
awk '{print $1, $2}' chr1_maf01_r28.fam > samples_blacks.txt


#Starting dosage files for predixcan (chr, varid, pos, a1, a2 - need to add maf & id1-idn):
## col 6 has A1 (ref) & col 5 has A2 (alt/minor)
for chr in {1..22};
do awk '{print $1, $2, $4, $6, $5}' chr${chr}_maf01_r28.bim > chr${chr}_dosage.txt;
done


#get maf from vcfs
#get dosages (counts) from ped file 

