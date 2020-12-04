library(data.table)
library(dplyr)

all_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_all_ibd.genome")
clop_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_clop_ibd.genome")
noac_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_noac_ibd.genome")
apix_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_apix_ibd.genome")
riva_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_riva_ibd.genome")
warf_ibd<-fread("/home/ashley/account/gwas_qc/blacks/blacks_warf_ibd.genome")

#All Drugs IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/all_drugs_ibd.pdf")
ggplot(data=all_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks All Drugs IBD")
dev.off()


#Clop IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/clop_ibd.pdf")
ggplot(data=clop_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks Clopidogrel IBD")
dev.off()

#NOAC IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/noac_ibd.pdf")
ggplot(data=noac_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks NOAC IBD")
dev.off()

#Apix IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/apix_ibd.pdf")
ggplot(data=apix_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks Apixaban IBD")
dev.off()

#Riva IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/riva_ibd.pdf")
ggplot(data=riva_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks Rivaroxaban IBD")
dev.off()

#Warf IBD plot
pdf("/home/ashley/account/gwas_qc/blacks/warf_ibd.pdf")
ggplot(data=warf_ibd, aes(x=Z0, y=Z1)) +
    geom_point(alpha=1/4) +
    theme_bw() +
    coord_cartesian(xlim =c(0, 1), ylim = c(0, 1)) +
    theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
    ggtitle("Blacks Warfarin IBD")
dev.off()
