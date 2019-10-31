#!/bin/Rscript

name <- commandArgs(6)
print(name)

gc <- read.table(paste0(name,".gc"),header=F)   # gc
final <- read.table(paste0(name,".final"),header=F)[,1]
sel_id <- gc[ rownames(gc)%in%final & gc$V2>=45 & gc$V2<=65, ]

rg <- read.table(paste0(name,".region"),header=F)
sel_rg <- rg[rg$V1%in%sel_id$V1,]       # may contain the sam ID with different regions

seq <- read.table(paste0(name,".seq"),stringsAsFactors=F)
seq <- seq[(1:nrow(seq))%%2==0,]        # all

sel_DF <- data.frame(sel_rg$V1,seq[sel_rg$V1],nchar(seq[sel_rg$V1]),gc$V2[sel_rg$V1],sel_rg$V3,sel_rg$V4,sel_rg$V5)
sel_DF <- sel_DF[order(sel_DF[,6]),]    # sorted by position
write.table(x=sel_DF,file=paste0(name,".info"),row.names=F,col.names=F,quote=F,sep="\t")

# from 50k to 5k
#!/bin/Rscript

# suppose the data was sorted

cutoff <- 70

#name <- commandArgs(trailingOnly = T) # e.g. chr9_100
#print(name)

#index <- as.numeric(gsub("chr9_","",name))
index <- as.numeric(unlist(strsplit(x=name,split="_"))[2])
lmost <- 50000*(index-1)+1
rmost <- 50000*index
lmost_cm <- formatC(lmost, format="d", big.mark=',')
rmost_cm <- formatC(rmost, format="d", big.mark=',')

sgRNA <- read.table(paste0(name,".info"),header=F)
# 256     cagaggggttgcttgagccagag 23      60.87   chr9    4954006 4954028
sg_out <- matrix(NA, nrow = 0, ncol = ncol(sgRNA))
left <- -1
right <- -1

for(i in 1:nrow(sgRNA)) {	# remove overlapping sequences
	if(sgRNA[i,6]<=right & sgRNA[i,7]>=left) {next}
	sg_out <- rbind(sg_out,sgRNA[i,])
	left <- min(c(left,sgRNA[i,6]))
	right <- max(c(right,sgRNA[i,7]))
}

sgRNA_index <- cut(sg_out$V6,breaks = seq(lmost-1,rmost,5000),labels = 1:10)	# the region index 1:10
sgRNA_dstr <- table(cut(sg_out$V6,breaks = seq(lmost-1,rmost,5000))) # 50k to 5k
sg_out <- cbind(sg_out,sgRNA_index)
write.table(x=sg_out,file=paste0(name,"_unique.txt"),row.names=F,col.names=F,quote=F,sep="\t")
print(sgRNA_dstr)

# plot
#png(file=paste0(name,".png"),width=1520,height = 662,res=100)
pdf(file=paste0(name,".pdf"),width=15.20,height = 6.62)
medi <- rep(NA,10)
rg <- seq(lmost-1,rmost,5000)
for(i in 1:10) { medi[i] <- mean(rg[i]+1,rg[i+1]) }
#print(medi)
barplot(sgRNA_dstr,cex.names = 0.9,col="skyblue",main=paste0("sgRNAs distribution: ",nrow(sg_out)),xlab=paste0("Chr9: ",lmost_cm," - ",rmost_cm),ylim=c(0,max(80,max(sgRNA_dstr))),names.arg =medi)
abline(h=cutoff,lty=2,col="grey")
dev.off()

sgRNA_ok <- sg_out[sgRNA_index%in%which(sgRNA_dstr>=cutoff),]	# pass the cutoff
write.table(x=sgRNA_ok,file=paste0(name,"_selected.txt"),row.names=F,col.names=F,quote=F,sep="\t")

