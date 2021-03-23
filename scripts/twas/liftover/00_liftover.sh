#Liftover from build 38 to build 37 - overview

#must run liftover on account dosages (build 37 to build 38) to run twas with mesa models (build 37)
#requires and input file and a chain (reference) file; outputs two files, one with snps lifted over and one with snps not lifted over
#get liftover chain files from here: http://hgdownload.soe.ucsc.edu/downloads.html#liftover


#create input for liftover from existing geno file:
#four columns, tab sep, no header: chr#, snp_pos, snp_pos+1 , snp_id (chr#:pos format)
  #example:
  #awk '{print $1 FS $3 FS $3+1 FS $2}' dosages2.txt > prelift.txt
  #must use unzippied dosage file
  # "$#" specifies column number (count starts at 1)
  # in this example column 1 has chr#, column 2 has snp_id, and column 3 has snp_pos - use these to make input file "prelift.txt"


#run liftover:
#liftOver prelift.txt /home/ashley/account/liftover/hg38ToHg19.over.chain.gz lifted.txt unmapped.txt
#specify input file path, chain file path, lifted file path (output file with snps lifted), and unmapped file path (output file with snps not lifted)

#check line count of both output files to make sure most snps were lifted


#lifted.txt output file will contain the same four columns as input, with positions lifted to new build but ids from preliftover
#use Rscript to join output with main geno file to get new positions (column 2 in lifted.txt)

