#!/bin/sh

ls *_R2_001.fastq.gz | awk -F "_R2_001.fastq.gz" '{print $1}'>samples.txt


while read line
do

echo "#!/bin/sh" > run.hisat2.${line}.sh
echo "/home/rcf-proj/sm3/akarlsbe/genomics.USC.HPC/run.hisat2.tuned.SE.sh ${line}_R2_001.fastq.gz ${line}">>run.hisat2.${line}.sh
echo "ls>done.txt" >> run.hisat2.${line}.sh

sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.hisat2.${line}.sh #-p scavenge

done<samples.txt