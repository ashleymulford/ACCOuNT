library(data.table)
library(dplyr)

clop<-fread("/home/ashley/account/phenos/clop_pheno_with_ids.txt")
noac<-fread("/home/ashley/account/phenos/noac_pheno_with_ids.txt")
warf<-fread("/home/ashley/account/phenos/account_warfarin_processed_matched_IDs_all.csv")

clop_ids<-filter(clop, startsWith(clop$`Study ID (PharmGKB ID)`, "PA"))
noac_ids<-filter(noac, startsWith(noac$`Study ID (PharmGKB ID)`, "PA") | startsWith(noac$`Study ID (PharmGKB ID)`, "pa"))
noac_ids<-filter(noac_ids, noac_ids$`Which NOAC Drug Used` != "dabigatran")
apix<-filter(noac, noac$`Which NOAC Drug Used` == "apixaban")
riva<-filter(noac, noac$`Which NOAC Drug Used` == "rivaroxaban")
warf_ids<-filter(warf, startsWith(warf$`Study ID (PharmGKB ID)`, "PA"))

clop_ids<-clop_ids[, c(1:2)]
noac_ids<-noac_ids[, c(1:2)]
apix<-apix[, c(1:2)]
riva<-riva[, c(1:2)]
warf_ids<-warf_ids[, c(1:2)]

fwrite(clop_ids, "/home/ashley/account/gwas_qc/blacks/clop_ids.txt", sep = "\t", quote = F, col.names = F)
fwrite(noac_ids, "/home/ashley/account/gwas_qc/blacks/noac_ids.txt", sep = "\t", quote = F, col.names = F)
fwrite(apix, "/home/ashley/account/gwas_qc/blacks/apix_ids.txt", sep = "\t", quote = F, col.names = F)
fwrite(riva, "/home/ashley/account/gwas_qc/blacks/riva_ids.txt", sep = "\t", quote = F, col.names = F)
fwrite(warf_ids, "/home/ashley/account/gwas_qc/blacks/warf_ids.txt", sep = "\t", quote = F, col.names = F)
