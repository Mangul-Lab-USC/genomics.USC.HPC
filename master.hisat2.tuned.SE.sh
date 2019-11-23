#!/bin/sh

ls *_R2_001.fastq.gz | awk -F "_R2_001.fastq.gz" '{print $1}'>samples.txt


while read line
do

echo "#!/bin/sh" > run.${line}.sh
echo "/home/rcf-proj/sm3/akarlsbe/genomics.USC.HPC/run.hisat2.tuned.SE.sh ${line}_R2_001.fastq.gz ${line}">>run.${line}.sh
sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.${line}.sh

done<samples.txt