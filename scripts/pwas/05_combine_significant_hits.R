#Import necessasry libraries
library(data.table)
library(dplyr)
library(tibble)

#Create function to paste in tissue name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list of models for file input
model_list <- c("ALL", "AFA", "CAU", "CHN", "HIS")
drug_list <- c("clop", "apix", "riva")


#Make a data frame with all results from each model per drug
  #Read in file
  #Add column containing model name
  #Compile significant subsets into single data frame
for(drug in drug_list){
  for(model in model_list){
    output <- fread("/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/assoc_gemma_output/" %&% drug %&% "_PCAIR_PAV_filtered_" %&% model %&% "_baseline_rho0.1_zpval0.05.assoc.txt")
    output <- add_column(output, model = model, .before = "chr")
    output <- add_column(output, drug = drug, .before = "chr")
    if(exists("all_assoc")){
      all_assoc<-merge(x = all_assoc, y = output, all = TRUE)
    }
    else{
      all_assoc<-output
    }
  }
  
  #subset at different thresholds
  all_sig<-subset(all_assoc, pvalues_adjusted_BH < .75)
  most_sig<-subset(all_assoc, pvalues_adjusted_BH < .1)
  BF_sig<-subset(all_assoc, pvalues_adjusted_bonferroni < .05)
   
  #Output data frames into directory
  fwrite(all_assoc, "/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/adj_assoc_output/" %&% drug %&% "_allassoc_PCAIR_PAV_filtered_baseline_rho0.1_zpval0.05.adj.txt", na = "NA", quote = F, sep = "\t", col.names = T) 
  fwrite(all_sig, "/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/adj_assoc_output/" %&% drug %&% "_sig_PCAIR_PAV_filtered_baseline_rho0.1_zpval0.05.adj.txt", na = "NA", quote = F, sep = "\t", col.names = T) 
  fwrite(most_sig, "/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/adj_assoc_output/" %&% drug %&% "_most_sig_PCAIR_PAV_filtered_baseline_rho0.1_zpval0.05.adj.txt", na = "NA", quote = F, sep = "\t", col.names = T) 
  fwrite(BF_sig, "/home/ashley/account/pwas_results/blacks/" %&% drug %&% "/adj_assoc_output/" %&% drug %&% "_BFsig_PCAIR_PAV_filtered_baseline_rho0.1_zpval0.05.adj.txt", na = "NA", quote = F, sep = "\t", col.names = T) 
}




