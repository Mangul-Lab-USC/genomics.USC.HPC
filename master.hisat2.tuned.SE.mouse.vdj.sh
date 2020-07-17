#!/bin/sh

ls *.fastq | awk -F ".fastq" '{print $1}'>samples.txt


while read line
do

echo "#!/bin/sh" > run.hisat2.${line}.sh
echo "/scratch/akarlsbe/genomics.USC.HPC/run.hisat2.tuned.SE.mouse.vdj.sh ${line}.fastq ${line}">>run.hisat2.${line}.sh
echo "ls>done.txt" >> run.hisat2.${line}.sh


sbatch --ntasks=1 --mem-per-cpu=16G --time=16:00:00 run.hisat2.${line}.sh #-p scavenge

done<samples.txt