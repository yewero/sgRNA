#!/bin/Rscript

# Given a fasta (chromosome region) -> Return sgRNA candidates

x_in <- commandArgs(trailingOnly = T)
fa_in <- x_in[1]
outnm <- x_in[2]

print(fa_in)

suppressMessages(library("seqinr"))
#chr_n <- 17;sequence <- read.fasta(file=paste("./Chr/Homo_sapiens.GRCh37.75.dna.chromosome.",chr_n,".fa",sep=""),as.string=T)	# !!!
#seg <- substring(sequence,7572927,7573008)		# sense chain	# !!!

seg <- read.fasta(file=fa_in,as.string=T)

rc <- function(x) {
        chartr("ACGTacgt","TGCAtgca",sapply(lapply(strsplit(x, NULL), rev), paste, collapse=""))
}

seg_rc <- rc(as.character(seg))					# antisense chain
# ->
do_core <- function(segment) {
pos1 <- gregexpr("GG",segment,ignore.case=T)[[1]]
posa <- c(-100,pos1)
posb <- c(pos1,0)
pos_add <- posb[posb-posa==2]-1
pos_full <- sort(c(pos1,pos_add))				# GG position
#G1 <- gregexpr("G",segment,ignore.case=T)[[1]]	# G position

#extract <- function(x) {
#output <- substring(segment,x[1],x[2])
#return(output)
#}

#do_sequence <- function(seed) {         # for each seed: G position
#pass <-pos_full[(pos_full-seed>=21 & pos_full-seed<=25)]        # sequence: 19~23
#good <- cbind(as.numeric(rep(seed,length(pass))),as.numeric(pass+1))
#it <- apply(good,1,extract)
#return(it)	# N~XXX~NGG
#}

in_len <- 22	# the sgRNA length (NOT including G and NGG)
pos_region <- cbind(pos_full-(in_len+1),pos_full-2)	# NOT "G" and "NGG"
it <- apply(pos_region,1,function(x) { substring(segment,x[1],x[2]) } )
return(it)

#ggg <- unlist(apply(as.matrix(G1),1,do_sequence))
#return(substring(ggg,2,nchar(ggg)-3))	# remove "G" and "NGG" sequence
}
# <-
can1 <- do_core(seg)
can2 <- do_core(seg_rc)
can <- unique(c(can1,can2))

canA <- paste(can,"AGG",sep="")
canC <- paste(can,"CGG",sep="") 
canG <- paste(can,"GGG",sep="") 
canT <- paste(can,"TGG",sep="")

write.table(x=canA,file=paste0("can/",outnm,"_A.can"),quote=F,col.names=F,row.names=F)
write.table(x=canC,file=paste0("can/",outnm,"_C.can"),quote=F,col.names=F,row.names=F)
write.table(x=canG,file=paste0("can/",outnm,"_G.can"),quote=F,col.names=F,row.names=F)
write.table(x=canT,file=paste0("can/",outnm,"_T.can"),quote=F,col.names=F,row.names=F)

