library(data.table)
library(dplyr)

clop<-fread("clop_pheno_with_ids.txt")
noac<-fread("noac_pheno_with_ids.txt")
warf<-fread("account_warfarin_processed_matched_IDs_all.csv")

clop_ids<-filter(clop, startsWith(clop$`Study ID (PharmGKB ID)`, "PA"))
noac_ids<-filter(noac, startsWith(noac$`Study ID (PharmGKB ID)`, "PA"))
apix<-filter(noac_ids, noac_ids$`Which NOAC Drug Used` == "apixaban")
riva<-filter(noac_ids, noac_ids$`Which NOAC Drug Used` == "rivaroxaban")
warf_ids<-filter(warf, startsWith(warf$`Study ID (PharmGKB ID)`, "PA"))


