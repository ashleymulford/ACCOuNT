library(dplyr)
library(data.table)


anno <- fread("")

chrs <- c(1:22)
drugs <- c("apix", "clop", "riva", "noac")

for (drug in drug) {
  for (chr in chrs) {
    dosage <- fread("")
    dosage_rsids <- left_join(anno, dosage, by = c("" = "", "" = ""))
  }
}
