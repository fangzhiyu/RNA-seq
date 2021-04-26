#!/bin/bash
module load bowtie2/2.3.5.1
module load samtools/1.9
cd /cart/fangzy01/SNI_copy/

filelist=$(cat ./id.txt)
for id in ${filelist[@]}
do
        echo $id
        if [ ! -f "./sam_new/"$id".sam" ]; then
                echo "start $id=================="      
                nohup bowtie2 -p 64 --un-gz "unpaired."$id".fastq" --un-conc-gz "./unconc_new/unconc.paired."$id".fastq" -x mm39 -1 "./qc/"$id"r1.fastq" -2 "./qc/"$id"r2.fastq" --sensitive-local >"./sam_new/"$id".sam" 2>"./log_new/"$id".log" &
                echo $id"_job submitted!"
		sleep 1800
        fi
done


