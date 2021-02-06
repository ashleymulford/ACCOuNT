#Import necessary libraries
library(data.table)
library(dplyr)
library(qqman)
library(colorspace)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create color vector
colors<-sequential_hcl(4,"SunsetDark")

#Create list of drugs for file input
drug_list <- c("clop", "apix", "riva")
model_list <- c("AFA", "ALL")

#Make QQ and Manhattan plots using loop
for(drug in drug_list){
  for(model in model_list){
    pwas_output <- fread("/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/assoc_gemma_output/" %&% drug %&% "_rn_PCAIR_PAV_filtered_" %&% model %&% "_baseline_rho0.1_zpval0.05.assoc.txt")
    anno <- fread("/home/ryan/topmed/proteome/proteome_with_multigene_expression/annotation_all_aptamers_ENSG.txt")
    pwas_out_anno<-left_join(pwas_output, anno, by = c("rs" = "gene_id"))
    pwas_out_anno$chr.y<-as.numeric(pwas_out_anno$chr.y)
    
    png(filename = "pwas_" %&% drug %&% "_" %&% model %&% ".qqplot.png", res=100)
    qq(pwas_out_anno$p_wald)
    dev.off()

    png(filename = "pwas_" %&% drug %&% "_" %&% model %&% ".manplot.png", res=100)
    manhattan(pwas_out_anno, chr = "chr.y", bp = "start", p = "p_wald", col = colors)
    dev.off()
  }
}
