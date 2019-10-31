#!/bin/Rscript

base <- commandArgs(6)
print(base)

nh <- read.table(file=paste(base,".st3",sep=""),header=F)
chr <- read.table(file=paste(base,".chr",sep=""),header=F,sep="\t")
pos <- chr[unlist(nh),]
write.table(x=pos,file=paste(base,".st4",sep=""),quote=F,row.names=F,col.names=F)	# specific for 1 chr without *



