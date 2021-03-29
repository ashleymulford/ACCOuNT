# Split VCF anno by chr for use with indvidual dosages when getting b37 rsids

for chr in {1..9};
do zgrep NC_00000${chr} GCF_000001405.25.gz > /home/ashley/account/liftover/rsid_anno/anno_chr${chr}_vcf.txt;
done

for chr in {10..22};
do zgrep NC_0000${chr} GCF_000001405.25.gz > /home/ashley/account/liftover/rsid_anno/anno_chr${chr}_vcf.txt;
done
