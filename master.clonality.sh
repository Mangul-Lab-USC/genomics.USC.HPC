#!/bin/sh
ls *cdr3 | awk -F ".cdr3" '{print $1}' >samples.txt

while read line
do

echo "#!/bin/sh" > run.${line}.sh

echo "python /home/rcf-proj3/sm3/akarlsbe/imrep/clonality.py ${line}.cdr3 ${linee
}.clonality" >>run.${line}.sh

sbatch run.${line}.sh

done<samples.txt

