#!/bin/bash
module load stringtie/1.3.3b
module load samtools/1.9
cd /cart/fangzy01/SNI_copy/sam_new/

filelist=$(cat ../id.txt)
for id in ${filelist[@]}
do
        #echo $id
	#series=${id:0:2}
	#echo $series
        if [ ! -f "../gtf/"$id".gtf" ]; then
                echo "start $id=================="      
                #echo "../bam_new/"$id".bam"
                stringtie -p 128 -G ../mm39.gtf -o "../gtf/"$id".gtf" -l $id "../bam_new/"$id".bam"
                echo $id"_job finished!"
        fi
done

