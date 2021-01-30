#Make a covariate file for each drug, should contain 10 pcs, gender, age, dose (if variable), and creatinine clearance (not found in clop file)

#Import necessary libraries
library(data.table)
library(dplyr)

#import pcs for each drug
clop_pcs <- fread("/home/ashley/account/covariates/clop/blacks_clop_pc.txt")
clop_cov_pcs<-select(clop_pcs, 7:16)

apix_pcs <- fread("/home/ashley/account/covariates/apix/blacks_apix_pc.txt")
apix_cov_pcs<-select(apix_pcs, 7:16)

riva_pcs <- fread("/home/ashley/account/covariates/riva/blacks_riva_pc.txt")
riva_cov_pcs<-select(riva_pcs, 7:16)

warf_pcs <- fread("/home/ashley/account/covariates/warf/blacks_warf_pc.txt")
warf_cov_pcs<-select(warf_pcs, 7:16)


#import sample and pheno files for each drug:
clop_samples<-fread("/home/ashley/account/dosages/blacks/clop/samples_clop.txt")
clop_pheno<-fread("/home/ashley/account/phenos/clop/clop_pheno_with_ids.txt")

apix_samples<-fread("/home/ashley/account/dosages/blacks/apix/samples_apix.txt")
riva_samples<-fread("/home/ashley/account/dosages/blacks/riva/samples_riva.txt")
noac_pheno<-fread("/home/ashley/account/phenos/noac/noac_pheno_with_ids.txt")

warf_samples<-fread("/home/ashley/account/dosages/blacks/warf/samples_warf.txt")
warf_pheno<-fread("/home/ashley/account/phenos/warf/warf_pheno_with_ids.txt")



#pull out data from samples in pheno file
clop_samples_pheno<-left_join(clop_samples, clop_pheno)
apix_samples_pheno<-left_join(apix_samples, noac_pheno)
riva_samples_pheno<-left_join(riva_samples, noac_pheno)
warf_samples_pheno<-left_join(warf_samples, warf_pheno)


#extract sex, age, dose (not for clop, dose constant), and creatinine clearance (not found in clop file)


#combine files


#extract phenos: Clop PRU, NOAC Anti Factor X, Warf ? (do later)









