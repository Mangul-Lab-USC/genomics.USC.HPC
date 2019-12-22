#!/bin/sh

ls *bam | awk -F ".bam" '{print $1}' >samples.txt

while read line
do


echo "#!/bin/sh" > run.TRUST4.${line}.sh
echo "source /usr/usc/gnu/gcc/8.2.0/setup.sh" >>run.TRUST4.${line}.sh
echo "export LD_LIBRARY_PATH=/usr/usc/gnu/gcc/8.2.0/lib64:${LD_LIBRARY_PATH}" >>run.TRUST4.${line}.sh
echo "mkdir TRUST4.${line}" >> run.TRUST4.${line}.sh
echo "/home/rcf-proj/sm3/akarlsbe/code/TRUST4/run-trust4 -b ${line}.bam -f hg38_bcrtcr.fa --ref human_IMGT+C.fa -o TRUST4.${line}/${line}." >>run.TRUST4.${line}.sh

echo "ls>done.txt" >> run.TRUST4.${line}.sh

sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.TRUST4.${line}.sh #-p scavenge

done<samples.txt

