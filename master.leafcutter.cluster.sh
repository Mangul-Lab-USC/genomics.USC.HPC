#!/bin/sh

ls *junc >junc_files.txt

tool=/home/rcf-proj/sm3/akarlsbe/code/leafcutter/clustering/leafcutter_cluster.py


echo "#!/bin/sh" >run_leafcutter_cluster.sh
echo "python $tool -j junc_files.txt -m 50 -o leafcutter_cluster -l 500000">>run_leafcutter_cluster.sh
echo "ls>done.txt" >>run_leafcutter_cluster.sh

sbatch --ntasks=16 --mem-per-cpu=12G --time=24:00:00 run_leafcutter_cluster.sh #-p scavenge
