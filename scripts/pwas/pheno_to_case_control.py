#convert clop pheno to case/control
#case is PRU >= 230, control is PRU < 230

file = open("/home/ashley/account/phenos/clop/clop_pheno_no_ids.txt", "r")

out = open("/home/ashley/account/phenos/clop/clop_pheno_case_control.txt", "w")

for line in file:
    l = line.strip("\n")
    if l != "NA":
        if int(l) >= 230:
            out.write("1\n")
        else:
            out.write("0\n")
    else:
        out.write("0\n")

out.close()
