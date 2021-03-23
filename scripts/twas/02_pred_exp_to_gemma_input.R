#Modified version of angela's script
#Converting predicted expression to GEMMA input

library(data.table)

"%&%" = function(a,b) paste(a,b,sep="")

model_list <- c("AFA", "ALL")
drug_list <- c("clop", "apix", "riva", "noac")

for(model in model_list){
  for(drug in drug_list){
    pred_exp <- fread("/home/ashley/account/twas_results/" %&% drug %&% "/predicted_levels/blacks_" %&% drug %&% "_" %&% model %&% "_filtered_predicted_transcript.txt", header = F) #path to PrediXcan-produced _predicted_expression.txt
    pred_exp$V1 <- NULL
    pred_exp$V2 <- NULL
    pred_exp <- transpose(pred_exp)
    gene_list <- as.data.frame(pred_exp$V1)
    colnames(gene_list) <- "V0"
    pred_exp <- cbind(gene_list, pred_exp)
    pred_exp$V0 <- NA
    pred_exp$V1 <- NA
    colnames(gene_list) <- "V"
    pred_exp <- cbind(gene_list, pred_exp)
    fwrite(pred_exp, "/home/ashley/account/twas_results/" %&% drug %&% "/assoc_gemma_input/blacks_" %&% drug %&% "_" %&% model %&% "_filtered_predicted_transcript_gemma.txt", na = "NA", quote = F, sep = "\t", col.names = F) #path to GEMMA input/pseudo-genotype
  }
}
