library(dplyr)
library(data.table)
library(tibble)

#chrs <- c(1:22)
#drugs <- c("apix", "clop", "riva", "noac")

chrs <- c(1)
drugs <- c("apix")

"%&%" = function(a,b) paste(a,b,sep="")

for (drug in drugs) {
  for (chr in chrs) {
    #extract pos and rsid columns from anno file
    anno <- fread("/home/ashley/account/liftover/rsid_anno/anno_chr" %&% chr %&% "_vcf.txt.gz", header = F) %>% select (V2,V3)
    print(head(anno))
    #remove chr file
    dosage <- fread("/home/ashley/account/liftover/lifted_dosages_b37/" %&% drug %&% "/b37_dosages/" %&% drug %&% "_chr" %&% chr %&% "_b37.dosage.txt.gz", header = F) %>% select (-V1)
    print(head(dosage))
    dosage_rs <- left_join(anno, dosage, by = c("V2" = "V2"))
    c <- c(chr, rep(length(dosage_rs$V2)))
    dosage_rs_chr <- add_column(dosage_rs, c=c, .before("V2"))
    print(head(dosage_rs_chr))
    fwrite(dosage_rs_chr, "/home/ashley/account/liftover/lifted_dosages_b37/" %&% drug %&% "/b37_dosages/" %&% drug %&% "_chr" %&% chr %&% "_rsid_b37.dosage.txt", col.names = F, sep = "\t", quote = F)
  }
}
