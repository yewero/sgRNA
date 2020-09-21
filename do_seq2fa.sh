#!/bin/bash
IN=can
OUT=cand_fa

if [[ $# -ne 1 ]]
then
	echo "Usage: bash $0 xname"
	exit
fi

mkdir -p $OUT

id=$1
for i in A C G T
do
	awk '{print ">"NR"\n"$1}' $IN/${id}_${i}.can > $OUT/${id}_${i}.fa
done

