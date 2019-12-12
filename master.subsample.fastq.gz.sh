#!/bin/sh


if [ $# -lt 3 ]
    then
    echo "********************************************************************"
    echo "Script was written for project benchmarking of IMREP2 vs Mixcr vs TRUST in their ability to capture immune repertoires from gold standard TCRseq data"
    echo "This script subsamples fastq.gz files for a specified number of reads using a random seed"
    echo "This script was written by Aaron Karlsberg"
    echo "********************************************************************"
    echo ""
    echo "1 <num_reads>   - number of reads"
    echo "2 <seed>   - random seed"
    echo "3 <outdir>   - specify full path to dir to save the output"
    echo "--------------------------------------"
    echo "example usage: within directory containing fastq.gz files:"
    echo "###./master.subsample.fastq.gz.sh 10000000 100 /staging/sm3/akarlsbe/scott###"
    echo "--------------------------------------"
    exit 1
    fi


# mandatory part
num_reads=$1
seed=$2
outdir=$3


# message
echo "subsampling more than the available number of reads will result in a copy of the fastq.gz file."
echo "To avoid misrepresentation, make sure you are subsampling less than the number of reads available"
echo "you can check by counting the number of lines in the fastq.gz file and dividing by 4. That is the max number of reads available."
echo "example usage: within directory containing fastq.gz files:"
echo "###./master.subsample.fastq.gz.sh 10000000 100 /staging/sm3/akarlsbe/scott###"

# STEP 0 - create output directory if it does not exist
echo "mkdir ${outdir}/subsample_num_reads_${num_reads}_seed_${seed}"


# STEP 1 -  generate list of files to subsample
ls *fastq.gz | awk -F ".fastq.gz" '{print $1}' >samples.txt


# STEP 2 - subsample each fastq file and then gzip subsampled fasta file in seperate job
while read line
do

echo "#!/bin/sh" > run.subsample.${line}.sh

echo "/home/rcf-proj/sm3/akarlsbe/code/seqtk/seqtk sample -s${seed} ${line}.fastq.gz ${num_reads} > ${outdir}/subsample_num_reads_${num_reads}_seed_${seed}/${line}.fastq" >>run.subsample.${line}.sh

echo "gzip ${outdir}/subsample_num_reads_${num_reads}_seed_${seed}/${line}.fastq"

echo "ls>done.txt" >> run.subsample.${line}.sh

sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.subsample.${line}.sh #-p scavenge

done<samples.txt
