#!/bin/Rscript

gene <- commandArgs(6)
print(gene)

nh <- read.table(file=paste(gene,".god",sep=""),header=F)[,1]
chrA <- read.table(file=paste(gene,"_A.chr",sep=""),header=F,sep="\t")
chrC <- read.table(file=paste(gene,"_C.chr",sep=""),header=F,sep="\t")
chrG <- read.table(file=paste(gene,"_G.chr",sep=""),header=F,sep="\t")
chrT <- read.table(file=paste(gene,"_T.chr",sep=""),header=F,sep="\t")

nhs <- as.character(nh)
#print(head(nhs))
posA <- chrA[nhs,2]
posC <- chrC[nhs,2]
posG <- chrG[nhs,2]
posT <- chrT[nhs,2]

write.table(x=cbind(nhs,as.character(posA),as.character(posC),as.character(posG),as.character(posT)),file=paste(gene,".final",sep=""),quote=F,row.names=F,col.names=F,sep="\t")


