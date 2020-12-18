#Principal Component Analysis with King:
#Use pre-imputed plinkfiles, get PCs for each drug group

#Example with clop:
#/home/ashley/king --pca -b pre_imputed_blacks_clop.bed

#Note: currently having issue with riva and warf - getting 0.00 for eigen values and pcs
#clop and apix output fine


#make covariate file and plots with R:

#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)
