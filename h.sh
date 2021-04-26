#!/bin/bash
module load stringtie/1.3.3b
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
		while [ ! -f "../gtf/"$id".gtf" ]
		do
			echo "waiting..."
			sleep 600
		done 
                /home/fangzy01/tools/gffcompare-0.12.1/gffcompare -r ../mm39.gtf -G -o $id "../gtf/"$id".gtf"
                #let i++
                #echo $id":"$i"th_finished!"
        fi
done
cd /cart/fangzy01/SNI_copy/
test ! -d counts && mkdir counts && echo "./counts created" 
filelist=$(cat id.txt)

cd ./gtf/
for id in ${filelist[@]}
do
        echo "======"$id"====="
        path="/cart/fangzy01/SNI_copy/counts/"$id
        test ! -d $path && mkdir $path && echo "./"$id" created!"

        if [ ! -f $path"/"$id".counts.gtf" ]; then
                cd $path
                stringtie -e -B -p 128 -G "../../gtf/"$id".gtf" -o "./"$id".counts.gtf" "../../bam_new/"$id".bam"
                echo $id"_job finished!"
        fi
done

module load python/3.7.4
cd /cart/fangzy01/SNI_copy/pipeline/
python convert.py -i lst.txt



