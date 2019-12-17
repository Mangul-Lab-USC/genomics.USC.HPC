#!/bin/sh
ls *cdr3 | awk -F ".cdr3" '{print $1}' >samples.txt

while read line
do

echo "#!/bin/sh" > run.clonality.${line}.sh

echo "python /home/rcf-proj/sm3/akarlsbe/code/imrep/clonality.py ${line}.cdr3 ${line}.clonality" >>run.clonality.${line}.sh

echo "ls>done.txt" >> run.clonality.${line}.sh

sbatch run.clonality.${line}.sh #-p scavenge

done<samples.txt



#command to combine the TCRA.cdr3.FREQ..csv files into one csv for all clonality samples.
#echo "SAMPLE,nIGH,nIGK,nIGL,nTCRA,nTCRB,nTCRD,nTCRG,loadIGH,loadIGK,loadIGL,loadTCRA,loadTCRB,loadTCRD,loadTCRG,alphaIGH,alphaIGK,alphaIGL,alphaTCRA,alphaTCRB,alphaTCRD,alphaTCRG" > combined_clonality.csv
#tail -n +2 -q */*summary.cdr3.txt >> combined_clonality.csv


#command to combine the summary.cdr3.txt files into one csv for all clonality samples.
# grep "" */TCRA.cdr3.FREQ..csv | sed 's/:/,/' | awk -F "_" '{print $2"_"$3}' >t1
# grep "" */TCRA.cdr3.FREQ..csv | sed 's/:/,/' | awk -F "," '{print $2","$3","$4}' >t2
# paste t1 t2 | awk '{print $1","$2}' > t3
# grep -v CDR3 t3 > t4
# echo "SAMPLE,CDR3,count,relative.frequency" > t5 
# cat t5 t4 > combined_cdr3_frequencies.csv
