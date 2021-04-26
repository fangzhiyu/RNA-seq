#!/bin/bash


module load python/2.7.17
cd /cart/fangzy01/SNI_copy
nohup python /share/app/gene/rmats_turbo_v4_1_1/rmats.py --nthread 128 --tmp ./tmp/ --b1 b1.txt --b2 b2.txt --gtf Mus_musculus.GRCm38.83.gtf -t paired --readLength 150 --od /cart/fangzy01/SNI_copy/as2/ &
