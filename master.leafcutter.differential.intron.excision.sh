#!/bin/sh

# Rscript /home/rcf-proj/sm3/akarlsbe/code/leafcutter/scripts/leafcutter_ds.R --num_threads 4 --exon_file=dir_location/gencode.v31.exons.txt.gz dir_location/leafcutter_cluster_perind_numers.counts.gz outfile_groups.txt



# Installation instructions:

# Leafcutter:

# vi ~/.R/Makevars

# insert:

# CXX14FLAGS=-O3 -march=native -mtune=native -fPIC
# CXX14=g++


# source /usr/usc/gnu/gcc/8.2.0/setup.sh
# export LD_LIBRARY_PATH=/usr/usc/gnu/gcc/8.2.0/lib64:${LD_LIBRARY_PATH}
# source /usr/usc/R/3.6.0/setup.sh
# R
# install.packages("rstan")
# install.packages("devtools")
# devtools::install_github("davidaknowles/leafcutter/leafcutter")
# install all cran packages option 1.


# recurring command for leafcutter:

# source /usr/usc/gnu/gcc/8.2.0/setup.sh
# export LD_LIBRARY_PATH=/usr/usc/gnu/gcc/8.2.0/lib64:${LD_LIBRARY_PATH}
# source /usr/usc/R/3.6.0/setup.sh


