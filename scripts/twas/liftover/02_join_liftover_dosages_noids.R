#make new b37 dosage files from lifted files and b38 dosage files

#Import necessary libraries
library(data.table)
library(dplyr)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

drugs <- c("apix", "clop", "riva", "noac")
chrs <- c(1:22)

for (drug in drugs) {
  for (chr in chrs) {
    lifted<-fread("/home/ashley/account/liftover/lifted_dosages_b37/" %&% drug %&% "/lifted_files/" %&% drug %&% "_chr" %&% chr %&% "_lifted.txt", header = F)
    dosage<-fread("/home/ashley/account/dosages/blacks/" %&% drug %&% "/pred_dosages/" %&% drug %&% "_chr" %&% chr %&% ".dosage.txt", header = F)

    #Join by snp_id, keep only lifted snps
    dosages_37<-left_join(lifted, dosage, by = c("V4" = "V2", "V1" = "V1"))

    #remove uneeded pos columns
    dosages_37$V3.x<-NULL
    dosages_37$V3.y<-NULL

    #remove build 38 id column (need ids with pos from build 38)
    dosages_37$V4<-NULL

    #dosage file has no ids, will add with python 
    fwrite(dosages_37, "/home/ashley/account/liftover/lifted_dosages_b37/" %&% drug %&% "/b37_dosages/" %&% drug %&% "_chr" %&% chr %&% "_b37.dosage.txt", sep = "\t", col.names = F, quote = F)
  }
}

#still need to add id column to all new b37 dosages, add as chr:pos in next step
