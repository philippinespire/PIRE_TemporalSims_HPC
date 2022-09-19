par(mai=c(1.1,1.1,1.1,0.1))

library(gtools)
library(tidyverse)

#using three scenarios - WGS/SNP x sampsize x method comparison of average absolute error
#fast (lambda = 0.95, beginning of decline = 30 years before present) 
#slow (lambda = 0.99, beginning of decline = 120 years before present)
#constant
#read momi2 inferences  
momidat=read.csv("inferences/momi_nomaf_data_deltaAIC.csv",header=T)
momidat=momidat[which(momidat$td=="constant"|momidat$td=="td100"|momidat$td=="td190"&momidat$lambda=="l95"),]
#retain estimates from the model fit in momi2 with the best AIC (constant size vs recent size change)
momidat$Neh_best=ifelse(momidat$delta>0,momidat$Neh_change,momidat$Neh)
momidat$Nec_best=ifelse(momidat$delta>0,momidat$Nec_change,momidat$Nec)

##read stairway plot infernces
stairwaydat=read.csv("inferences/stairwaydata.csv",header=T)
stairwaydat=stairwaydat[which(stairwaydat$td=="constant"|stairwaydat$td=="td100"|stairwaydat$td=="td190"&stairwaydat$lambda=="l95"),]

##read GONE inferences
gonedat=read.csv("inferences/GONEdata.csv",header=T)
gonedat=gonedat[which(gonedat$td=="constant"|gonedat$td=="td100"|gonedat$td=="td190"&gonedat$lambda=="l95"),]

##read NEEst inferences
lddat=read.csv("inferences/LDNeoutall.csv",header=T)
lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
lddat$tdec=paste("td",lddat$td,sep="")
lddat$lambda=paste("l",lddat$l,sep="")
lddat=lddat[which(lddat$tdec=="constant"|lddat$tdec=="td100"|lddat$tdec=="td190"&lddat$lambda=="l95"),]
lddat=lddat[which(lddat$maf==0.05),]

##"true"/simulated t0 + t120 population sizes
tru=read.csv("inferences/truvalue.csv",header=T)

##concatenate demographic variables into composite scenarios
gonedat$scen=paste(gonedat$NeAnc,gonedat$td,gonedat$lambda)
stairwaydat$scen=paste(stairwaydat$NeAnc,stairwaydat$td,stairwaydat$lambda)
lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)
momidat$scen=paste(momidat$NeAnc,momidat$td,momidat$lambda)
momidat$tdec=abs(as.integer(gsub('td','',momidat$td))-220)
momidat$tdec=na.replace(momidat$tdec,0)

##calculate absolute error per observation
momidat$trueNeH=tru$TrueNeH[match(momidat$scen,tru$scen)]
momidat$trueNeC=tru$TrueNec[match(momidat$scen,tru$scen)]
momidat$NeHerr=abs(momidat$Neh_best-momidat$trueNeH)/momidat$trueNeH
momidat$NeCerr=abs(momidat$Nec_best-momidat$trueNeC)/momidat$trueNeC
momidat$ratioerr=abs((momidat$Neh_best/momidat$Nec_best)-(momidat$trueNeH/momidat$trueNeC))/(momidat$trueNeH/momidat$trueNeC)
momidat$tderr=abs((momidat$T-momidat$tdec)/(momidat$tdec))

stairwaydat$trueNeH=tru$TrueNeH[match(stairwaydat$scen,tru$scen)]
stairwaydat$trueNeC=tru$TrueNec[match(stairwaydat$scen,tru$scen)]
stairwaydat$NeHerr=abs(stairwaydat$Neh-stairwaydat$trueNeH)/stairwaydat$trueNeH
stairwaydat$NeCerr=abs(stairwaydat$Nec-stairwaydat$trueNeC)/stairwaydat$trueNeC
stairwaydat$ratioerr=abs((stairwaydat$Neh/stairwaydat$Nec)-(stairwaydat$trueNeH/stairwaydat$trueNeC))/(stairwaydat$trueNeH/stairwaydat$trueNeC)

gonedat$trueNeH=tru$TrueNeH[match(gonedat$scen,tru$scen)]
gonedat$trueNeC=tru$TrueNec[match(gonedat$scen,tru$scen)]
gonedat$NeHerr=abs(gonedat$Neh-gonedat$trueNeH)/gonedat$trueNeH
gonedat$NeCerr=abs(gonedat$Nec-gonedat$trueNeC)/gonedat$trueNeC
gonedat$ratioerr=abs((gonedat$Neh/gonedat$Nec)-(gonedat$trueNeH/gonedat$trueNeC))/(gonedat$trueNeH/gonedat$trueNeC)

lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)] 
lddat_hist=subset(lddat,lddat$timepoint=="t120")
lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
lddat_contemp=subset(lddat,lddat$timepoint=="t0")
lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC
lddat_temporal=subset(lddat_contemp,lddat_contemp$scheme!="contemp")
lddat_hist$ratioerr=abs((lddat_hist$Ne/lddat_temporal$Ne)-(lddat_hist$trueNeH/lddat_temporal$trueNeC))/(lddat_hist$trueNeH/lddat_temporal$trueNeC)

max(momidat$NeHerr)
max(stairwaydat$NeHerr)
max(gonedat$NeHerr)
max(lddat_hist$NeHerr,na.rm=TRUE)

max(momidat$NeCerr)
max(stairwaydat$NeCerr)
max(gonedat$NeCerr)
max(lddat_contemp$NeCerr,na.rm=TRUE)

max(momidat$ratioerr)
max(stairwaydat$ratioerr)
max(gonedat$ratioerr)
max(lddat_hist$ratioerr,na.rm=TRUE)

momidat$sampn=as.integer(gsub('n','',momidat$sampn))
gonedat$sampn=as.integer(gsub('n','',gonedat$sampn))
stairwaydat$sampn=as.integer(gsub('n','',stairwaydat$sampn))

##let's just use 50k SNPs for non-WGS
#momi_rad10k_contemp <- subset(momidat, data=="rad10k" & scheme=="t0")
momi_rad50k_contemp <- subset(momidat, data=="rad50k" & scheme=="t0")
#momi_rad10k_2samp <- subset(momidat, data=="rad10k" & scheme=="t0t120")
momi_rad50k_2samp <- subset(momidat, data=="rad50k" & scheme=="t0t120")
#momi_rad10k_serial <- subset(momidat, data=="rad10k" & scheme=="all")
momi_rad50k_serial <- subset(momidat, data=="rad50k" & scheme=="all")
momi_wgs_contemp <- subset(momidat, data=="wgs" & scheme=="t0")
momi_wgs_2samp <- subset(momidat, data=="wgs" & scheme=="t0t120")
momi_wgs_serial <- subset(momidat, data=="wgs" & scheme=="all")

#momi_rad10k_contemp_agg=aggregate(momi_rad10k_contemp,list(momi_rad10k_contemp$sampn),mean)
momi_rad50k_contemp_agg=aggregate(momi_rad50k_contemp,list(momi_rad50k_contemp$sampn),mean)
#momi_rad10k_2samp_agg=aggregate(momi_rad10k_2samp,list(momi_rad10k_2samp$sampn),mean)
momi_rad50k_2samp_agg=aggregate(momi_rad50k_2samp,list(momi_rad50k_2samp$sampn),mean)
#momi_rad10k_serial_agg=aggregate(momi_rad10k_serial,list(momi_rad10k_serial$sampn),mean)
momi_rad50k_serial_agg=aggregate(momi_rad50k_serial,list(momi_rad50k_serial$sampn),mean)

momi_wgs_contemp_agg=aggregate(momi_wgs_contemp,list(momi_wgs_contemp$sampn),mean)
momi_wgs_2samp_agg=aggregate(momi_wgs_2samp,list(momi_wgs_2samp$sampn),mean)
momi_wgs_serial_agg=aggregate(momi_wgs_serial,list(momi_wgs_serial$sampn),mean)

#momi_wgs_contemp_sd=aggregate(momi_wgs_contemp,list(momi_wgs_contemp$sampn),sd)
#momi_wgs_2samp_sd=aggregate(momi_wgs_2samp,list(momi_wgs_2samp$sampn),sd)
#momi_wgs_serial_sd=aggregate(momi_wgs_serial,list(momi_wgs_serial$sampn),sd)

gone_agg=aggregate(gonedat,list(gonedat$sampn),mean)

stairway_agg=aggregate(stairwaydat,list(stairwaydat$sampn),mean)

## NeEst - also just using rad50k
lddat_rad50k_contemp <- na.omit(subset(lddat_contemp, nloc=="50k" & scheme == "2samp"))
lddat_contemp_agg=aggregate(lddat_rad50k_contemp,list(lddat_rad50k_contemp$nsamp),mean)
lddat_rad50k_hist <- na.omit(subset(lddat_hist, nloc=="50k" & scheme == "2samp"))
lddat_hist_agg=aggregate(lddat_rad50k_hist,list(lddat_rad50k_hist$nsamp),mean)

