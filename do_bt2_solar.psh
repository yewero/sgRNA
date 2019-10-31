#!/bin/bash

prefix=cand_fa
mkdir -p cand_sam

name=$1
echo $name
for base in A C G T
do
	echo $base
	bowtie2 -p 10 -a --no-head -x Bowtie2Index/genome -f $prefix/${name}_${base}.fa -S cand_sam/${name}_${base}.sam
done

