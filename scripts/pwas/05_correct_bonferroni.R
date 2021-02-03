#Multiple Testing Correction for Association Results with Bonferroni and BH FDR

#Import necessary libraries
library(data.table)
library(dplyr)
library(tibble)

#Create function to paste in drug name
"%&%" = function(a,b) paste(a,b,sep="")

#Create list for file input variants
drug_list <- c("clop', "apix", "riva")
model_list <- c("ALL", "AFA", "CAU", "CHN", "HIS")

#Make a data frame from combined PrediXcan results that includes chr #, bp, and BH and Bonferroni adj p-value
  #Read in output files
  #Create vector of p-values
  #Adjust p-values with BH and bonferroni methods
  #Add new columns with adjusted p-values to data frame
  #Join PrediXcan data frame with bp_chrome data frame to add columns with chr # and bp
  #Remove old/inaccurate chr and bp columns
  #Ouput data frame into directory
for (drug in drug_list) {
  for (model in model_list) {
    assoc_file <- fread("/home/ashley/LCL_chemotherapy/YRI/YRI_pwas_results/association_output/YRI_" %&% drug %&% "_PCAIR_PAV_filtered_" %&% model %&% "_baseline_rho0.1_zpval0.05.assoc.txt")
    pvalues <- select(assoc_file, contains("p_wald"))
    pvalues <- as.vector(unlist(pvalues))
    pvalues_adjusted_BH <- p.adjust(pvalues, method = "BH")
    pvalues_adjusted_BF <- p.adjust(pvalues, method = "bonferroni")
    assoc_file <- add_column(assoc_file,  pvalues_adjusted_BH = pvalues_adjusted_BH , .before = "p_lrt")
    assoc_file <- add_column(assoc_file,  pvalues_adjusted_bonferroni = pvalues_adjusted_BF, .before = "p_lrt")
    fwrite(assoc_file, "/home/ashley/LCL_chemotherapy/YRI/YRI_pwas_results/adj_assoc_output/YRI_" %&% drug %&% "_PCAIR_PAV_filtered_" %&% model %&% "_baseline_rho0.1_zpval0.05.adj.txt")
  }
}
