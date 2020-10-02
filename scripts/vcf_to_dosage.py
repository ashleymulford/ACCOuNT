#!/usr/bin/python
'''This python script takes one imputed vcf file as input, 
removes SNPs with R2<0.8 and MAF>0.01 (options to change),
and makes output files:
chr*.dosage.txt.gz
samples.txt
dose allele is Allele2, see https://github.com/hakyimlab/PrediXcan/blob/master/Software/HOWTO-beta.md'''

import gzip
import re
import sys
import argparse
import os

def check_arg(args=None):
    parser = argparse.ArgumentParser(description='Script to filter imputed VCF')
    parser.add_argument('-i', '--inputdir',
                        help='directory containing VCF file',
                        required='True'
                        )
    parser.add_argument('-c', '--chr',
                        help='chromosome',
			type=str,
                        required='True'
                        )
    parser.add_argument('-m', '--maf',
                        help='maf threshold, default 0.01',
                        type=float,
                        default=0.01)
    parser.add_argument('-r2', '--rsq',
                        help='R2 threshold, default 0.8',
                        type=float,
                        default=0.8
                        )
    return parser.parse_args(args)

#retrieve command line arguments

args = check_arg(sys.argv[1:])
chrpath = args.inputdir
c = args.chr
mafthresh = args.maf
r2thresh = args.rsq
chrfile = chrpath + "chr" + c + "_maf01_r28.vcf.gz"


# get dosage file data
if(os.path.exists(chrpath + 'UMich_dosages/') == False):
    os.mkdir(chrpath + 'UMich_dosages/')

outdosage = gzip.open(chrpath + "UMich_dosages/chr" + c + ".maf" + str(mafthresh) + ".r2" + str(r2thresh) + ".dosage.txt.gz","wb")
for line in gzip.open(chrfile):
    if(line.startswith('##')):
        continue
    arr = line.strip().split()
    (chr, pos, id, ref, alt, qual, filter, info, format) = arr[0:9]
    if(bool(re.search('ER2',info)) == True): #look for 'ER2' to decide whether to split into 3 or 4
        (af, maf, impr2, imper2) = info.split(";")
    elif(bool(re.search('R2',info)) == True):
        (af, maf, impr2) = info.split(";")
    else:
        (af, maf) = info.split(";") #GENOTYPED_ONLY SNPs
    r2 = float(impr2.split("=")[1]) #get r2 value as float
    minor = float(maf.split("=")[1]) #get maf as float
    if pos in posdict:
        rsid = posdict[pos]
    else:
        rsid = '.'
    if(r2 > r2thresh and minor > mafthresh and re.search('rs',rsid) != None): #only pull SNPs with rsids and default: R2>0.8, maf>0.01
        gt_dosagerow = arr[9:]
        #see http://www.python-course.eu/lambda.php for details
        dosagerow = map(lambda x : float(x.split(":")[1]), gt_dosagerow) #lambda function to split each info entry and collect the dosage
        freqalt = round(sum(dosagerow)/(len(dosagerow)*2),4) #calc ALT allele freq (I found that ALT is not always the minor allele)
        dosages = ' '.join(map(str,dosagerow))
        output = 'chr' + chr + ' ' + rsid + ' ' + pos + ' ' + ref + ' ' + alt + ' ' + str(freqalt) + ' ' + dosages + '\n'
        outdosage.write(output)

outdosage.close()
