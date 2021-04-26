#!/bin/bash



cd /cart/fangzy01/SNI_copy/

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
	cat id.txt | sort | uniq >id.tmp
	mv id.tmp id.txt
fi


filelist=$(cat id.txt)

set i 0
#total=$(awk 'END{print NR}' id.txt)
cd ./compare/
for id in ${filelist[@]}
do
	echo "========="$id"========="
	if [ ! -f "../compare/"$id".loci" ]; then	
		/home/fangzy01/tools/gffcompare-0.12.1/gffcompare -r ../mm39.gtf -G -o $id "../gtf/"$id".gtf"
		#let i++
		#echo $id":"$i"th_finished!"
	fi  
done

