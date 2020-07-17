#!/bin/bash

AUTHOR="Serghei Mangul"



################################################################
##########          The main template script          ##########
################################################################

toolName="hisat2.tuned"
# Human
# index="/home/rcf-proj/sm3/akarlsbe/grch38/genome"
# Mouse genome
# index="/scratch/akarlsbe/reference_files/mouse_genome_10/mm10"
# Mouse vdj
index="/scratch/akarlsbe/reference_files/mouse_vdj_ref/mouse_vdj_ref"
samtools=/usr/usc/samtools/1.9/bin/samtools
toolPath=/home/rcf-proj/sm3/akarlsbe/anaconda2/bin/hisat2


if [ $# -lt 2 ]
    then
    echo "********************************************************************"
    echo "Script was written for project : Comprehensive analysis of RNA-sequencing to find the source of 1 trillion reads across diverse adult human tissues"
    echo "This script was written by Serghei Mangul"
    echo "********************************************************************"
    echo ""
    echo "1 <input1>   - R1.fastq"
    echo "2 <outdir>  - dir to save the output"
    echo "--------------------------------------"
    exit 1
    fi



# mandatory part
input1=$1
outdir=$2

echo "$input1"
echo "$outdir"


# STEP 0 - create output directory if it does not exist

mkdir $outdir
pwd=$PWD
cd $outdir
outdir=$PWD
cd $pwd
logfile=$outdir/report_$(basename ${input1%.*})_${toolName}.log


echo $logfile


# -----------------------------------------------------

echo "START" >> $logfile
# STEP 1 - prepare input if necessary (ATTENTION: TOOL SPECIFIC PART!)
# -----------------------------------




# STEP 2 - run the tool (ATTENTION: TOOL SPECIFIC PART!)

now="$(date)"
printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile

# run the command
res1=$(date +%s.%N)


# . /u/local/Modules/default/init/modules.sh
# module load samtools


echo "$toolPath -x $index -U $input1 --end-to-end -N 1 -L 20 -i S,1,0.5 -D 25 -R 5 --pen-noncansplice 12 --mp 1,0 --sp 3,0 --time --reorder | $samtools view -bS - >$outdir/${toolName}_$(basename ${input1%.*}).bam 2>>$logfile"

$toolPath -x $index -U $input1 --end-to-end -N 1 -L 20 -i S,1,0.5 -D 25 -R 5 --pen-noncansplice 12 --mp 1,0 --sp 3,0 --time --reorder | $samtools view -bS - >$outdir/${toolName}_$(basename ${input1%.*}).bam 2>>$logfile

$samtools view -f 4 -bh $outdir/${toolName}_$(basename ${input1%.*}).bam | $samtools bam2fq - >$outdir/${toolName}_$(basename ${input1%.*})_unmapped.fastq 2>>$logfile




/home/rcf-proj/sm3/akarlsbe/anaconda2/bin/python /home/rcf-proj/sm3/akarlsbe/code/number.reads.bam.py $outdir/${toolName}_$(basename ${input1%.*}).bam $outdir/${toolName}_$(basename ${input1%.*}).NR_PE.txt

$samtools sort $outdir/${toolName}_$(basename ${input1%.*}).bam >$outdir/${toolName}_$(basename ${input1%.*}).sort.bam

$samtools index $outdir/${toolName}_$(basename ${input1%.*}).sort.bam 


rm $outdir/${toolName}_$(basename ${input1%.*}).bam
rm $outdir/${toolName}_$(basename ${input1%.*})_unmapped.fastq


#hisat2 --threads 16 --end-to-end -N <NUM_MISMATCH> -L <SEED_LENGTH> -i S,1,<SEED_INTERVAL> -D <SEED_EXTENSION> -R <RE_SEED> --pen-noncansplice <PENALITY_NONCANONICAL> --mp <MAX_MISMATCH_PENALITY>,<MIN_MISMATCH_PENALITY> --sp <MAX_SOFTCLIPPING_PENALITY>,<MIN_SOFTCLIPPING_PENALITY>--time --reorder --known-splicesite-infile <output index path>/<genome name>.splicesites.txt --novel-splicesite-outfile splicesites.novel.txt --novel-splicesite-infile splicesites.novel.txt -f -x <index name> -1 <read file 1> -2 <read file 2> -S <output sam file>
# default 1 20 0.5 25 5 12 1 0 3 0



res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
now="$(date)"
printf "%s --- TOTAL RUNTIME: %d:%02d:%02d:%02.4f\n" "$now" $dd $dh $dm $ds >> $logfile

now="$(date)"
printf "%s --- FINISHED RUNNING %s %s\n" "$now" $toolName >> $logfile

# ---------------------




# STEP 3 - transform output if necessary (ATTENTION: TOOL SPECIFIC PART!)



now="$(date)"
printf "%s --- TRANSFORMING OUTPUT\n" "$now" >> $logfile


#cat $outdir/one_output_file.fastq | gzip > $outdir/${toolName}_$(basename ${input%.*})_${kmer}.corrected.fastq.gz

now="$(date)"
printf "%s --- TRANSFORMING OUTPUT DONE\n" "$now" >> $logfile

# remove intermediate files
#rm $outdir/one_output_file.fastq

rm -fr ${toolName}_$(basename ${input1%.*}).bam


# --------------------------------------



printf "DONE" >> $logfile
