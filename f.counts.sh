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
	test ! -d $path && mkdir $path && echo "./"$id" created!"

	if [ ! -f $path"/"$id".gtf" ]; then
		cd $path
		#-e only match transcrpits given in -G reference 
		#-G <ref_ann.gff>
		#input: bam file to count
		stringtie -e -B -p 128 -G "../../mm39.gtf" -o "./"$id".gtf" "../../bam_new/"$id".bam"
		cp "./"$id".gtf" "../../ballgown/"$id".gtf"
		echo $id"_job finished!"
		
	fi

done
