#!/bin/bash

if [ ! -e /cart/fangzy01/SNI_copy/id.txt ]; then

	cd /cart/fangzy01/SNI_copy/raw/
	filelist=$(ls | grep fastq)
	cd /cart/fangzy01/SNI_copy/
	for names in ${filelist[@]}
	do
        	id=${names%%_*}
        	id=${id:3}
		echo $id >> id.txt
		echo $names
		echo $id	
	done
	cat id.txt | sort | uniq > id.tmp
	mv id.tmp id.txt
fi

filelist=$(cat id.txt)
cd /cart/fangzy01/SNI_copy/raw/
for id in ${filelist[@]}
do 
        echo $id"r2.fastq"
        r1="SNI"${id}"_S98_R1_001.fastq"
        r2="SNI"${id}"_S98_R2_001.fastq"
	echo $r1
        if [ ! -f "../qc/"$id"r1.fastq" ]; then 
                fastp -i $r1 -I $r2 -o "../qc/"$id"r1.fastq" -O "../qc/"$id"r2.fastq" -h "../qc/"$id".html" -j "../qc/"$id".json" --length_required 35 --length_limit 150 -q 20 -u 50 -c 
        else
                echo "$id already exist!"
        fi 
done

