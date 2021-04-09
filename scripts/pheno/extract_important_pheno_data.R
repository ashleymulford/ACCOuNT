library(data.table)
library(dplyr)

clop<-fread("account_clopidogrel_processed_matched_IDs_all.csv")
noac<-fread("account_noac_processed_matched_IDs_all.csv")
warf<-fread("account_warfarin_processed_matched_IDs_all.csv")

#save ids, pheno, and covariate columns only, remove unneeded columns so files are easier to work with
clop_small<-clop[, c(1:9,28,203)]
noac_small<-noac[, c(1:9,21,22,24,79,83)]
#idk which pheno for warf, add later
#warf_small<-warf[, c(1:9,22)]

fwrite(clop_small, "clop_pheno_with_ids.txt", sep = "\t", quote = F, na = NA)
fwrite(noac_small, "noac_pheno_with_ids.txt", sep = "\t", quote = F, na = NA)
#fwrite(warf_small, "warf_pheno_with_ids.txt", sep = "\t", quote = F, na = NA)


##single column pheno files are made in script that make covariates: see https://github.com/ashleymulford/ACCOuNT/blob/master/scripts/covariates/05_make_covariate_files.R