### plotting mean absolute error for NeH

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,1.2),xlab="Sample Size", ylab="Error",main=expression(paste(N[E],'Historic')),cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeHerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeHerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeHerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeHerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeHerr,col="orange",lwd=2)

points(lddat_hist_agg$Group.1,lddat_hist_agg$NeHerr,pch=16,col="gray",cex=2)
lines(lddat_hist_agg$Group.1,lddat_hist_agg$NeHerr,col="gray",lwd=2)

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.45),xlab="Sample Size", ylab="Error",main="NeHistoric",cex.lab=1.4,cex.main=1.4)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeHerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1-4,momi_wgs_serial_agg$NeHerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1-4,momi_wgs_serial_agg$NeHerr,col="orange",lwd=2)
points(gone_agg$Group.1-6,gone_agg$NeHerr,pch=17,col="purple",cex=2)
lines(gone_agg$Group.1-6,gone_agg$NeHerr,col="purple",lwd=2)
points(stairway_agg$Group.1-8,stairway_agg$NeHerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1-8,stairway_agg$NeHerr,col="black",lwd=2)

legend(x=0,y=1.2,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE","NeEstimator"),lty=c(1,1,1,1,1,1),col=c("blue","green","orange","black","purple","gray"))

text(x=100,y=0.27,labels="generation time = 1 year")

##NeC##

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,1.5),xlab="Sample Size", ylab="Error",main=expression(paste(N[E],'Contemporary')),cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeCerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeCerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeCerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeCerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeCerr,col="orange",lwd=2)

points(lddat_hist_agg$Group.1,lddat_hist_agg$NeHerr,pch=16,col="gray",cex=2)
lines(lddat_hist_agg$Group.1,lddat_hist_agg$NeHerr,col="gray",lwd=2)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeCerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1-4,momi_wgs_2samp_agg$NeCerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1-4,momi_wgs_2samp_agg$NeCerr,col="orange",lwd=2)
points(gone_agg$Group.1-6,gone_agg$NeCerr,pch=17,col="purple",cex=2)
lines(gone_agg$Group.1-6,gone_agg$NeCerr,col="purple",lwd=2)
points(stairway_agg$Group.1-8,stairway_agg$NeCerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1-8,stairway_agg$NeCerr,col="black",lwd=2)

#legend(x=0,y=1.5,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE","NeEstimator"),lty=c(1,1,1,1,1,1),col=c("blue","green","orange","black","purple","gray"))
text(x=150,y=2.3,labels="generation time = 1 year")



##### no NeEst, 5-95% quantiles

