#!/bin/sh
ls *_R1_001.fastq.gz | awk -F "_R1_001.fastq.gz" '{print $1}'>samples.txt


while read line
do


pwd=$(pwd)


echo "#!/bin/sh" > run.mixcr.rna_seq.${line}.sh

echo "java -jar /home/rcf-proj3/sm3/akarlsbe/mixcr-3.0.11 align -p rna-seq -s hsa -OallowPartialAlignments=true ${pwd}/${line}_R1_001.fastq.gz ${pwd}/${line}_R2_001.fastq.gz ${line}_alignments.vdjca" >> run.mixcr.rna_seq.${line}.sh
echo "java -jar /home/rcf-proj3/sm3/akarlsbe/mixcr-3.0.11 assemblePartial ${line}_alignments.vdjca ${line}_alignments_rescued_1.vdjca" >> run.mixcr.rna_seq.${line}.sh
echo "java -jar /home/rcf-proj3/sm3/akarlsbe/mixcr-3.0.11 assemblePartial ${line}_alignments_rescued_1.vdjca ${line}_alignments_rescued_2.vdjca" >> run.mixcr.rna_seq.${line}.sh
echo "java -jar /home/rcf-proj3/sm3/akarlsbe/mixcr-3.0.11 assemble ${line}_alignments_rescued_2.vdjca ${line}_clones.clns" >> run.mixcr.rna_seq.${line}.sh
echo "java -jar /home/rcf-proj3/sm3/akarlsbe/mixcr-3.0.11 exportClones ${line}_clones.clns ${line}_clones.txt" >> run.mixcr.rna_seq.${line}.sh
echo "ls>done.txt" >> run.mixcr.rna_seq.${line}.sh

sbatch --ntasks=16 --mem-per-cpu=16G --time=24:00:00 run.mixcr.rna_seq.${line}.sh #-p scavenge

done<samples.txt
