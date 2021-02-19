#read in pheno files, MD already replaced with NAs and < already removed in nano after running 05 Rscript

#import necessary libraries
library(data.table)

#get source functions
source("ztransform.R")
source("rntransform.R")

#read in pheno files
clop_pheno<-fread("/home/ashley/account/phenos/clop/clop_pheno_no_ids.txt", header = F)
apix_pheno<-fread("/home/ashley/account/phenos/apix/apix_pheno_no_ids.txt", header = F)
riva_pheno<-fread("/home/ashley/account/phenos/riva/riva_pheno_no_ids.txt", header = F)

#rank-normalize phenos:
clop_pheno$V1<-rntransform(clop_pheno$V1)
apix_pheno$V1<-rntransform(apix_pheno$V1)
riva_pheno$V1<-rntransform(riva_pheno$V1)

#output rank-normalized phenos:
fwrite(clop_pheno, "/home/ashley/account/phenos/clop/clop_rn_pheno_no_ids.txt", col.names = F, sep = "\t", quote = F, na = NA)
fwrite(apix_pheno, "/home/ashley/account/phenos/apix/apix_rn_pheno_no_ids.txt", col.names = F, sep = "\t", quote = F, na = NA)
fwrite(riva_pheno, "/home/ashley/account/phenos/riva/riva_rn_pheno_no_ids.txt", col.names = F, sep = "\t", quote = F, na = NA)




