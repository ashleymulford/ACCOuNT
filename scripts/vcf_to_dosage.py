#!/usr/bin/python
'''This python script takes one imputed vcf file as input, 
and makes a predixcan dosage formatted output file:
chr*.dosage.txt
dose allele is Allele2 see https://github.com/hakyimlab/PrediXcan/blob/master/Software/HOWTO-beta.md'''

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

outdosage = open(chrpath + "UMich_dosages/chr" + c + ".maf" + str(mafthresh) + ".r2" + str(r2thresh) + ".dosage.txt","w")
for line in gzip.open(chrfile):
    if(line.startswith(b'##')):
        continue
    if(line.startswith(b'#CHROM')):
        continue
    arr = line.strip().split()
    (chr, pos, id, ref, alt, qual, filter, info, format) = arr[0:9]
    gt_dosagerow = arr[9:]
    #get freq of alt allele:
    info_list = info.split(b";")
    af_list = info_list[0].split(b"=")
    freqalt = af_list[1]
    #get dosage of alt allele
    dosagerow = map(lambda x : float(x.split(b":")[1]), gt_dosagerow) #lambda function to split each info entry and collect the dosage
    dosages = ' '.join(map(str,dosagerow))
    output = str(chr) + ' ' + str(id) + ' ' + str(pos) + ' ' + str(ref) + ' ' + str(alt) + ' ' + str(freqalt) + ' ' + dosages + '\n'
    output = output.replace("b", "")
    output = output.replace("'", "")
    outdosage.write(output)

outdosage.close()

