#Three NOAC Drugs:
#apixaban, darbigatran, rivaroxiban

#Determine distribution of Anti-factor Xa activity (ng/mL) for each drug


library(data.table)
library(dplyr)

noac_data <- fread("/home/ashley/account/phenos/account_noac_processed.csv", header = T)

#subset by drug
apixaban <- subset(noac_data, Which NOAC Drug Used == "apixaban")
darbigatran <- subset(noac_data, Which NOAC Drug Used == "darbigatran")
rivaroxiban <- subset(noac_data, Which NOAC Drug Used == "rivaroxiban")

#plot distribution:
hist(apixaban$Anti-factor Xa activity (ng/mL))
