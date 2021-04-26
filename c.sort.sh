#!/bin/bash
module load bowtie2/2.3.5.1
module load samtools/1.9
cd /cart/fangzy01/SNI_copy/sam_new/

filelist=$(cat ../id.txt)
for id in ${filelist[@]}
do
        echo $id
        if [ ! -f "../bam_new/"$id".bam" ]; then
                echo "start $id=================="      
                #echo "../bam_new/"$id".bam"
		samtools sort -@ 128 -o "../bam_new/"$id".bam" $id".sam"
                echo $id"_job finished!"
        fi
done

