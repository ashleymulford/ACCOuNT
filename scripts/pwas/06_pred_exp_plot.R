#Import necessary libraries
library(data.table)
library(dplyr)
library(ggplot2)

#PrediXcan PWAS Results:

#Pheno files:
riva_pheno<-fread("/home/ashley/account/phenos/riva/riva_rn_pheno_no_ids.txt", header = F)
riva_samples<-fread("/home/ashley/account/dosages/blacks/riva/samples_riva.txt", header = F)

x_riva<-cbind(riva_samples, riva_pheno)
colnames(x_riva)<-c("FID", "IID", "pheno")
 
#Predicted Expression files:
y_riva_Pred_AFA<-fread("/home/ashley/account/pwas_results/blacks/riva/predicted_levels/blacks_riva_PCAIR_PAV_filtered_AFA_WG_baseline_rho0.1_zpval0.05.txt")


#Plot Predicted Expression for IL5RA, for AFA Model, ALL pop, and Ara-C drug:
#Data file:
xy_riva_Pred_AFA<-inner_join(x_riva, y_riva_Pred_AFA, by = c("FID", "IID"))

pdf("/home/ashley/LCL_chemotherapy/ALL/ALL_pwas_results/pred_exp_plots/ALL_arac_IL5RA.pdf")
ggplot(xy_riva_Pred_AFA, aes(x = xy_riva_Pred_AFA$SL004742_ENSG00000079557.5, y = xy_riva_Pred_AFA$pheno)) +
  geom_jitter(size = 0.75, color = "#ec328c") + 
  geom_density_2d(color = "#ffbf24") + 
  stat_smooth(method="lm", se = TRUE, fullrange = TRUE, color = "#8c1788") + 
  scale_x_continuous(name = "Predicted protein levels") + 
  scale_y_continuous(name = "Rivaroxaban Dose (rank normalized)") + 
  theme_bw() + 
  theme(text = element_text(size = 12), plot.title = element_text(hjust = 0.5)) +
  ggtitle("Rivaroxaban Baseline AFA AFM")
dev.off()
