#Steps to run GWAS QC IBD - identify relatedness in the cohort

#Starting with imputed VCFs:

#Convert VCFs to PLINK format: produces bed/bim/fam and ped/map files
for chr in {1..22};
do plink --vcf chr${chr}_maf01_r28.vcf.gz --recode --make-bed --out chr${chr}_maf01_r28;
done

#combine all chrs into one file:
for i in {1..22}
do
echo chr${i}_maf01_r28 >> mergelist.txt
done

plink --file chr1_maf01_r28 --merge-list mergelist.txt --make-bed --out blacks_imputed_filtered_allchr

#make ped/map:
plink --bfile blacks_imputed_filtered_allchr --recode --out blacks_imputed_filtered_allchr

#Run Rscript to get id lists for each drug: get_drug_ids.R
#Run python to separate by drug: make_ped_for_drug.py
#creates five ped files with individuals grouped by drug taken (same map file is fine, notes snp info not people)


#make bed/bim/fam files for each drug:
plink --ped blacks_clop.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_clop
plink --ped blacks_noac.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_noac
plink --ped blacks_apix.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_apix
plink --ped blacks_riva.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_riva
plink --ped blacks_warf.ped --map blacks_imputed_filtered_allchr.map --make-bed --out blacks_warf


#make input for IBD plot for (all people/drugs): (more stringent threshold)
plink --bfile blacks_imputed_filtered_allchr --autosome --indep-pairwise 500 50 0.2 --out blacks_all_ibd
plink --bfile blacks_imputed_filtered_allchr --extract blacks_all_ibd.prune.in --genome --out blacks_all_ibd

#make input for IBD plot (ex with clop, do for all drugs):
plink --bfile blacks_clop --autosome --indep-pairwise 50 5 0.2 --out blacks_clop_ibd
plink --bfile blacks_clop --extract blacks_clop_ibd.prune.in --genome --out blacks_clop_ibd

#make input for IBD plot for all with pre-imputed files:
plink --bfile ACCOuNTBLACKSfinal_updated --autosome --indep-pairwise 50 5 0.2 --out blacks_preimputed_ibd
plink --bfile ACCOuNTBLACKSfinal_updated --extract blacks_preimputed_ibd.prune.in --genome --out blacks_preimputed_ibd

#Rscript to plot: ibd_plots.R


