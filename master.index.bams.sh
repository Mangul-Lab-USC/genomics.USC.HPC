#!/bin/sh

ls *bam | awk -F ".bam" '{print $1}' >samples.txt

while read line
do

echo "#!/bin/sh" > run.index.bam.${line}.sh
echo "samtools index ${line}.bam" >> run.index.bam.${line}.sh
																								
sbatch --ntasks=2 --mem-per-cpu=16G --time=24:00:00 run.index.bam.${line}.sh

done<samples.txt