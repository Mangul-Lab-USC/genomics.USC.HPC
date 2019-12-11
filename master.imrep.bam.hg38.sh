#!/bin/sh


ls *bam | awk -F ".bam" '{print $1}' >samples.txt

while read line
do

# for star.leafcutter prepped bams, use option: --chrFormat2 
echo "#!/bin/sh" > run.imrep.${line}.sh
echo "/home/rcf-proj/sm3/akarlsbe/anaconda2/bin/python /home/rcf-proj/sm3/akarlsbe/code/imrep/imrep.py --hg38 --bam  --noOverlapStep --noCast ${line}.bam ${line}.cdr3" >>run.imrep.${line}.sh
echo "ls>done.txt" >> run.imrep.${line}.sh

sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.imrep.${line}.sh #-p scavenge

done<samples.txt

