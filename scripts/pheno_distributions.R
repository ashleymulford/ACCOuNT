#Three NOAC Drugs:
#apixaban, dabigatran, rivaroxiban
#dabigatran factor X data is all missing

#Determine distribution of Anti-factor Xa activity (ng/mL) for each drug

library(data.table)
library(dplyr)

noac_data <- fread("/home/ashley/account/phenos/account_noac_processed.csv", header = T)

#subset by drug
apixaban <- subset(noac_data, `Which NOAC Drug Used`  == "apixaban")
rivaroxaban <- subset(noac_data, `Which NOAC Drug Used`  == "rivaroxaban")

#remove missing
api_no_missing<-subset(apixaban, `Anti-factor Xa activity (ng/mL)` != "MD")
riv_no_missing<-subset(rivaroxaban, `Anti-factor Xa activity (ng/mL)` != "MD")

#plot distribution:
png(filename = "hist_apixaban_factorx_dist.png", res=100)
hist(as.integer(api_no_missing$`Anti-factor Xa activity (ng/mL)`, main = "Dist of Anti-Factor Xa Activity - Apixaban", xlab = "Anti-Factor Xa Activity (ng/mL)")
dev.off()
png(filename = "hist_rivaroxaban_factorx_dist.png", res=100)
hist(as.integer(riv_no_missing$`Anti-factor Xa activity (ng/mL)`, main = "Dist of Anti-Factor Xa Activity - Rivaroxaban", xlab = "Anti-Factor Xa Activity (ng/mL)")
dev.off()

