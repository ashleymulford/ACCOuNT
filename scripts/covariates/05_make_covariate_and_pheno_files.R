#Make a covariate and pheno files for each drug, should contain 10 pcs, gender, age, dose (if variable), and creatinine clearance (not found in clop file)
#do warf later, don't have pheno info yet
#add time to blood draw as cov for noac drugs too

#Import necessary libraries
library(data.table)
library(dplyr)
library(tibble)

#import pcs for each drug
clop_pcs <- fread("/home/ashley/account/covariates/clop/blacks_clop_pc.txt")
clop_cov_pcs<-select(clop_pcs, 1,2,7:16)

apix_pcs <- fread("/home/ashley/account/covariates/apix/blacks_apix_pc.txt")
apix_cov_pcs<-select(apix_pcs, 1,2,7:16)

riva_pcs <- fread("/home/ashley/account/covariates/riva/blacks_riva_pc.txt")
riva_cov_pcs<-select(riva_pcs, 1,2,7:16)

noac_pcs <- fread("/home/ashley/account/covariates/noac/blacks_noac_pc.txt")
noac_cov_pcs<-select(noac_pcs, 1,2,7:16)


#import pheno files for each drug:
clop_pheno<-fread("/home/ashley/account/phenos/clop/clop_pheno_with_ids.txt")
noac_pheno<-fread("/home/ashley/account/phenos/noac/noac_pheno_with_ids.txt")


#Clop covariates: 10 pcs, age, gender
#join files by ids
clop_covs_pheno<-left_join(clop_cov_pcs, clop_pheno, by = c("FID" = "V1", "IID" = "V2"))
#make pheno file
clop_pheno_no_ids<-select(clop_covs_pheno, 21)
#replace MD with NA in nano after outputting
fwrite(clop_pheno_no_ids, "/home/ashley/account/phenos/clop/clop_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
#make covariates file
clop_covs<-select(clop_covs_pheno, 3:12,16)
#remake gender column with F=1 and M=0:
gender<-c()
for (g in clop_covs_pheno$Gender){
  if (g == "F") {
    gender<-c(gender, 1)
  }
  if (g == "M") {
    gender<-c(gender, 0)
  }
}
#add gender column to covs
clop_covs_all<-add_column(clop_covs, gender = gender)
#output file
fwrite(clop_covs_all, "/home/ashley/account/covariates/clop/clop_covariates.txt", sep = "\t", col.names = F, quote = F)


#NOAC covariates: 10 pcs, age, gender, dosage, creatinine clearance

#join files by ids
noac_covs_pheno<-left_join(noac_cov_pcs, noac_pheno, by = c("FID" = "V1", "IID" = "V2"))
#make pheno file
noac_pheno_no_ids<-select(noac_covs_pheno, 24)
#replace MD with NA in nano after outputting
fwrite(noac_pheno_no_ids, "/home/ashley/account/phenos/noac/noac_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
#make covariates file
noac_covs<-select(noac_covs_pheno, 3:12,16,21:23)
#remake gender column with F=1 and M=0:
gender_noac<-c()
for (g in noac_covs_pheno$Gender){
  if (g == "F") {
    gender_noac<-c(gender_noac, 1)
  }
  if (g == "M") {
    gender_noac<-c(gender_noac, 0)
  }
}
#add gender column to covs
noac_covs_all<-add_column(noac_covs, gender = gender_noac)
#add binary cov to distinguish between apix and riva groups:
#apix=0 and riva=1
drug_noac<-c()
for (d in noac_covs_pheno$'Which NOAC Drug Used'){
  if (d == "rivaroxaban") {
    drug_noac<-c(drug_noac, 1)
  }
  if (d == "apixaban") {
    drug_noac<-c(drug_noac, 0)
  }
}
noac_covs_all<-add_column(noac_covs_all, drug_group = drug_noac)
#output file
fwrite(noac_covs_all, "/home/ashley/account/covariates/noac/noac_covariates.txt", sep = "\t", col.names = F, quote = F)

#Apixaban and Rivaroxaban separately:

#join files by ids
apix_covs_pheno<-left_join(apix_cov_pcs, noac_pheno, by = c("FID" = "V1", "IID" = "V2"))
riva_covs_pheno<-left_join(riva_cov_pcs, noac_pheno, by = c("FID" = "V1", "IID" = "V2"))
#make pheno files
apix_pheno_no_ids<-select(apix_covs_pheno, 24)
riva_pheno_no_ids<-select(riva_covs_pheno, 24)
#replace MD with NA and remove < characters in nano after outputting
fwrite(apix_pheno_no_ids, "/home/ashley/account/phenos/apix/apix_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
fwrite(riva_pheno_no_ids, "/home/ashley/account/phenos/riva/riva_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
#make covariates file
apix_covs<-select(apix_covs_pheno, 3:12,16,21:23)
riva_covs<-select(riva_covs_pheno, 3:12,16,21:23)
#remake gender column with F=1 and M=0:
gender_apix<-c()
for (g in apix_covs_pheno$Gender){
  if (g == "F") {
    gender_apix<-c(gender_apix, 1)
  }
  if (g == "M") {
    gender_apix<-c(gender_apix, 0)
  }
}
gender_riva<-c()
for (g in riva_covs_pheno$Gender){
  if (g == "F") {
    gender_riva<-c(gender_riva, 1)
  }
  if (g == "M") {
    gender_riva<-c(gender_riva, 0)
  }
}
#add gender column to covs
apix_covs_all<-add_column(apix_covs, gender = gender_apix)
riva_covs_all<-add_column(riva_covs, gender = gender_riva)
#replace MD with NA in nano after outputting
#output file
fwrite(apix_covs_all, "/home/ashley/account/covariates/apix/apix_covariates.txt", sep = "\t", col.names = F, quote = F)
fwrite(riva_covs_all, "/home/ashley/account/covariates/riva/riva_covariates.txt", sep = "\t", col.names = F, quote = F)


