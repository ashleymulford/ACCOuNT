library(vcfR)

#Create function to paste
"%&%" = function(a,b) paste(a,b,sep="")

chr<-22
vcf <- read.vcfR("vcfs/account_blacks_chr" %&% chr %&% ".vcf")
vcf@fix[chr]
main<-vcf@fix

for (chr in 1:22) {
  vcf <- read.vcfR("account_blacks_chr" %&% chr %&% ".vcf")
  k<-paste("chr", vcf$V1[1], sep = "")
  lng<-length(vcf$V1)
  col<-rep(k, lng)
  vcf$V1<-col
  write.vcf(vcf, "test_account_blacks_chr" %&% chr %&% ".vcf", sep = "\t", quote = F, col.names = F)
}
