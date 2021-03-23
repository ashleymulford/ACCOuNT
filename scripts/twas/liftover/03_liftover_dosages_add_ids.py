#use after joining lifted snps and dosages with Rscript to add in new ids
#this script makes output file with chr:pos ids - split by chr afterwards
    #use awk command: awk '$1 == #' dosages.txt > chr#.txt, where # is 1 through 22, run 22 times

import argparse #allows for input of command line arguments
parser = argparse.ArgumentParser() #open the parser
parser.add_argument("--input", type = str, action = "store", dest = "input", required = True, help = "Input file")
parser.add_argument("--output", type = str, action = "store", dest = "output", required = False, default = "dosages.txt", help = "Output dosage file")
args = parser.parse_args() #parse given arguments

input = open(args.input, "r") #open input file
output = open(args.output, "w") #open output file (chr:pos ids)

for line in input: #go through each line in input
    line_list = line.strip().split("\t") #split anno line into list
    (chr, pos) = line_list[0:2] #assign chr and pos from line to a variable
    rest = line_list[2:] #assign last part of line to variable
    dosages_str = "\t".join(rest) #create string of rest separate by tabs
    dosage_format = (chr + "\t" + chr + ":" + pos + "\t" + pos + "\t" + dosages_str + "\n") #make all variables into PrediXcan dosage format (chr:pos ids)
    output.write(dosage_format) #write to output file

input.close() #close anno file
output.close() #close output file
