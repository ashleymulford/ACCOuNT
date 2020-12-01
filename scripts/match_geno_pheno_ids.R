library(data.table)
library(dplyr)
library(tibble)

sample_ids<-fread("samples_blacks.txt", header = F)
clop_data<-fread("account_clopidogrel_processed.csv")
noac_data<-fread("account_noac_processed.csv")
warf_data<-fread("account_warfarin_processed.csv")
unmatched_key<-fread("unmatched_geno_ids-CA.csv")

unmatched_clop<-filter(unmatched_key, unmatched_key$Project == "Clopidogrel")
unmatched_noac<-filter(unmatched_key, unmatched_key$Project == "NOAC")
unmatched_warf<-filter(unmatched_key, unmatched_key$Project == "Warfarin")

#Match geno and pheno IDs:

#Clop data:

clop_short_id_list <- c("NA")

for (id in clop_data$`Study ID (PharmGKB ID)`) {
  if (startsWith(id, "PA")) {
    clop_short_id <- substr(id, nchar(id) - 3, nchar(id))
    clop_short_id_mp <- paste("MP", clop_short_id, sep = "-")
    clop_short_id_list <- c(clop_short_id_list, clop_short_id_mp)
  }
}

clop_data<-add_column(clop_data, geno_ids = clop_short_id_list, .before = "Study ID (PharmGKB ID)")
clop_data_merged<-left_join(sample_ids, clop_data, by = c("V1" = "geno_ids"))
clop_data_merged_all<-full_join(sample_ids, clop_data, by = c("V1" = "geno_ids"))
fwrite(clop_data_merged_all, "account_clopidogrel_processed_matched_IDs_all.csv", na = "NA", quote = F)
#manually added 3 matches


#Noac Data:

noac_short_id_list <- c("NA")

for (id in noac_data$`Study ID (PharmGKB ID)`) {
  if (startsWith(id, "PA") | startsWith(id, "pa")) {
    noac_short_id <- substr(id, nchar(id) - 3, nchar(id))
    noac_short_id_mp <- paste("MP", noac_short_id, sep = "-")
    noac_short_id_list <- c(noac_short_id_list, noac_short_id_mp)
  }
}

noac_data<-add_column(noac_data, geno_ids = noac_short_id_list, .before = "Study ID (PharmGKB ID)")
noac_data_merged<-left_join(sample_ids, noac_data, by = c("V1" = "geno_ids"))
noac_data_merged_all<-full_join(sample_ids, noac_data, by = c("V1" = "geno_ids"))
fwrite(noac_data_merged_all, "account_noac_processed_matched_IDs_all.csv", na = "NA", quote = F)
#manually added 11 matches



#Warf Data:

warf_short_id_list <- c("NA")

for (id in warf_data$`Study ID (PharmGKB ID)`) {
  if (startsWith(id, "PA")) {
    warf_short_id <- substr(id, nchar(id) - 3, nchar(id))
    warf_short_id_mp <- paste("MP", warf_short_id, sep = "-")
    warf_short_id_list <- c(warf_short_id_list, warf_short_id_mp)
  }
}

warf_data<-add_column(warf_data, geno_ids = warf_short_id_list, .before = "Study ID (PharmGKB ID)")
warf_data_merged<-left_join(sample_ids, warf_data, by = c("V1" = "geno_ids"))
warf_data_merged_all<-full_join(sample_ids, warf_data, by = c("V1" = "geno_ids"))
fwrite(warf_data_merged_all, "account_warfarin_processed_matched_IDs_all.csv", na = "NA", quote = F)
#manually added 2 matches



#Output files with merged IDs:
#(ordered same as geno file IDs, NAs for IDs with no pheno info)

fwrite(clop_data_merged, "account_clopidogrel_processed_matched_IDs.txt", sep = "\t", na = "NA", quote = F)
fwrite(noac_data_merged, "account_noac_processed_matched_IDs.txt", sep = "\t", na = "NA", quote = F)
fwrite(warf_data_merged, "account_warfarin_processed_matched_IDs.txt", sep = "\t", na = "NA", quote = F)



#Sample counts:

clop_no_na_test<-filter(clop_data_merged, clop_data_merged$`Study ID (PharmGKB ID)` != "NA")
#Clop: 163 orig vs 143 merged (140 plus 3 added manually)

noac_no_na_test<-filter(noac_data_merged, noac_data_merged$`Study ID (PharmGKB ID)` != "NA")
#Noac: 259 orig vs 240 merged (229 plus 11 added manually)

warf_no_na_test<-filter(warf_data_merged, warf_data_merged$`Study ID (PharmGKB ID)` != "NA")
#Warf: 324 orig vs 296 merged (294 plus 2 added manually)

#Total 722 sample ids with genos, 746 people with phenos, vs 679 when merged.





#Determining geno IDs without matches:

all_phenos_ids1<-clop_data_merged[ , c(1,2,3)]
all_phenos_ids2<-noac_data_merged[ , c(1,2,3)]
all_phenos_ids3<-warf_data_merged[ , c(1,2,3)]

all_pheno_ids<-full_join(all_phenos_ids1, all_phenos_ids2, by = c("V1" = "V1", "V2" = "V2"))
all_pheno_ids<-full_join(all_pheno_ids, all_phenos_ids3, by = c("V1" = "V1", "V2" = "V2"))

all_nas<-all_pheno_ids[is.na(all_pheno_ids$`Study ID (PharmGKB ID).x`), ]
all_nas<-all_nas[is.na(all_nas$`Study ID (PharmGKB ID).y`), ]
all_nas<-all_nas[is.na(all_nas$`Study ID (PharmGKB ID)`), ]


fwrite(all_nas, "unmatched_geno_ids.csv")

#59 geno IDs have no pheno match:
  #types: MP-##, MP-##-P, MP-###-P, MP-####-2 (some duplicates), MP-#### (happen to not match)

