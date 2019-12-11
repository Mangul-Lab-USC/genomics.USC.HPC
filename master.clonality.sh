#!/bin/sh
ls *cdr3 | awk -F ".cdr3" '{print $1}' >samples.txt

while read line
do

echo "#!/bin/sh" > run.clonality.${line}.sh

echo "python /home/rcf-proj/sm3/akarlsbe/code/imrep/clonality.py ${line}.cdr3 ${line}.clonality" >>run.clonality.${line}.sh

echo "ls>done.txt" >> run.clonality.${line}.sh

sbatch run.clonality.${line}.sh #-p scavenge

done<samples.txt



#command to combine the summary.cdr3.txt files into one csv for all clonality samples.
#echo "SAMPLE,nIGH,nIGK,nIGL,nTCRA,nTCRB,nTCRD,nTCRG,loadIGH,loadIGK,loadIGL,loadTCRA,loadTCRB,loadTCRD,loadTCRG,alphaIGH,alphaIGK,alphaIGL,alphaTCRA,alphaTCRB,alphaTCRD,alphaTCRG" > combined_clonality.csv
#tail -n +2 -q */*summary.cdr3.txt >> combined_clonality.csv

