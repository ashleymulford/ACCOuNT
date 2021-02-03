#Make a covariate file for each drug, should contain 10 pcs, gender, age, dose (if variable), and creatinine clearance (not found in clop file)
#do warf later, don't have pheno info yet

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
apix_covs_pheno<-left_join(apix_cov_pcs, noac_pheno, by = c("FID" = "V1", "IID" = "V2"))
riva_covs_pheno<-left_join(riva_cov_pcs, noac_pheno, by = c("FID" = "V1", "IID" = "V2"))
#make pheno files
apix_pheno_no_ids<-select(apix_covs_pheno, 23)
riva_pheno_no_ids<-select(riva_covs_pheno, 23)
#replace MD with NA and remove < characters in nano after outputting
fwrite(apix_pheno_no_ids, "/home/ashley/account/phenos/noac/apix_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
fwrite(riva_pheno_no_ids, "/home/ashley/account/phenos/noac/riva_pheno_no_ids.txt", sep = "\t", col.names = F, quote = F)
#make covariates file
apix_covs<-select(apix_covs_pheno, 3:12,16,21,22)
riva_covs<-select(riva_covs_pheno, 3:12,16,21,22)
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
#output file
fwrite(apix_covs_all, "/home/ashley/account/covariates/apix/apix_covariates.txt", sep = "\t", col.names = F, quote = F)
fwrite(riva_covs_all, "/home/ashley/account/covariates/riva/riva_covariates.txt", sep = "\t", col.names = F, quote = F)








