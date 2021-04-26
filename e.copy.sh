#!/bin/bash

module load stringtie/1.3.3b

cd /cart/fangzy01/SNI_copy/
test ! -d counts && mkdir counts && echo "./counts created" 
filelist=$(cat id.txt)

cd ./gtf/
for id in ${filelist[@]}
do
	echo "======"$id"====="
	path="/cart/fangzy01/SNI_copy/counts/"$id
	
	#if [ ! -f $path"/"$id".gtf" ]; then
	cd $path
	#stringtie -e -B -p 128 -G "../../gtf/"$id".gtf" -o "./"$id".gtf" "../../bam_new/"$id".bam"
	cp "./"$id".gtf" "../../ballgown/"$id".gtf"
	echo $id"_job copied!"
		
	#fi

done
