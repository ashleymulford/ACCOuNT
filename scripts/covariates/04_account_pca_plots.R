#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(tibble)

#Read in fam file and add column names
fam<-fread("/home/ashley/account/vcfs/preimputation_plinkfiles/clop/pre_imputed_blacks_clop_hapmap_excluded_snps_merged.fam") %>% select (V1,V2)
colnames(fam)<-c("FID", "IID")
#add column with pop
pop<-c(rep("CEU", 111), rep("AFA", 141), rep("ASN", 170), rep("YRI", 110))
fam_with_pop<-add_column(fam, pop=pop, .before = "FID")

#Read in pcs (king output)
pcs <- fread("/home/ashley/account/vcfs/preimputation_plinkfiles/clop/blacks_clop_hapmap_merged_pc.txt")

#Join fam and pcs to reorder pcs and add pop 
pcdf <- left_join(fam_with_pop, pcs)

#Create vector with eigen values (they appear in output process as king runs pca, no file produced)
eval<-c(3569.71, 2389.00, 646.99, 590.33, 494.22, 488.86, 487.72, 486.80, 485.43, 485.22)

#Calcuate proportion variance explained by each PC:
eval<-round(eval/sum(eval),3)
eval<-cbind.data.frame(eval,c(1,2,3,4,5,6,7,8,9,10))
colnames(eval)<-c("percent_var", "PC")

#Make PCA plots:
pdf("/home/ashley/account/covariates/pca_plots/clop_hapmap_pca_plots.pdf")

#Scree Plot
ggplot(data=eval, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC2 vs PC3")

dev.off() 


