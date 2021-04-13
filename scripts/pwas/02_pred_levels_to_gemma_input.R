#Modified version of angela's script

#Converting predicted expression to GEMMA input
#change variables and path based on what is being run

library(data.table)
"%&%" = function(a,b) paste(a,b,sep="")
model_list <- c("AFA", "CAU", "HIS", "CHN", "ALL")
drug_list <- c("clop", "apix", "riva", "warf")

for(model in model_list){
  for(drug in drug_list){
    pred_exp <- fread("/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/predicted_levels/blacks_" %&% drug %&% "_PCAIR_PAV_filtered_" %&% model %&% "_WG_baseline_rho0.1_zpval0.05.txt", header = F) #path to PrediXcan-produced _predicted_expression.txt
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
    fwrite(pred_exp, "/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/assoc_gemma_input/blacks_" %&% drug %&% "_PCAIR_PAV_filtered_" %&% model %&% "_baseline_rho0.1_zpval0.05_gemma.txt", na = "NA", quote = F, sep = "\t", col.names = F) #path to GEMMA input/pseudo-genotype
  }
}