momi_rad50k_contemp_n50nehq=quantile(subset(momi_rad50k_contemp,sampn==50)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n50nehq=quantile(subset(momi_rad50k_2samp,sampn==50)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_serial_n50nehq=quantile(subset(momi_rad50k_serial,sampn==50)$NeHerr,probs=c(0.05,0.95))

momi_rad50k_contemp_n100nehq=quantile(subset(momi_rad50k_contemp,sampn==100)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n100nehq=quantile(subset(momi_rad50k_2samp,sampn==100)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_serial_n100nehq=quantile(subset(momi_rad50k_serial,sampn==100)$NeHerr,probs=c(0.05,0.95))

momi_rad50k_contemp_n200nehq=quantile(subset(momi_rad50k_contemp,sampn==200)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n200nehq=quantile(subset(momi_rad50k_2samp,sampn==200)$NeHerr,probs=c(0.05,0.95))
momi_rad50k_serial_n200nehq=quantile(subset(momi_rad50k_serial,sampn==200)$NeHerr,probs=c(0.05,0.95))

momi_rad50k_contemp_nehqs=rbind(momi_rad50k_contemp_n50nehq,momi_rad50k_contemp_n100nehq,momi_rad50k_contemp_n200nehq)
momi_rad50k_2samp_nehqs=rbind(momi_rad50k_2samp_n50nehq,momi_rad50k_2samp_n100nehq,momi_rad50k_2samp_n200nehq)
momi_rad50k_serial_nehqs=rbind(momi_rad50k_serial_n50nehq,momi_rad50k_serial_n100nehq,momi_rad50k_serial_n200nehq)

#####

momi_wgs_contemp_n20nehq=quantile(subset(momi_wgs_contemp,sampn==20)$NeHerr,probs=c(0.05,0.95))
momi_wgs_2samp_n20nehq=quantile(subset(momi_wgs_2samp,sampn==20)$NeHerr,probs=c(0.05,0.95))
momi_wgs_serial_n20nehq=quantile(subset(momi_wgs_serial,sampn==20)$NeHerr,probs=c(0.05,0.95))

momi_wgs_contemp_n50nehq=quantile(subset(momi_wgs_contemp,sampn==50)$NeHerr,probs=c(0.05,0.95))
momi_wgs_2samp_n50nehq=quantile(subset(momi_wgs_2samp,sampn==50)$NeHerr,probs=c(0.05,0.95))
momi_wgs_serial_n50nehq=quantile(subset(momi_wgs_serial,sampn==50)$NeHerr,probs=c(0.05,0.95))

momi_wgs_contemp_n100nehq=quantile(subset(momi_wgs_contemp,sampn==100)$NeHerr,probs=c(0.05,0.95))
momi_wgs_2samp_n100nehq=quantile(subset(momi_wgs_2samp,sampn==100)$NeHerr,probs=c(0.05,0.95))
momi_wgs_serial_n100nehq=quantile(subset(momi_wgs_serial,sampn==100)$NeHerr,probs=c(0.05,0.95))

momi_wgs_contemp_nehqs=rbind(momi_wgs_contemp_n20nehq,momi_wgs_contemp_n50nehq,momi_wgs_contemp_n100nehq)
momi_wgs_2samp_nehqs=rbind(momi_wgs_2samp_n20nehq,momi_wgs_2samp_n50nehq,momi_wgs_2samp_n100nehq)
momi_wgs_serial_nehqs=rbind(momi_wgs_serial_n20nehq,momi_wgs_serial_n50nehq,momi_wgs_serial_n100nehq)

####

momi_rad50k_contemp_n50necq=quantile(subset(momi_rad50k_contemp,sampn==50)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n50necq=quantile(subset(momi_rad50k_2samp,sampn==50)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_serial_n50necq=quantile(subset(momi_rad50k_serial,sampn==50)$NeCerr,probs=c(0.05,0.95))

momi_rad50k_contemp_n100necq=quantile(subset(momi_rad50k_contemp,sampn==100)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n100necq=quantile(subset(momi_rad50k_2samp,sampn==100)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_serial_n100necq=quantile(subset(momi_rad50k_serial,sampn==100)$NeCerr,probs=c(0.05,0.95))

momi_rad50k_contemp_n200necq=quantile(subset(momi_rad50k_contemp,sampn==200)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_2samp_n200necq=quantile(subset(momi_rad50k_2samp,sampn==200)$NeCerr,probs=c(0.05,0.95))
momi_rad50k_serial_n200necq=quantile(subset(momi_rad50k_serial,sampn==200)$NeCerr,probs=c(0.05,0.95))

momi_rad50k_contemp_necqs=rbind(momi_rad50k_contemp_n50necq,momi_rad50k_contemp_n100necq,momi_rad50k_contemp_n200necq)
momi_rad50k_2samp_necqs=rbind(momi_rad50k_2samp_n50necq,momi_rad50k_2samp_n100necq,momi_rad50k_2samp_n200necq)
momi_rad50k_serial_necqs=rbind(momi_rad50k_serial_n50necq,momi_rad50k_serial_n100necq,momi_rad50k_serial_n200necq)

####

momi_wgs_contemp_n20necq=quantile(subset(momi_wgs_contemp,sampn==20)$NeCerr,probs=c(0.05,0.95))
momi_wgs_2samp_n20necq=quantile(subset(momi_wgs_2samp,sampn==20)$NeCerr,probs=c(0.05,0.95))
momi_wgs_serial_n20necq=quantile(subset(momi_wgs_serial,sampn==20)$NeCerr,probs=c(0.05,0.95))

momi_wgs_contemp_n50necq=quantile(subset(momi_wgs_contemp,sampn==50)$NeCerr,probs=c(0.05,0.95))
momi_wgs_2samp_n50necq=quantile(subset(momi_wgs_2samp,sampn==50)$NeCerr,probs=c(0.05,0.95))
momi_wgs_serial_n50necq=quantile(subset(momi_wgs_serial,sampn==50)$NeCerr,probs=c(0.05,0.95))

momi_wgs_contemp_n100necq=quantile(subset(momi_wgs_contemp,sampn==100)$NeCerr,probs=c(0.05,0.95))
momi_wgs_2samp_n100necq=quantile(subset(momi_wgs_2samp,sampn==100)$NeCerr,probs=c(0.05,0.95))
momi_wgs_serial_n100necq=quantile(subset(momi_wgs_serial,sampn==100)$NeCerr,probs=c(0.05,0.95))

momi_wgs_contemp_necqs=rbind(momi_wgs_contemp_n20necq,momi_wgs_contemp_n50necq,momi_wgs_contemp_n100necq)
momi_wgs_2samp_necqs=rbind(momi_wgs_2samp_n20necq,momi_wgs_2samp_n50necq,momi_wgs_2samp_n100necq)
momi_wgs_serial_necqs=rbind(momi_wgs_serial_n20necq,momi_wgs_serial_n50necq,momi_wgs_serial_n100necq)

####

gone_contemp_n20nehq=quantile(subset(gonedat,sampn==20)$NeHerr,probs=c(0.05,0.95))
gone_contemp_n50nehq=quantile(subset(gonedat,sampn==50)$NeHerr,probs=c(0.05,0.95))
gone_contemp_n100nehq=quantile(subset(gonedat,sampn==100)$NeHerr,probs=c(0.05,0.95))

gone_contemp_nehqs=rbind(gone_contemp_n20nehq,gone_contemp_n50nehq,gone_contemp_n100nehq)

gone_contemp_n20necq=quantile(subset(gonedat,sampn==20)$NeCerr,probs=c(0.05,0.95))
gone_contemp_n50necq=quantile(subset(gonedat,sampn==50)$NeCerr,probs=c(0.05,0.95))
gone_contemp_n100necq=quantile(subset(gonedat,sampn==100)$NeCerr,probs=c(0.05,0.95))

gone_contemp_necqs=rbind(gone_contemp_n20necq,gone_contemp_n50necq,gone_contemp_n100necq)

####

stairway_contemp_n20nehq=quantile(subset(stairwaydat,sampn==20)$NeHerr,probs=c(0.05,0.95))
stairway_contemp_n50nehq=quantile(subset(stairwaydat,sampn==50)$NeHerr,probs=c(0.05,0.95))
stairway_contemp_n100nehq=quantile(subset(stairwaydat,sampn=100)$NeHerr,probs=c(0.05,0.95))

stairway_contemp_nehqs=rbind(stairway_contemp_n20nehq,stairway_contemp_n50nehq,stairway_contemp_n100nehq)

####

stairway_contemp_n20necq=quantile(subset(stairwaydat,sampn==20)$NeCerr,probs=c(0.05,0.95))
stairway_contemp_n50necq=quantile(subset(stairwaydat,sampn==50)$NeCerr,probs=c(0.05,0.95))
stairway_contemp_n100necq=quantile(subset(stairwaydat,sampn=100)$NeCerr,probs=c(0.05,0.95))

stairway_contemp_necqs=rbind(stairway_contemp_n20necq,stairway_contemp_n50necq,stairway_contemp_n100necq)

####

##### with NeEst, 10-90% quantiles

momi_rad50k_contemp_n50nehq=quantile(subset(momi_rad50k_contemp,sampn==50)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n50nehq=quantile(subset(momi_rad50k_2samp,sampn==50)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_serial_n50nehq=quantile(subset(momi_rad50k_serial,sampn==50)$NeHerr,probs=c(0.1,0.9))

momi_rad50k_contemp_n100nehq=quantile(subset(momi_rad50k_contemp,sampn==100)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n100nehq=quantile(subset(momi_rad50k_2samp,sampn==100)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_serial_n100nehq=quantile(subset(momi_rad50k_serial,sampn==100)$NeHerr,probs=c(0.1,0.9))

momi_rad50k_contemp_n200nehq=quantile(subset(momi_rad50k_contemp,sampn==200)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n200nehq=quantile(subset(momi_rad50k_2samp,sampn==200)$NeHerr,probs=c(0.1,0.9))
momi_rad50k_serial_n200nehq=quantile(subset(momi_rad50k_serial,sampn==200)$NeHerr,probs=c(0.1,0.9))

momi_rad50k_contemp_nehqs=rbind(momi_rad50k_contemp_n50nehq,momi_rad50k_contemp_n100nehq,momi_rad50k_contemp_n200nehq)
momi_rad50k_2samp_nehqs=rbind(momi_rad50k_2samp_n50nehq,momi_rad50k_2samp_n100nehq,momi_rad50k_2samp_n200nehq)
momi_rad50k_serial_nehqs=rbind(momi_rad50k_serial_n50nehq,momi_rad50k_serial_n100nehq,momi_rad50k_serial_n200nehq)

#####

momi_wgs_contemp_n20nehq=quantile(subset(momi_wgs_contemp,sampn==20)$NeHerr,probs=c(0.1,0.9))
momi_wgs_2samp_n20nehq=quantile(subset(momi_wgs_2samp,sampn==20)$NeHerr,probs=c(0.1,0.9))
momi_wgs_serial_n20nehq=quantile(subset(momi_wgs_serial,sampn==20)$NeHerr,probs=c(0.1,0.9))

momi_wgs_contemp_n50nehq=quantile(subset(momi_wgs_contemp,sampn==50)$NeHerr,probs=c(0.1,0.9))
momi_wgs_2samp_n50nehq=quantile(subset(momi_wgs_2samp,sampn==50)$NeHerr,probs=c(0.1,0.9))
momi_wgs_serial_n50nehq=quantile(subset(momi_wgs_serial,sampn==50)$NeHerr,probs=c(0.1,0.9))

momi_wgs_contemp_n100nehq=quantile(subset(momi_wgs_contemp,sampn==100)$NeHerr,probs=c(0.1,0.9))
momi_wgs_2samp_n100nehq=quantile(subset(momi_wgs_2samp,sampn==100)$NeHerr,probs=c(0.1,0.9))
momi_wgs_serial_n100nehq=quantile(subset(momi_wgs_serial,sampn==100)$NeHerr,probs=c(0.1,0.9))

momi_wgs_contemp_nehqs=rbind(momi_wgs_contemp_n20nehq,momi_wgs_contemp_n50nehq,momi_wgs_contemp_n100nehq)
momi_wgs_2samp_nehqs=rbind(momi_wgs_2samp_n20nehq,momi_wgs_2samp_n50nehq,momi_wgs_2samp_n100nehq)
momi_wgs_serial_nehqs=rbind(momi_wgs_serial_n20nehq,momi_wgs_serial_n50nehq,momi_wgs_serial_n100nehq)

####

momi_rad50k_contemp_n50necq=quantile(subset(momi_rad50k_contemp,sampn==50)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n50necq=quantile(subset(momi_rad50k_2samp,sampn==50)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_serial_n50necq=quantile(subset(momi_rad50k_serial,sampn==50)$NeCerr,probs=c(0.1,0.9))

momi_rad50k_contemp_n100necq=quantile(subset(momi_rad50k_contemp,sampn==100)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n100necq=quantile(subset(momi_rad50k_2samp,sampn==100)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_serial_n100necq=quantile(subset(momi_rad50k_serial,sampn==100)$NeCerr,probs=c(0.1,0.9))

momi_rad50k_contemp_n200necq=quantile(subset(momi_rad50k_contemp,sampn==200)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_2samp_n200necq=quantile(subset(momi_rad50k_2samp,sampn==200)$NeCerr,probs=c(0.1,0.9))
momi_rad50k_serial_n200necq=quantile(subset(momi_rad50k_serial,sampn==200)$NeCerr,probs=c(0.1,0.9))

momi_rad50k_contemp_necqs=rbind(momi_rad50k_contemp_n50necq,momi_rad50k_contemp_n100necq,momi_rad50k_contemp_n200necq)
momi_rad50k_2samp_necqs=rbind(momi_rad50k_2samp_n50necq,momi_rad50k_2samp_n100necq,momi_rad50k_2samp_n200necq)
momi_rad50k_serial_necqs=rbind(momi_rad50k_serial_n50necq,momi_rad50k_serial_n100necq,momi_rad50k_serial_n200necq)

####

momi_wgs_contemp_n20necq=quantile(subset(momi_wgs_contemp,sampn==20)$NeCerr,probs=c(0.1,0.9))
momi_wgs_2samp_n20necq=quantile(subset(momi_wgs_2samp,sampn==20)$NeCerr,probs=c(0.1,0.9))
momi_wgs_serial_n20necq=quantile(subset(momi_wgs_serial,sampn==20)$NeCerr,probs=c(0.1,0.9))

momi_wgs_contemp_n50necq=quantile(subset(momi_wgs_contemp,sampn==50)$NeCerr,probs=c(0.1,0.9))
momi_wgs_2samp_n50necq=quantile(subset(momi_wgs_2samp,sampn==50)$NeCerr,probs=c(0.1,0.9))
momi_wgs_serial_n50necq=quantile(subset(momi_wgs_serial,sampn==50)$NeCerr,probs=c(0.1,0.9))

momi_wgs_contemp_n100necq=quantile(subset(momi_wgs_contemp,sampn==100)$NeCerr,probs=c(0.1,0.9))
momi_wgs_2samp_n100necq=quantile(subset(momi_wgs_2samp,sampn==100)$NeCerr,probs=c(0.1,0.9))
momi_wgs_serial_n100necq=quantile(subset(momi_wgs_serial,sampn==100)$NeCerr,probs=c(0.1,0.9))

momi_wgs_contemp_necqs=rbind(momi_wgs_contemp_n20necq,momi_wgs_contemp_n50necq,momi_wgs_contemp_n100necq)
momi_wgs_2samp_necqs=rbind(momi_wgs_2samp_n20necq,momi_wgs_2samp_n50necq,momi_wgs_2samp_n100necq)
momi_wgs_serial_necqs=rbind(momi_wgs_serial_n20necq,momi_wgs_serial_n50necq,momi_wgs_serial_n100necq)

####

gone_contemp_n20nehq=quantile(subset(gonedat,sampn==20)$NeHerr,probs=c(0.1,0.9))
gone_contemp_n50nehq=quantile(subset(gonedat,sampn==50)$NeHerr,probs=c(0.1,0.9))
gone_contemp_n100nehq=quantile(subset(gonedat,sampn==100)$NeHerr,probs=c(0.1,0.9))

gone_contemp_nehqs=rbind(gone_contemp_n20nehq,gone_contemp_n50nehq,gone_contemp_n100nehq)

gone_contemp_n20necq=quantile(subset(gonedat,sampn==20)$NeCerr,probs=c(0.1,0.9))
gone_contemp_n50necq=quantile(subset(gonedat,sampn==50)$NeCerr,probs=c(0.1,0.9))
gone_contemp_n100necq=quantile(subset(gonedat,sampn==100)$NeCerr,probs=c(0.1,0.9))

gone_contemp_necqs=rbind(gone_contemp_n20necq,gone_contemp_n50necq,gone_contemp_n100necq)

####

stairway_contemp_n20nehq=quantile(subset(stairwaydat,sampn==20)$NeHerr,probs=c(0.1,0.9))
stairway_contemp_n50nehq=quantile(subset(stairwaydat,sampn==50)$NeHerr,probs=c(0.1,0.9))
stairway_contemp_n100nehq=quantile(subset(stairwaydat,sampn=100)$NeHerr,probs=c(0.1,0.9))

stairway_contemp_nehqs=rbind(stairway_contemp_n20nehq,stairway_contemp_n50nehq,stairway_contemp_n100nehq)

####

stairway_contemp_n20necq=quantile(subset(stairwaydat,sampn==20)$NeCerr,probs=c(0.1,0.9))
stairway_contemp_n50necq=quantile(subset(stairwaydat,sampn==50)$NeCerr,probs=c(0.1,0.9))
stairway_contemp_n100necq=quantile(subset(stairwaydat,sampn=100)$NeCerr,probs=c(0.1,0.9))

stairway_contemp_necqs=rbind(stairway_contemp_n20necq,stairway_contemp_n50necq,stairway_contemp_n100necq)

####

ld_rad50k_2samp_n100necq=quantile(subset(lddat_rad50k_contemp,nsamp==100)$NeCerr,probs=c(0.1,0.9))
ld_rad50k_2samp_n200necq=quantile(subset(lddat_rad50k_contemp,nsamp==200)$NeCerr,probs=c(0.1,0.9))
ld_rad50k_2samp_necqs=rbind(ld_rad50k_2samp_n100necq,ld_rad50k_2samp_n200necq)

ld_rad50k_2samp_n100nehq=quantile(subset(lddat_rad50k_hist,nsamp==100)$NeHerr,probs=c(0.1,0.9))
ld_rad50k_2samp_n200nehq=quantile(subset(lddat_rad50k_hist,nsamp==200)$NeHerr,probs=c(0.1,0.9))
ld_rad50k_2samp_nehqs=rbind(ld_rad50k_2samp_n100nehq,ld_rad50k_2samp_n200nehq)

####


### plotting mean absolute error for NeH

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.45),xlab="Sample Size", ylab="Error",main=expression(paste(N[E],'Historic')),cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeHerr,pch=16,col="blue",cex=1)
lines(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeHerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeHerr,pch=16,col="green",cex=1)
lines(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeHerr,pch=16,col="orange",cex=1)
lines(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeHerr,col="orange",lwd=2)

segments(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_nehqs[,1],momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_nehqs[,2])
segments(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_nehqs[,1],momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_nehqs[,2])
segments(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_nehqs[,1],momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_nehqs[,2])

points(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_agg$NeHerr,pch=17,col="blue",cex=1)
lines(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeHerr,pch=17,col="green",cex=1)
lines(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_wgs_serial_agg$NeHerr,pch=17,col="orange",cex=1)
lines(momi_wgs_serial_agg$Group.1,momi_wgs_serial_agg$NeHerr,col="orange",lwd=2)

segments(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_nehqs[,1],momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_nehqs[,2])
segments(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_nehqs[,1],momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_nehqs[,2])
segments(momi_wgs_serial_agg$Group.1,momi_wgs_serial_nehqs[,1],momi_wgs_serial_agg$Group.1,momi_wgs_serial_nehqs[,2])

points(gone_agg$Group.1-6,gone_agg$NeHerr,pch=17,col="purple",cex=1)
lines(gone_agg$Group.1-6,gone_agg$NeHerr,col="purple",lwd=1)

segments(gone_agg$Group.1-6,gone_contemp_nehqs[,1],gone_agg$Group.1-6,gone_contemp_nehqs[,2])

points(stairway_agg$Group.1-8,stairway_agg$NeHerr,pch=17,col="black",cex=1)
lines(stairway_agg$Group.1-8,stairway_agg$NeHerr,col="black",lwd=1)

segments(stairway_agg$Group.1-8,stairway_contemp_nehqs[,1],stairway_agg$Group.1-8,stairway_contemp_nehqs[,2])

legend(x=120,y=0.4,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE"),lty=c(1,1,1,1,1,1),col=c("blue","green","orange","black","purple"))

text(x=100,y=0.45,labels="generation time = 1 year")


### plotting mean absolute error for NeC

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,2.8),xlab="Sample Size", ylab="Error",main=expression(paste(N[E],'Historic')),cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeCerr,pch=16,col="blue",cex=1)
#lines(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_agg$NeCerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeCerr,pch=16,col="green",cex=1)
#lines(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeCerr,pch=16,col="orange",cex=1)
#lines(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_agg$NeCerr,col="orange",lwd=2)

segments(momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_necqs[,1],momi_rad50k_contemp_agg$Group.1+2,momi_rad50k_contemp_necqs[,2])
segments(momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_necqs[,1],momi_rad50k_2samp_agg$Group.1+4,momi_rad50k_2samp_necqs[,2])
segments(momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_necqs[,1],momi_rad50k_serial_agg$Group.1+6,momi_rad50k_serial_necqs[,2])

points(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_agg$NeCerr,pch=17,col="blue",cex=1)
#lines(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeCerr,pch=17,col="green",cex=1)
#lines(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_wgs_serial_agg$NeCerr,pch=17,col="orange",cex=1)
#lines(momi_wgs_serial_agg$Group.1,momi_wgs_serial_agg$NeCerr,col="orange",lwd=2)

segments(momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_necqs[,1],momi_wgs_contemp_agg$Group.1-4,momi_wgs_contemp_necqs[,2])
segments(momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_necqs[,1],momi_wgs_2samp_agg$Group.1-2,momi_wgs_2samp_necqs[,2])
segments(momi_wgs_serial_agg$Group.1,momi_wgs_serial_necqs[,1],momi_wgs_serial_agg$Group.1,momi_wgs_serial_necqs[,2])

points(gone_agg$Group.1-6,gone_agg$NeCerr,pch=17,col="purple",cex=1)
#lines(gone_agg$Group.1-6,gone_agg$NeCerr,col="purple",lwd=1)

segments(gone_agg$Group.1-6,gone_contemp_necqs[,1],gone_agg$Group.1-6,gone_contemp_necqs[,2])

points(stairway_agg$Group.1-8,stairway_agg$NeCerr,pch=17,col="black",cex=1)
#lines(stairway_agg$Group.1-8,stairway_agg$NeCerr,col="black",lwd=1)

segments(stairway_agg$Group.1-8,stairway_contemp_necqs[,1],stairway_agg$Group.1-8,stairway_contemp_necqs[,2])


legend(x=120,y=2.5,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE"),lty=c(1,1,1,1,1,1),col=c("blue","green","orange","black","purple"))

text(x=100,y=2.7,labels="generation time = 1 year")



#### plot 'em categorically, with NeEst and 10-90% quantiles

#fixing color scheme/legend 042722

#### NeHistoric

pdf (file="plots/AveError_NeH_revised0427.pdf",width=8,height=6)

plot(x=NULL,y=NULL,xlim=c(0,95),xaxt='n',ylim=c(0,230),xlab="Sample Size", ylab="% Error",main=expression(hat(N)["E,H"]),cex.lab=1.4,cex.main=1.4)

points(c(35,60,85),momi_rad50k_contemp_agg$NeHerr*100,pch=1,col="cornflowerblue",cex=1)
points(c(35,60,85)+2,momi_rad50k_2samp_agg$NeHerr*100,pch=0,col="cornflowerblue",cex=1)
points(c(35,60,85)+4,momi_rad50k_serial_agg$NeHerr*100,pch=2,col="cornflowerblue",cex=1)
segments(c(35,60,85),momi_rad50k_contemp_nehqs[,1]*100,c(35,60,85),momi_rad50k_contemp_nehqs[,2]*100,col="cornflowerblue")
segments(c(35,60,85)+2,momi_rad50k_2samp_nehqs[,1]*100,c(35,60,85)+2,momi_rad50k_2samp_nehqs[,2]*100,col="cornflowerblue")
segments(c(35,60,85)+4,momi_rad50k_serial_nehqs[,1]*100,c(35,60,85)+4,momi_rad50k_serial_nehqs[,2]*100,col="cornflowerblue")

points(c(10,35,60)-6,momi_wgs_contemp_agg$NeHerr*100,pch=1,col="darkblue",cex=1)
points(c(10,35,60)-4,momi_wgs_2samp_agg$NeHerr*100,pch=0,col="darkblue",cex=1)
points(c(10,35,60)-2,momi_wgs_serial_agg$NeHerr*100,pch=2,col="darkblue",cex=1)
segments(c(10,35,60)-6,momi_wgs_contemp_nehqs[,1]*100,c(10,35,60)-6,momi_wgs_contemp_nehqs[,2]*100,col="darkblue")
segments(c(10,35,60)-4,momi_wgs_2samp_nehqs[,1]*100,c(10,35,60)-4,momi_wgs_2samp_nehqs[,2]*100,col="darkblue")
segments(c(10,35,60)-2,momi_wgs_serial_nehqs[,1]*100,c(10,35,60)-2,momi_wgs_serial_nehqs[,2]*100,col="darkblue")

points(c(10,35,60)-10,gone_agg$NeHerr*100,pch=1,col="green",cex=1)
segments(c(10,35,60)-10,gone_contemp_nehqs[,1]*100,c(10,35,60)-10,gone_contemp_nehqs[,2]*100,col="green")

points(c(10,35,60)-8,stairway_agg$NeHerr*100,pch=1,col="orange",cex=1)
segments(c(10,35,60)-8,stairway_contemp_nehqs[,1]*100,c(10,35,60)-8,stairway_contemp_nehqs[,2]*100,col="orange")

points(c(60,85)+8,lddat_hist_agg$NeHerr*100,pch=0,col="gray",cex=1)
segments(c(60,85)+8,ld_rad50k_2samp_nehqs[,1]*100,c(60,85)+8,ld_rad50k_2samp_nehqs[,2]*100,col="gray")

#legend(x=0,y=220,legend=c("GONE, WGS, contemporary","Stairway, WGS, contemporary","momi2, WGS, contemporary","momi2, WGS, two samples","momi2, WGS, serial","momi2, RAD, contemporary","momi2, RAD, two samples","momi2, RAD, serial","NeEst, RAD, two samples"),pch=c(2,2,2,2,2,1,1,1,1),col=c("purple","black","blue","green","orange","blue","green","orange","gray"),cex=0.8)

legend(x=0,y=220,legend=c("GONE","Stairway","momi2/WGS","momi2/RAD","NeEst"),lty=c(1,1,1,1,1),col=c("green","orange","darkblue","cornflowerblue","gray"),cex=0.8,bty='n')

legend(x=40,y=220,legend=c("Contemporary only","Two samples","Serial sampling"),pch=c(1,0,2),cex=0.8,bty='n')


axis(1,at=c(4,32,58,88),labels=c("20","50","100","200"),tick=FALSE)

dev.off()

#### NeContemporary

pdf (file="plots/AveError_NeC_revised0427.pdf",width=8,height=6)

plot(x=NULL,y=NULL,xlim=c(0,95),xaxt='n',ylim=c(0,230),xlab="Sample Size", ylab="% Error",main=expression(hat(N)["E,C"]),cex.lab=1.4,cex.main=1.4)

points(c(35,60,85),momi_rad50k_contemp_agg$NeCerr*100,pch=1,col="cornflowerblue",cex=1)
points(c(35,60,85)+2,momi_rad50k_2samp_agg$NeCerr*100,pch=0,col="cornflowerblue",cex=1)
points(c(35,60,85)+4,momi_rad50k_serial_agg$NeCerr*100,pch=2,col="cornflowerblue",cex=1)
segments(c(35,60,85),momi_rad50k_contemp_necqs[,1]*100,c(35,60,85),momi_rad50k_contemp_necqs[,2]*100,col="cornflowerblue")
segments(c(35,60,85)+2,momi_rad50k_2samp_necqs[,1]*100,c(35,60,85)+2,momi_rad50k_2samp_necqs[,2]*100,col="cornflowerblue")
segments(c(35,60,85)+4,momi_rad50k_serial_necqs[,1]*100,c(35,60,85)+4,momi_rad50k_serial_necqs[,2]*100,col="cornflowerblue")

points(c(10,35,60)-6,momi_wgs_contemp_agg$NeCerr*100,pch=1,col="darkblue",cex=1)
points(c(10,35,60)-4,momi_wgs_2samp_agg$NeCerr*100,pch=0,col="darkblue",cex=1)
points(c(10,35,60)-2,momi_wgs_serial_agg$NeCerr*100,pch=2,col="darkblue",cex=1)
segments(c(10,35,60)-6,momi_wgs_contemp_necqs[,1]*100,c(10,35,60)-6,momi_wgs_contemp_necqs[,2]*100,col="darkblue")
segments(c(10,35,60)-4,momi_wgs_2samp_necqs[,1]*100,c(10,35,60)-4,momi_wgs_2samp_necqs[,2]*100,col="darkblue")
segments(c(10,35,60)-2,momi_wgs_serial_necqs[,1]*100,c(10,35,60)-2,momi_wgs_serial_necqs[,2]*100,col="darkblue")

points(c(10,35,60)-10,gone_agg$NeCerr*100,pch=1,col="green",cex=1)
segments(c(10,35,60)-10,gone_contemp_necqs[,1]*100,c(10,35,60)-10,gone_contemp_necqs[,2]*100,col="green")

points(c(10,35,60)-8,stairway_agg$NeCerr*100,pch=1,col="orange",cex=1)
segments(c(10,35,60)-8,stairway_contemp_necqs[,1]*100,c(10,35,60)-8,stairway_contemp_necqs[,2]*100,col="orange")

points(c(60,85)+8,lddat_contemp_agg$NeCerr[2:3]*100,pch=0,col="gray",cex=1)
segments(c(60,85)+8,ld_rad50k_2samp_necqs[,1]*100,c(60,85)+8,ld_rad50k_2samp_necqs[,2]*100,col="gray")

#legend(x=0,y=220,legend=c("GONE, WGS, contemporary","Stairway, WGS, contemporary","momi2, WGS, contemporary","momi2, WGS, two samples","momi2, WGS, serial","momi2, RAD, contemporary","momi2, RAD, two samples","momi2, RAD, serial","NeEst, RAD, two samples"),pch=c(2,2,2,2,2,1,1,1,1),col=c("purple","black","blue","green","orange","blue","green","orange","gray"),cex=0.8)

#legend(x=0,y=220,legend=c("GONE","Stairway","momi2/WGS","momi2/RAD","NeEst"),lty=c(1,1,1,1,1),col=c("green","orange","darkblue","cornflowerblue","gray"),cex=0.8,bty='n')

#legend(x=40,y=220,legend=c("Contemporary only","Two samples","Serial sampling"),pch=c(1,0,2),cex=0.8,bty='n')

axis(1,at=c(4,32,58,88),labels=c("20","50","100","200"),tick=FALSE)

dev.off()


####### violin plots for rad10ks / slow declines

#### momiiiiii

##"true"/simulated t0 + t120 population sizes
tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

momidat_basic=read.csv("inferences/momi_nomaf_data_deltaAIC.csv",header=T)
momidat_basic$Neh_best=ifelse(momidat_basic$delta<0,momidat_basic$Neh,momidat_basic$Neh_change)
momidat_basic$Nec_best=ifelse(momidat_basic$delta<0,momidat_basic$Nec,momidat_basic$Nec_change)
momidat_basic$scen=paste(momidat_basic$NeAnc,momidat_basic$td,momidat_basic$lambda)
momidat_basic$trueNeH=tru$TrueNeH[match(momidat_basic$scen,tru$scen)]
momidat_basic$trueNeC=tru$TrueNec[match(momidat_basic$scen,tru$scen)]
momidat_basic$NeHerr=abs(momidat_basic$Neh_best-momidat_basic$trueNeH)/momidat_basic$trueNeH
momidat_basic$NeCerr=abs(momidat_basic$Nec_best-momidat_basic$trueNeC)/momidat_basic$trueNeC
momidat_basic$NeHrat <- momidat_basic$Neh_best/momidat_basic$trueNeH
momidat_basic$NeCrat <- momidat_basic$Nec_best/momidat_basic$trueNeC
momidat_basic$modsel=ifelse(momidat_basic$delta<0,"Change","Constant")
momidat_basic$gentime="G=1"
momidat_basic$method="momi2"

momidat_basic$col=ifelse(momidat_basic$scheme=="t0","blue",ifelse(momidat_basic$scheme=="t0t120","green","orange"))

unique(momidat_basic$scen)

momidat_basic$scen=gsub("n10e3","Ancestral N = 1k,",momidat_basic$scen)
momidat_basic$scen=gsub("n10e4","Ancestral N = 10k,",momidat_basic$scen)
momidat_basic$scen=gsub("constant constant","constant size",momidat_basic$scen)
momidat_basic$scen=gsub("td100","120 years of",momidat_basic$scen)
momidat_basic$scen=gsub("td130","90 years of",momidat_basic$scen)
momidat_basic$scen=gsub("td160","60 years of",momidat_basic$scen)
momidat_basic$scen=gsub("td190","30 years of",momidat_basic$scen)
momidat_basic$scen=gsub("l99","slow decline",momidat_basic$scen)
momidat_basic$scen=gsub("l95","rapid decline",momidat_basic$scen)

momidat_basic$data=gsub("rad10k","10K RAD loci",momidat_basic$data)
momidat_basic$data=gsub("rad50k","50K RAD loci",momidat_basic$data)
momidat_basic$data=gsub("wgs","WGS",momidat_basic$data)

momidat_basic=separate(data=momidat_basic,col=scen,into=c('NA_label','Change_label'),sep=", ")

momidat_basic$Change_label=factor(momidat_basic$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))

momidat_basic$sampn=gsub("n","n = ",momidat_basic$sampn)

momidat_basic$sampn=factor(momidat_basic$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

## do ggsave!!

#### violins

p <- ggplot(momidat_basic, aes(x=data, y=NeHrat, color=data)) + geom_violin()
p + geom_point(shape=16,size=0.5) +
  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  geom_hline(yintercept=1,linetype="dashed") +
# facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x=element_blank(),axis.title.x=element_blank()) +
  ggtitle("momi2")

ggsave("plots/momi_schemes_NeH_violin_revised0428.pdf",device="pdf")

p <- ggplot(momidat_basic, aes(x=data, y=NeCrat, color=data)) + geom_violin()
p + geom_point(shape=16,size=0.5) +
  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x=element_blank(),axis.title.x=element_blank()) +
  ggtitle("momi2")

ggsave("plots/momi_schemes_NeC_violin_revised0428.pdf",device="pdf")


#by data type: 10K RAD

#### violins

momidat_basic %>% filter(data=="10K RAD loci") -> momidat_basic_10k

p <- ggplot(momidat_basic_10k, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="cornflowerblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, 10K RAD loci")

ggsave("plots/momi_NeH_10KRAD_violin_0509.pdf",device="pdf")

p <- ggplot(momidat_basic_10k, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="cornflowerblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, 10K RAD loci")

ggsave("plots/momi_NeC_10KRAD_violin_0509.pdf",device="pdf")


#by data type: 50K RAD

#### violins

momidat_basic %>% filter(data=="50K RAD loci") -> momidat_basic_50k

p <- ggplot(momidat_basic_50k, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="cornflowerblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, 50K RAD loci")

ggsave("plots/momi_NeH_50KRAD_violin_0509.pdf",device="pdf")

p <- ggplot(momidat_basic_50k, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="cornflowerblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, 50K RAD loci")

ggsave("plots/momi_NeC_50KRAD_violin_0509.pdf",device="pdf")


#by data type: WGS

#### violins

momidat_basic %>% filter(data=="WGS") -> momidat_basic_WGS

p <- ggplot(momidat_basic_WGS, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="darkblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, WGS")

ggsave("plots/momi_NeH_WGS_violin_0509.pdf",device="pdf")

p <- ggplot(momidat_basic_WGS, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="darkblue") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("momi2, WGS loci")

ggsave("plots/momi_NeC_WGS_violin_0509.pdf",device="pdf")


#### GONE

gonedat_basic=read.csv("inferences/GONEdata.csv",header=T)
gonedat_basic$scen=paste(gonedat_basic$NeAnc,gonedat_basic$td,gonedat_basic$lambda)
gonedat_basic$trueNeH=tru$TrueNeH[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$trueNeC=tru$TrueNec[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$NeHerr=abs(gonedat_basic$Neh-gonedat_basic$trueNeH)/gonedat_basic$trueNeH
gonedat_basic$NeCerr=abs(gonedat_basic$Nec-gonedat_basic$trueNeC)/gonedat_basic$trueNeC
gonedat_basic$NeHrat <- gonedat_basic$Neh/gonedat_basic$trueNeH
gonedat_basic$NeCrat <- gonedat_basic$Nec/gonedat_basic$trueNeC
gonedat_basic$gentime="G=1"
gonedat_basic$method="GONE"

gonedat_basic$scen=gsub("n10e3","Ancestral N = 1k,",gonedat_basic$scen)
gonedat_basic$scen=gsub("n10e4","Ancestral N = 10k,",gonedat_basic$scen)
gonedat_basic$scen=gsub("constant constant","constant size",gonedat_basic$scen)
gonedat_basic$scen=gsub("td100","120 years of",gonedat_basic$scen)
gonedat_basic$scen=gsub("td130","90 years of",gonedat_basic$scen)
gonedat_basic$scen=gsub("td160","60 years of",gonedat_basic$scen)
gonedat_basic$scen=gsub("td190","30 years of",gonedat_basic$scen)
gonedat_basic$scen=gsub("l99","slow decline",gonedat_basic$scen)
gonedat_basic$scen=gsub("l95","rapid decline",gonedat_basic$scen)

gonedat_basic$sampn=gsub("n","n = ",gonedat_basic$sampn)

gonedat_basic$col="purple"

gonedat_basic$sampn=factor(gonedat_basic$sampn,levels=c("n = 20","n = 50","n = 100"))

gonedat_basic=separate(data=gonedat_basic,col=scen,into=c('NA_label','Change_label'),sep=", ")

gonedat_basic$Change_label=factor(gonedat_basic$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))


#### violins

p <- ggplot(gonedat_basic, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="green") +
#  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("GONE")

ggsave("plots/GONE_schemes_NeH_violin_revised0429.pdf",device="pdf")


p <- ggplot(gonedat_basic, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="green") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("GONE")

ggsave("plots/GONE_schemes_NeC_violin_revised0429.pdf",device="pdf")


#### stairway

stairdat_basic=read.csv("inferences/stairwaydata.csv",header=T)
stairdat_basic$scen=paste(stairdat_basic$NeAnc,stairdat_basic$td,stairdat_basic$lambda)
stairdat_basic$trueNeH=tru$TrueNeH[match(stairdat_basic$scen,tru$scen)]
stairdat_basic$trueNeC=tru$TrueNec[match(stairdat_basic$scen,tru$scen)]
stairdat_basic$NeHerr=abs(stairdat_basic$Neh-stairdat_basic$trueNeH)/stairdat_basic$trueNeH
stairdat_basic$NeCerr=abs(stairdat_basic$Nec-stairdat_basic$trueNeC)/stairdat_basic$trueNeC
stairdat_basic$NeHrat <- stairdat_basic$Neh/stairdat_basic$trueNeH
stairdat_basic$NeCrat <- stairdat_basic$Nec/stairdat_basic$trueNeC
stairdat_basic$gentime="G=1"
stairdat_basic$method="Stairway"

stairdat_basic$scen=gsub("n10e3","Ancestral N = 1k,",stairdat_basic$scen)
stairdat_basic$scen=gsub("n10e4","Ancestral N = 10k,",stairdat_basic$scen)
stairdat_basic$scen=gsub("constant constant","constant size",stairdat_basic$scen)
stairdat_basic$scen=gsub("td100","120 years of",stairdat_basic$scen)
stairdat_basic$scen=gsub("td130","90 years of",stairdat_basic$scen)
stairdat_basic$scen=gsub("td160","60 years of",stairdat_basic$scen)
stairdat_basic$scen=gsub("td190","30 years of",stairdat_basic$scen)
stairdat_basic$scen=gsub("l99","slow decline",stairdat_basic$scen)
stairdat_basic$scen=gsub("l95","rapid decline",stairdat_basic$scen)

stairdat_basic$sampn=gsub("n","n = ",stairdat_basic$sampn)

stairdat_basic$col="black"

stairdat_basic$sampn=factor(stairdat_basic$sampn,levels=c("n = 20","n = 50","n = 100"))

stairdat_basic=separate(data=stairdat_basic,col=scen,into=c('NA_label','Change_label'),sep=", ")

stairdat_basic$Change_label=factor(stairdat_basic$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))


#### violins

p <- ggplot(stairdat_basic, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="orange") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("Stairway plot")

ggsave("plots/stairway_schemes_NeH_violin_revised0429.pdf",device="pdf")


p <- ggplot(stairdat_basic, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="orange") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,10)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("Stairway plot")

ggsave("plots/stairway_schemes_NeC_violin_0429.pdf",device="pdf")




#### neestimator


lddat=read.csv("inferences/LDNeoutall.csv",header=T)
lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
lddat$tdec=paste("td",lddat$td,sep="")
lddat$tdec=gsub("tdconstant","constant",lddat$tdec)
lddat$lambda=paste("l",lddat$l,sep="")
lddat$lambda=gsub("lconstant","constant",lddat$lambda)
#lddat=lddat[which(lddat$tdec=="constant"|lddat$tdec=="td100"|lddat$tdec=="td190"&lddat$lambda=="l95"),]
lddat=lddat[which(lddat$maf==0.05),]
lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)

tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)]
lddat_hist=subset(lddat,lddat$timepoint=="t120")
lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
lddat_contemp=subset(lddat,lddat$timepoint=="t0")
lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC

lddat_temporalc=subset(lddat_contemp,lddat_contemp$scheme=="2samp"&lddat_contemp$nsamp!=50&lddat_contemp$nloc=="50k")
lddat_temporalh=subset(lddat_hist,lddat_hist$scheme=="2samp"&lddat_hist$nsamp!=50&lddat_hist$nloc=="50k")

lddat_temporalc$NeH=lddat_temporalh$Ne

#lddat_temporalc=na.omit(lddat_temporalc)

lddat_temporalc$NeHrat <- lddat_temporalc$NeH/lddat_temporalc$trueNeH
lddat_temporalc$NeCrat <- lddat_temporalc$Ne/lddat_temporalc$trueNeC

lddat_temporalc$sampn = paste("n =",lddat_temporalc$nsamp)

lddat_temporalc$scen=gsub("n10e3","Ancestral N = 1k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("n10e4","Ancestral N = 10k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("constant constant","constant size",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td100","120 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td130","90 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td160","60 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td190","30 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l99","slow decline",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l95","rapid decline",lddat_temporalc$scen)

lddat_temporalc$sampn=factor(lddat_temporalc$sampn,levels=c("n = 100","n = 200"))

lddat_temporalc=separate(data=lddat_temporalc,col=scen,into=c('NA_label','Change_label'),sep=", ")

lddat_temporalc$Change_label=factor(lddat_temporalc$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))

p <- ggplot(lddat_temporalc, aes(x=sampn, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="gray") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,100)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("NeEstimator")

ggsave("plots/neest_schemes_NeH_violin_0505.pdf",device="pdf")

p <- ggplot(lddat_temporalc, aes(x=sampn, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,size=0.5,colour="gray") +
  #  scale_color_manual(values=c("10K RAD loci"="purple","50K RAD loci"="cornflowerblue","WGS"="darkblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Number of Samples") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  facet_grid(cols=vars(Change_label),rows=vars(NA_label)) +
  scale_y_log10(limits=c(0.1,100)) +
  theme_bw() +
  theme(strip.text = element_text(size = 6),axis.text.x = element_text(angle = 30)) +
  ggtitle("NeEstimator")

ggsave("plots/neest_schemes_NeC_violin_0505.pdf",device="pdf")



#### all together now

lddat=read.csv("inferences/LDNeoutall.csv",header=T)
lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
lddat$tdec=paste("td",lddat$td,sep="")
lddat$tdec=gsub("tdconstant","constant",lddat$tdec)
lddat$lambda=paste("l",lddat$l,sep="")
lddat$lambda=gsub("lconstant","constant",lddat$lambda)
lddat=lddat[which(lddat$tdec=="constant"|lddat$tdec=="td100"|lddat$tdec=="td190"&lddat$lambda=="l95"),]
lddat=lddat[which(lddat$maf==0.05),]
lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)

tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)]
lddat_hist=subset(lddat,lddat$timepoint=="t120")
lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
lddat_contemp=subset(lddat,lddat$timepoint=="t0")
lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC

lddat_temporalc=subset(lddat_contemp,lddat_contemp$scheme=="2samp"&lddat_contemp$nsamp!=50&lddat_contemp$nloc=="50k")
lddat_temporalh=subset(lddat_hist,lddat_hist$scheme=="2samp"&lddat_hist$nsamp!=50&lddat_hist$nloc=="50k")

lddat_temporalc$NeH=lddat_temporalh$Ne

#lddat_temporalc=na.omit(lddat_temporalc)

lddat_temporalc$NeHrat <- lddat_temporalc$NeH/lddat_temporalc$trueNeH
lddat_temporalc$NeCrat <- lddat_temporalc$Ne/lddat_temporalc$trueNeC

lddat_temporalc$sampn = paste("n =",lddat_temporalc$nsamp)

lddat_temporalc$scen=gsub("n10e3","Ancestral N = 1k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("n10e4","Ancestral N = 10k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("constant constant","constant size",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td100","120 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td130","90 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td160","60 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td190","30 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l99","slow decline",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l95","rapid decline",lddat_temporalc$scen)

lddat_temporalc$sampn=factor(lddat_temporalc$sampn,levels=c("n = 100","n = 200"))

lddat_temporalc=separate(data=lddat_temporalc,col=scen,into=c('NA_label','Change_label'),sep=", ")

lddat_temporalc$Change_label=factor(lddat_temporalc$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))


lddat_temporalc$method="NeEstimator"
lddat_temporalc$data="50K RAD loci"
lddat_temporalc$scheme="Two Samples"

stairdat_basic$method="Stairway Plot"
stairdat_basic$data="WGS"
stairdat_basic$scheme="Contemporary Only"

gonedat_basic$method="GONE"
gonedat_basic$data="WGS"
gonedat_basic$scheme="Contemporary Only"

momidat_basic$method="momi2"
momidat_basic=momidat_basic[which(momidat_basic$data!="10K RAD loci"),]
momidat_basic$scheme=gsub("t0t120","Two Samples",momidat_basic$scheme)
momidat_basic$scheme=gsub("t0","Contemporary Only",momidat_basic$scheme)
momidat_basic$scheme=gsub("all","Serial Sampling",momidat_basic$scheme)

common_cols <- intersect(colnames(lddat_temporalc), colnames(stairdat_basic))

allrats=rbind(subset(lddat_temporalc,select=common_cols),subset(stairdat_basic,select=common_cols),subset(gonedat_basic,select=common_cols),subset(momidat_basic,select=common_cols))

allrats=allrats[which(allrats$Change_label=="120 years of slow decline"|allrats$Change_label=="30 years of rapid decline"|allrats$Change_label=="constant"),]

allrats$sampn=factor(allrats$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

allrats$methdat=paste(allrats$method,allrats$data,allrats$scheme,sep="/")

allrats$methdat=factor(allrats$methdat,levels=c("GONE/WGS/Contemporary Only","Stairway Plot/WGS/Contemporary Only","momi2/WGS/Contemporary Only","momi2/WGS/Two Samples","momi2/WGS/Serial Sampling","momi2/50K RAD loci/Contemporary Only","momi2/50K RAD loci/Two Samples","momi2/50K RAD loci/Serial Sampling","NeEstimator/50K RAD loci/Two Samples"))

#colorz=data.frame(unique(allrats$methdat),c("gray","orange","green","cornflowerblue","darkblue"))

#allrats$color=colorz[,2][match(allrats$methdat,colorz[,1])]


##### unlumped

#p <- ggplot(allrats, aes(x=sampn, y=NeCrat)) + geom_violin()
p <- ggplot(allrats,aes(fill=methdat, y=NeCrat, x=sampn,color=methdat)) 
p + geom_hline(yintercept=1,linetype="dashed",col="gray") +  geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("GONE/WGS/Contemporary Only"="darkblue","Stairway Plot/WGS/Contemporary Only"="darkblue","momi2/WGS/Contemporary Only"="darkblue","momi2/WGS/Two Samples"="purple","momi2/WGS/Serial Sampling"="gold","momi2/50K RAD loci/Contemporary Only"="cornflowerblue","momi2/50K RAD loci/Two Samples"="purple","momi2/50K RAD loci/Serial Sampling"="gold","NeEstimator/50K RAD loci/Two Samples"="purple"))+
  scale_fill_manual(values=c("GONE/WGS/Contemporary Only"="green","Stairway Plot/WGS/Contemporary Only"="orange","momi2/WGS/Contemporary Only"="blue","momi2/WGS/Two Samples"="blue","momi2/WGS/Serial Sampling"="blue","momi2/50K RAD loci/Contemporary Only"="cornflowerblue","momi2/50K RAD loci/Two Samples"="cornflowerblue","momi2/50K RAD loci/Serial Sampling"="cornflowerblue","NeEstimator/50K RAD loci/Two Samples"="lightgray"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Sample Size") +
  # facet_wrap(~scen) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.011,25)) +
  scale_x_discrete(expand=c(0,0.25)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/allbias_NeC_050622.pdf",device="pdf")

#legendtext=c("GONE/WGS","Stairway Plot/WGS","momi2/WGS","momi2/RAD","NeEstimator/RAD","Contemporary Only","Two Samples","Serial Sampling")
#xs=c(1.3,1.3,1.3,1.3,1.3,2.3,2.3,2.3)
#ys=c(-0.4,-0.7,-1,-1.3,-1.6,-1,-1.3,-1.6)
#legdat=data.frame(legendtext,xs,ys)

p <- ggplot(allrats,aes(fill=methdat, y=NeHrat, x=sampn,color=methdat)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false",lwd=0.25) +
  scale_color_manual(values=c("GONE/WGS/Contemporary Only"="darkblue","Stairway Plot/WGS/Contemporary Only"="darkblue","momi2/WGS/Contemporary Only"="darkblue","momi2/WGS/Two Samples"="purple","momi2/WGS/Serial Sampling"="gold","momi2/50K RAD loci/Contemporary Only"="cornflowerblue","momi2/50K RAD loci/Two Samples"="purple","momi2/50K RAD loci/Serial Sampling"="gold","NeEstimator/50K RAD loci/Two Samples"="purple"))+
  scale_fill_manual(values=c("GONE/WGS/Contemporary Only"="green","Stairway Plot/WGS/Contemporary Only"="orange","momi2/WGS/Contemporary Only"="blue","momi2/WGS/Two Samples"="blue","momi2/WGS/Serial Sampling"="blue","momi2/50K RAD loci/Contemporary Only"="cornflowerblue","momi2/50K RAD loci/Two Samples"="cornflowerblue","momi2/50K RAD loci/Serial Sampling"="cornflowerblue","NeEstimator/50K RAD loci/Two Samples"="lightgray"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Sample Size") +
  # facet_wrap(~scen) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.011,25)) +
  scale_x_discrete(expand=c(0,0.25)) +
  theme_bw() +
  theme(legend.position="none") +
  geom_rect(xmin=1.1,xmax=1.22,ymin=-0.5,ymax=-0.3,fill="green",size=0) +
  geom_rect(xmin=1.1,xmax=1.22,ymin=-0.8,ymax=-0.6,fill="orange",size=0) +
  geom_rect(xmin=1.1,xmax=1.22,ymin=-1.1,ymax=-0.9,fill="blue",size=0) +
  geom_rect(xmin=1.1,xmax=1.22,ymin=-1.4,ymax=-1.2,fill="cornflowerblue",size=0) +
  geom_rect(xmin=1.1,xmax=1.22,ymin=-1.7,ymax=-1.5,fill="gray",size=0) +
  geom_rect(xmin=2.1,xmax=2.22,ymin=-1.1,ymax=-0.9,fill="white",colour="darkblue",size=1) +
  geom_rect(xmin=2.1,xmax=2.22,ymin=-1.4,ymax=-1.2,fill="white",colour="purple",size=1) +
  geom_rect(xmin=2.1,xmax=2.22,ymin=-1.7,ymax=-1.5,fill="white",colour="gold",size=1) +
  annotate("text",x=c(1.5,1.6,1.5,1.5,1.6,2.65,2.6,2.62),y=c(0.4,0.2,0.1,0.05,0.025,0.1,0.05,0.025),label=c("GONE/WGS","Stairway Plot/WGS","momi2/WGS","momi2/RAD","NeEstimator/RAD","Contemporary Only","Two Samples","Serial Sampling"))+
  ggtitle("")

ggsave("plots/allbias_NeH_050622.pdf",device="pdf")




#### lumpy

lddat=read.csv("inferences/LDNeoutall.csv",header=T)
lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
lddat$tdec=paste("td",lddat$td,sep="")
lddat$tdec=gsub("tdconstant","constant",lddat$tdec)
lddat$lambda=paste("l",lddat$l,sep="")
lddat$lambda=gsub("lconstant","constant",lddat$lambda)
lddat=lddat[which(lddat$tdec=="constant"|lddat$tdec=="td100"|lddat$tdec=="td190"&lddat$lambda=="l95"),]
lddat=lddat[which(lddat$maf==0.05),]
lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)

tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)]
lddat_hist=subset(lddat,lddat$timepoint=="t120")
lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
lddat_contemp=subset(lddat,lddat$timepoint=="t0")
lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC

lddat_temporalc=subset(lddat_contemp,lddat_contemp$scheme=="2samp"&lddat_contemp$nsamp!=50&lddat_contemp$nloc=="50k")
lddat_temporalh=subset(lddat_hist,lddat_hist$scheme=="2samp"&lddat_hist$nsamp!=50&lddat_hist$nloc=="50k")

lddat_temporalc$NeH=lddat_temporalh$Ne

lddat_temporalc=na.omit(lddat_temporalc)

lddat_temporalc$NeHrat <- lddat_temporalc$NeH/lddat_temporalc$trueNeH
lddat_temporalc$NeCrat <- lddat_temporalc$Ne/lddat_temporalc$trueNeC

lddat_temporalc$sampn = paste("n =",lddat_temporalc$nsamp)

lddat_temporalc$scen=gsub("n10e3","Ancestral N = 1k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("n10e4","Ancestral N = 10k,",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("constant constant","constant size",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td100","120 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td130","90 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td160","60 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("td190","30 years of",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l99","slow decline",lddat_temporalc$scen)
lddat_temporalc$scen=gsub("l95","rapid decline",lddat_temporalc$scen)

lddat_temporalc$sampn=factor(lddat_temporalc$sampn,levels=c("n = 100","n = 200"))

lddat_temporalc=separate(data=lddat_temporalc,col=scen,into=c('NA_label','Change_label'),sep=", ")

lddat_temporalc$Change_label=factor(lddat_temporalc$Change_label,levels=c("constant size","30 years of rapid decline","30 years of slow decline","60 years of slow decline","90 years of slow decline","120 years of slow decline"))


lddat_temporalc$method="NeEstimator"
lddat_temporalc$data="50K RAD loci"

stairdat_basic$method="Stairway Plot"
stairdat_basic$data="WGS"

gonedat_basic$method="GONE"
gonedat_basic$data="WGS"

momidat_basic$method="momi2"
momidat_basic=momidat_basic[which(momidat_basic$data!="10K RAD loci"),]

common_cols <- intersect(colnames(lddat_temporalc), colnames(stairdat_basic))

allrats=rbind(subset(lddat_temporalc,select=common_cols),subset(stairdat_basic,select=common_cols),subset(gonedat_basic,select=common_cols),subset(momidat_basic,select=common_cols))

allrats=allrats[which(allrats$Change_label=="120 years of slow decline"|allrats$Change_label=="30 years of rapid decline"|allrats$Change_label=="constant"),]

allrats$sampn=factor(allrats$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

allrats$methdat=paste(allrats$method, allrats$data,sep="/")

allrats$methdat=factor(allrats$methdat,levels=c("GONE/WGS","Stairway Plot/WGS","momi2/WGS","momi2/50K RAD loci","NeEstimator/50K RAD loci"))

#colorz=data.frame(unique(allrats$methdat),c("gray","orange","green","cornflowerblue","darkblue"))

#allrats$color=colorz[,2][match(allrats$methdat,colorz[,1])]

#p <- ggplot(allrats, aes(x=sampn, y=NeCrat)) + geom_violin()


#### lumped by scheme

p <- ggplot(allrats,aes(fill=methdat, y=NeCrat, x=sampn,color=methdat)) 
p+  geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("NeEstimator/50K RAD loci"="lightgray","Stairway Plot/WGS"="orange","GONE/WGS"="green","momi2/WGS"="darkblue","momi2/50K RAD loci"="cornflowerblue"))+
  scale_fill_manual(values=c("NeEstimator/50K RAD loci"="lightgray","Stairway Plot/WGS"="orange","GONE/WGS"="green","momi2/WGS"="darkblue","momi2/50K RAD loci"="cornflowerblue"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("Sample Size") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.01,30)) +
  theme_bw() +
  ggtitle("")

ggsave("plots/allbias_NeC_050522.pdf",device="pdf")

p <- ggplot(allrats,aes(fill=methdat, y=NeHrat, x=sampn,color=methdat)) 
p+  geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("NeEstimator/50K RAD loci"="lightgray","Stairway Plot/WGS"="orange","GONE/WGS"="green","momi2/WGS"="darkblue","momi2/50K RAD loci"="cornflowerblue"))+
  scale_fill_manual(values=c("NeEstimator/50K RAD loci"="lightgray","Stairway Plot/WGS"="orange","GONE/WGS"="green","momi2/WGS"="darkblue","momi2/50K RAD loci"="cornflowerblue"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("Sample Size") +
  geom_hline(yintercept=1,linetype="dashed") +
  # facet_wrap(~scen) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.01,30)) +
  theme_bw() +
  ggtitle("")

ggsave("plots/allbias_NeH_050522.pdf",device="pdf")
