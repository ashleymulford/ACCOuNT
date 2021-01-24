#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(tibble)

#Read in pcs from pca
pcs_pca <- fread("/home/ashley/account/covariates/clop/blacks_clop_pca_pc.txt")

#Read in pcs from mds
pcs_mds <- fread("/home/ashley/account/covariates/clop/blacks_clop_mds_pc.txt")

#add pop
pop<-c(rep("AFA", 143))
pcs_pca <- add_column(pcs_pca, pop=pop, .before="FID")
pcs_mds <- add_column(pcs_mds, pop=pop, .before="FID")


#Create vector with eigen values from pca
eval_pca<-c(1390.26, 1259.46, 1016.23, 1014.50, 1009.03, 1006.71, 1005.34, 1003.17, 1001.11, 999.49)

#Calcuate proportion variance explained by each PC:
eval_pca<-round(eval_pca/sum(eval_pca),3)
eval_pca<-cbind.data.frame(eval_pca,c(1,2,3,4,5,6,7,8,9,10))
colnames(eval_pca)<-c("percent_var", "PC")

#Create vector with eigen values from mds
eval_mds<-c(0.29, 0.24, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15)

#Calcuate proportion variance explained by each PC:
eval_mds<-round(eval_mds/sum(eval_mds),3)
eval_mds<-cbind.data.frame(eval_mds,c(1,2,3,4,5,6,7,8,9,10))
colnames(eval_mds)<-c("percent_var", "PC")



#Make PC plots:
pdf("/home/ashley/account/covariates/pca_plots/clop_pca_vs_mds_plots.pdf")

##PCA Data
#Scree Plot
ggplot(data=eval_pca, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("PCA: Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcs_pca,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PCA: PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcs_pca,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PCA: PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcs_pca,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("PCA: PC2 vs PC3")



##MDS Data
#Scree Plot
ggplot(data=eval_mds, aes(x=PC, y=percent_var)) + geom_point() + geom_line() + scale_x_continuous(breaks = 1:10) + ggtitle("MDS: Proportion of variance explained")

#PCA Plot 1 (PC1 vs PC2)
ggplot() + geom_point(data=pcs_mds,aes(x=PC1,y=PC2,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("MDS: PC1 vs PC2")

#PCA Plot 2 (PC1 vs PC3)
ggplot() + geom_point(data=pcs_mds,aes(x=PC1,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("MDS: PC1 vs PC3")

#PCA Plot 1 (PC2 vs PC3)
ggplot() + geom_point(data=pcs_mds,aes(x=PC2,y=PC3,col=pop,shape=pop)) + theme_bw() + scale_colour_brewer(palette="Set1") + ggtitle("MDS: PC2 vs PC3")

dev.off() 
