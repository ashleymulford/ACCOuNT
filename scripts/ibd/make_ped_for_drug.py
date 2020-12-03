clop_ids = open("/home/ashley/account/gwas_qc/blacks/clop_ids.txt", "r")

ped = open("/home/ashley/account/gwas_qc/blacks/blacks_imputed_filtered_allchr.ped", "r")

clop_ped = open("/home/ashley/account/gwas_qc/blacks/blacks_clop.ped", "w")

id_list = []

for line in clop_ids:
    ids = line.split()
    id = ids[0] + " "
    id_list.append(id)

for line in ped:
    for id in id_list:
        if line.startswith(id):
            clop_ped.write(line)

clop_ped.close()

