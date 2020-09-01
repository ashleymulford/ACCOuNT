library("data.table")

#Create function to paste
"%&%" = function(a,b) paste(a,b,sep="")

for (chr in 1:22) {
  map <- fread("account_blacks_chr" %&% chr %&% ".map")
  k<-paste("chr", map$V1[1], sep = "")
  lng<-length(map$V1)
  col<-rep(k, lng)
  map$V1<-col
  fwrite(map, "account_blacks_chr" %&% chr %&% ".map", sep = "\t", quote = F, col.names = F)
}
