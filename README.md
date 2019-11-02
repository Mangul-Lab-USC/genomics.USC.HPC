# genomics.USC.HPC
rna.seq.pipeline for USC HPC



https://hpcc.usc.edu/gettingstarted/

ssh akarlsbe@hpc-login3.usc.edu

Home directory
/home/rcf-proj/sm3/akarlsbe

scp filename akarlsbe@hpc-transfer.usc.edu:/home/rcf-proj/sm3/akarlsbe

scp filename akarlsbe@hpc-login3.usc.edu:/home/rcf-proj/sm3/akarlsbe

10T per user:
/staging/sm3/akarlsbe
/staging/sm3/mangul

USC batch JOBS:
#!/bin/bash
sbatch --ntasks=16 --mem-per-cpu=20G --time=24:00:00 file_name.sh


interactive jobs:
sbatch salloc

show jobs:
squeue /all jobs
myqueue /my jobs

Each user has 10T on staging/project/username
each group has access to the project memory of 5T

Staging memory is there for 6 weeks before being automatically deleted

Touch may be a good trick for keeping files from being deleted.



Limits:
99 compute nodes == 300-400 cpus
10 jobs at once per user

check how busy cluster is:
sinfo --partition main
sinfo -p scavenge. //dedicated idle nodes
htop so view whats running when you log in


utilize other peoples personal nodes with scavenge option. This gets deleted if the owner of nodes submits job that uses their nodes:

--scavenge

queue times have been longer than normal since people are using dedicated


options for using available software packages:
1) run setup.sh to set up version of software you want //modifies temporary path
2) put full path in bash profile
3) specify full path when calling the program