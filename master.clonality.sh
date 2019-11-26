#!/bin/sh
ls *cdr3 | awk -F ".cdr3" '{print $1}' >samples.txt

while read line
do

echo "#!/bin/sh" > run.clonality.${line}.sh

echo "python /home/rcf-proj3/sm3/akarlsbe/imrep/clonality.py ${line}.cdr3 ${line}.clonality" >>run.clonality.${line}.sh

echo "ls>done.txt" >> run.clonality.${line}.sh

sbatch run.clonality.${line}.sh -p scavenge

done<samples.txt

