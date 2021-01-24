#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#Read in fam file and add column names
fam<-fread("/home/ashley/account/vcfs/preimputation_plinkfiles/clop/pre_imputed_blacks_clop_hapmap_merged.fam") %>% select (V1,V2)
#add column with pop



colnames(fam)<-c("pop", "FID", "IID")

#Read in pcs (king output)
pcs <- fread("/home/ashley/account/vcfs/preimputation_plinkfiles/clop/blacks_clop_hapmap_merged_mds_pc.txt")

#Join fam and pcs to reorder pcs and add pop 
pcdf <- left_join(fam, pcs)

#Create vector with eigen values (they appear in output process as king runs pca, no file produced)
eval<-c(57.69, 18.20, 12.76, 2.39, 0.37, 0.37, 0.37, 0.37, 0.37, 0.37)

#Calcuate proportion variance explained by each PC:
eval<-round(eval/sum(eval),3)
eval<-cbind.data.frame(eval,c(1,2,3,4,5,6,7,8,9,10))
colnames(eval)<-c("percent_var", "PC")

#Make PCA plots:
pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_PCA/ALL_PCA_plots_king.pdf")

#Scree Plot
ggplot(data=eval, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcdf,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PC2 vs PC3")

dev.off() 
