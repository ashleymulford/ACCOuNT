library(data.table)
library(dplyr)

clop<-fread("/home/ashley/account/phenos/clop_pheno_with_ids.txt")
noac<-fread("/home/ashley/account/phenos/noac_pheno_with_ids.txt")
warf<-fread("/home/ashley/account/phenos/account_warfarin_processed_matched_IDs_all.csv")

clop_ids<-filter(clop, startsWith(clop$`Study ID (PharmGKB ID)`, "PA"))
apix<-filter(noac, noac$`Which NOAC Drug Used` == "apixaban")
riva<-filter(noac, noac$`Which NOAC Drug Used` == "rivaroxaban")
warf_ids<-filter(warf, startsWith(warf$`Study ID (PharmGKB ID)`, "PA"))

clop_ids<-clop_ids[, c(1:2)]
apix<-apix[, c(1:2)]
riva<-riva[, c(1:2)]
warf_ids<-warf_ids[, c(1:2)]

ped<-fread("/home/ashley/account/gwas_qc/blacks/blacks_imputed_filtered_allchr.ped", header = F)

clop_ped<-left_join(clop_ids, ped, by = c("V1" = "V1", "V2" = "V2"))
apix_ped<-left_join(apix, ped, by = c("V1" = "V1", "V2" = "V2"))
riva_ped<-left_join(riva, ped, by = c("V1" = "V1", "V2" = "V2"))
warf_ped<-left_join(warf_ids, ped, by = c("V1" = "V1", "V2" = "V2"))
      
fwrite(clop_ped, "/home/ashley/account/gwas_qc/blacks/blacks_clop.ped", sep = "\t", quote = F)
fwrite(apix_ped, "/home/ashley/account/gwas_qc/blacks/blacks_apix.ped", sep = "\t", quote = F)
fwrite(riva_ped, "/home/ashley/account/gwas_qc/blacks/blacks_riva.ped", sep = "\t", quote = F)
fwrite(warf_ped, "/home/ashley/account/gwas_qc/blacks/blacks_warf.ped", sep = "\t", quote = F)


