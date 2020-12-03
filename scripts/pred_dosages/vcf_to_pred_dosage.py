#!/usr/bin/python
'''This python script takes one imputed vcf file as input, and makes a predixcan dosage formatted output file: chr*.dosage.txt
vcfs should be filtered by maf and r2 before using this script
dose allele is A2, freq is of A2, A2 is alt in vcf
this script does not make the samples file needed for predixcan
see https://github.com/hakyimlab/PrediXcan/blob/master/Software/HOWTO-beta.md'''

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
    return parser.parse_args(args)

#retrieve command line arguments
args = check_arg(sys.argv[1:])
chrpath = args.inputdir
c = args.chr
chrfile = chrpath + "chr" + c + "_maf01_r28.vcf.gz"


# get dosage file data
if(os.path.exists(chrpath + 'UMich_dosages/') == False):
    os.mkdir(chrpath + 'UMich_dosages/')

outdosage = open(chrpath + "UMich_dosages/chr" + c + ".dosage.txt","w")
for line in gzip.open(chrfile):
    #skip meta data and header lines
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
    #reformat ids for proteome models (chr:pos)
    id_list = id.split(b":")
    id_formatted = str(id_list[0]) + ":" + str(id_list[1])
    output = str(chr) + ' ' + str(id_formatted) + ' ' + str(pos) + ' ' + str(ref) + ' ' + str(alt) + ' ' + str(freqalt) + ' ' + dosages + '\n'
    output = output.replace("b", "")
    output = output.replace("'", "")
    outdosage.write(output)

outdosage.close()

