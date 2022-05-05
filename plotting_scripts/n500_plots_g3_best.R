par(mai=c(1.1,1.1,1.1,0.1))

momidat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/momi_nomaf_data_g3_deltaAIC.csv",header=T)

momidat$Neh_best=ifelse(momidat$delta>0,momidat$Neh_change,momidat$Neh)
momidat$Nec_best=ifelse(momidat$delta>0,momidat$Nec_change,momidat$Nec)

stairwaydat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/stairwaydata_g3.csv",header=T)
gonedat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/GONEdata_g3.csv",header=T)
#lddat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/LDNeoutall.csv",header=T)
tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
momidat$scen=paste(momidat$NeAnc,momidat$td,momidat$lambda)
gonedat$scen=paste(gonedat$NeAnc,gonedat$td,gonedat$lambda)
stairwaydat$scen=paste(stairwaydat$NeAnc,stairwaydat$td,stairwaydat$lambda)
#lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
#lddat$tdec=paste("td",lddat$td,sep="")
#lddat$lambda=paste("l",lddat$l,sep="")
#lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)
momidat$td=abs(as.integer(gsub('td','',momidat$td))-220)

momidat$trueNeH=tru$TrueNeH[match(momidat$scen,tru$scen)]
momidat$trueNeC=tru$TrueNec[match(momidat$scen,tru$scen)]
momidat$NeHerr=abs(momidat$Neh_best-momidat$trueNeH)/momidat$trueNeH
momidat$NeCerr=abs(momidat$Nec_best-momidat$trueNeC)/momidat$trueNeC
momidat$ratioerr=abs((momidat$Neh_best/momidat$Nec_best)-(momidat$trueNeH/momidat$trueNeC))/(momidat$trueNeH/momidat$trueNeC)
#momidat$tderr=abs((momidat$T-momidat$td)/(momidat$td))

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

# lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
# lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)]
# 
# lddat_hist=subset(lddat,lddat$timepoint=="t120")
# lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
# lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
# 
# lddat_contemp=subset(lddat,lddat$timepoint=="t0")
# lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
# lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC
# 
# lddat_temporal=subset(lddat_contemp,lddat_contemp$scheme!="contemp")
# 
# lddat_hist$ratioerr=abs((lddat_hist$Ne/lddat_temporal$Ne)-(lddat_hist$trueNeH/lddat_temporal$trueNeC))/(lddat_hist$trueNeH/lddat_temporal$trueNeC)

max(momidat$NeHerr)
max(stairwaydat$NeHerr)
max(gonedat$NeHerr)
#max(lddat_hist$NeHerr,na.rm=TRUE)

max(momidat$NeCerr)
max(stairwaydat$NeCerr)
max(gonedat$NeCerr)
#max(lddat_contemp$NeCerr,na.rm=TRUE)

max(momidat$ratioerr)
max(stairwaydat$ratioerr)
max(gonedat$ratioerr)
#max(lddat_hist$ratioerr,na.rm=TRUE)



momidat$sampn=as.integer(gsub('n','',momidat$sampsize))

gonedat$sampn=as.integer(gsub('n','',gonedat$sampn))

stairwaydat$sampn=as.integer(gsub('n','',stairwaydat$sampn))

#momidat<-subset(momidat,Model=="Change")

momi_rad10k_contemp <- subset(momidat, dataset=="rad10k" & Data=="t0")
momi_rad50k_contemp <- subset(momidat, dataset=="rad50k" & Data=="t0")
momi_rad10k_2samp <- subset(momidat, dataset=="rad10k" & Data=="t0t120")
momi_rad50k_2samp <- subset(momidat, dataset=="rad50k" & Data=="t0t120")
momi_rad10k_serial <- subset(momidat, dataset=="rad10k" & Data=="all")
momi_rad50k_serial <- subset(momidat, dataset=="rad50k" & Data=="all")
momi_wgs_contemp <- subset(momidat, dataset=="wgs" & Data=="t0")
momi_wgs_2samp <- subset(momidat, dataset=="wgs" & Data=="t0t120")
momi_wgs_serial <- subset(momidat, dataset=="wgs" & Data=="all")


momi_rad10k_contemp_agg=aggregate(momi_rad10k_contemp,list(momi_rad10k_contemp$sampn),mean)
momi_rad50k_contemp_agg=aggregate(momi_rad50k_contemp,list(momi_rad50k_contemp$sampn),mean)
momi_rad10k_2samp_agg=aggregate(momi_rad10k_2samp,list(momi_rad10k_2samp$sampn),mean)
momi_rad50k_2samp_agg=aggregate(momi_rad50k_2samp,list(momi_rad50k_2samp$sampn),mean)
momi_rad10k_serial_agg=aggregate(momi_rad10k_serial,list(momi_rad10k_serial$sampn),mean)
momi_rad50k_serial_agg=aggregate(momi_rad50k_serial,list(momi_rad50k_serial$sampn),mean)

momi_wgs_contemp_agg=aggregate(momi_wgs_contemp,list(momi_wgs_contemp$sampn),mean)
momi_wgs_2samp_agg=aggregate(momi_wgs_2samp,list(momi_wgs_2samp$sampn),mean)
momi_wgs_serial_agg=aggregate(momi_wgs_serial,list(momi_wgs_serial$sampn),mean)

gone_agg=aggregate(gonedat,list(gonedat$sampn),mean)

stairway_agg=aggregate(stairwaydat,list(stairwaydat$sampn),mean)


###lds missing for now###

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.8),xlab="Sample Size", ylab="Error",main="NeHistoric",cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeHerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeHerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeHerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeHerr,col="orange",lwd=2)

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.45),xlab="Sample Size", ylab="Error",main="NeHistoric",cex.lab=1.4,cex.main=1.4)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="orange",lwd=2)
points(gone_agg$Group.1,gone_agg$NeHerr,pch=17,col="red",cex=2)
lines(gone_agg$Group.1,gone_agg$NeHerr,col="red",lwd=2)
points(stairway_agg$Group.1,stairway_agg$NeHerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1,stairway_agg$NeHerr,col="black",lwd=2)

legend(x=120,y=0.7,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE","RAD","WGS"),lty=c(1,1,1,1,1,1,1),col=c("blue","green","orange","black","red"),pch=c(0,0,0,0,0,16,17))
text(x=100,y=0.27,labels="generation time = 3 years")

##NeC##

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,2100),xlab="Sample Size", ylab="Error",main="NeContemporary",cex.lab=1.4,cex.main=1.4)
plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0.1,2100),log="y",xlab="Sample Size", ylab="Error",main="NeContemporary",cex.lab=1.4,cex.main=1.4)



#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeCerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeCerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeCerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeCerr,col="orange",lwd=2)

# points(ld_rad10k_contemp_c_agg$Group.1,ld_rad10k_contemp_c_agg$NeCerr,pch=15,col="blue",cex=2)
# lines(ld_rad10k_contemp_c_agg$Group.1,ld_rad10k_contemp_c_agg$NeCerr,col="blue",lwd=2,lty=2)
# points(ld_rad50k_contemp_c_agg$Group.1,ld_rad50k_contemp_c_agg$NeCerr,pch=16,col="blue",cex=2)
# lines(ld_rad50k_contemp_c_agg$Group.1,ld_rad50k_contemp_c_agg$NeCerr,col="blue",lwd=2,lty=2)
# points(ld_rad10k_2samp_c_agg$Group.1,ld_rad10k_2samp_c_agg$NeCerr,pch=15,col="green",cex=2)
# lines(ld_rad10k_2samp_c_agg$Group.1,ld_rad10k_2samp_c_agg$NeCerr,col="green",lwd=2,lty=2)
# points(ld_rad50k_2samp_c_agg$Group.1,ld_rad50k_2samp_c_agg$NeCerr,pch=16,col="green",cex=2)
# lines(ld_rad50k_2samp_c_agg$Group.1,ld_rad50k_2samp_c_agg$NeCerr,col="green",lwd=2,lty=2)
# points(ld_rad10k_serial_c_agg$Group.1,ld_rad10k_serial_c_agg$NeCerr,pch=15,col="orange",cex=2)
# lines(ld_rad10k_serial_c_agg$Group.1,ld_rad10k_serial_c_agg$NeCerr,col="orange",lwd=2,lty=2)
# points(ld_rad50k_serial_c_agg$Group.1,ld_rad50k_serial_c_agg$NeCerr,pch=16,col="orange",cex=2)
# lines(ld_rad50k_serial_c_agg$Group.1,ld_rad50k_serial_c_agg$NeCerr,col="orange",lwd=2,lty=2)

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,2),xlab="Sample Size", ylab="Error",main="NeContemporary",cex.lab=1.4,cex.main=1.4)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="orange",lwd=2)
points(gone_agg$Group.1,gone_agg$NeCerr,pch=17,col="red",cex=2)
lines(gone_agg$Group.1,gone_agg$NeCerr,col="red",lwd=2)
points(stairway_agg$Group.1,stairway_agg$NeCerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1,stairway_agg$NeCerr,col="black",lwd=2)

legend(x=120,y=1500,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE"),lty=c(1,1,1,1,1),col=c("blue","green","orange","black","red"))

text(x=100,y=1700,labels="generation time = 3 years")






#### just slow ####

momidat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/momi_nomaf_data_g3_deltaAIC.csv",header=T)

momidat=momidat[which(momidat$td=="constant"|momidat$td=="td100"),]

momidat$Neh_best=ifelse(momidat$delta>0,momidat$Neh_change,momidat$Neh)
momidat$Nec_best=ifelse(momidat$delta>0,momidat$Nec_change,momidat$Nec)

stairwaydat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/stairwaydata_g3.csv",header=T)
gonedat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/g3_data/GONEdata_g3.csv",header=T)
#lddat=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/LDNeoutall.csv",header=T)
tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
momidat$scen=paste(momidat$popsize,momidat$td,momidat$lambda)
gonedat$scen=paste(gonedat$NeAnc,gonedat$td,gonedat$lambda)
stairwaydat$scen=paste(stairwaydat$NeAnc,stairwaydat$td,stairwaydat$lambda)
#lddat$NeAnc=paste("n10e",log10(lddat$nhist/10),sep="")
#lddat$tdec=paste("td",lddat$td,sep="")
#lddat$lambda=paste("l",lddat$l,sep="")
#lddat$scen=paste(lddat$NeAnc,lddat$tdec,lddat$lambda)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)
momidat$td=abs(as.integer(gsub('td','',momidat$td))-220)

momidat$trueNeH=tru$TrueNeH[match(momidat$scen,tru$scen)]
momidat$trueNeC=tru$TrueNec[match(momidat$scen,tru$scen)]
momidat$NeHerr=abs(momidat$Neh_best-momidat$trueNeH)/momidat$trueNeH
momidat$NeCerr=abs(momidat$Nec_best-momidat$trueNeC)/momidat$trueNeC
momidat$ratioerr=abs((momidat$Neh_best/momidat$Nec_best)-(momidat$trueNeH/momidat$trueNeC))/(momidat$trueNeH/momidat$trueNeC)
#momidat$tderr=abs((momidat$T-momidat$td)/(momidat$td))

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

# lddat$trueNeH=tru$TrueNeH[match(lddat$scen,tru$scen)]
# lddat$trueNeC=tru$TrueNec[match(lddat$scen,tru$scen)]
# 
# lddat_hist=subset(lddat,lddat$timepoint=="t120")
# lddat_hist$Ne=as.numeric(gsub("Infinite",NA,lddat_hist$Ne))
# lddat_hist$NeHerr=abs(lddat_hist$Ne-lddat_hist$trueNeH)/lddat_hist$trueNeH
# 
# lddat_contemp=subset(lddat,lddat$timepoint=="t0")
# lddat_contemp$Ne=as.numeric(gsub("Infinite",NA,lddat_contemp$Ne))
# lddat_contemp$NeCerr=abs(lddat_contemp$Ne-lddat_contemp$trueNeC)/lddat_contemp$trueNeC
# 
# lddat_temporal=subset(lddat_contemp,lddat_contemp$scheme!="contemp")
# 
# lddat_hist$ratioerr=abs((lddat_hist$Ne/lddat_temporal$Ne)-(lddat_hist$trueNeH/lddat_temporal$trueNeC))/(lddat_hist$trueNeH/lddat_temporal$trueNeC)

max(momidat$NeHerr)
max(stairwaydat$NeHerr)
max(gonedat$NeHerr)
#max(lddat_hist$NeHerr,na.rm=TRUE)

max(momidat$NeCerr)
max(stairwaydat$NeCerr)
max(gonedat$NeCerr)
#max(lddat_contemp$NeCerr,na.rm=TRUE)

max(momidat$ratioerr)
max(stairwaydat$ratioerr)
max(gonedat$ratioerr)
#max(lddat_hist$ratioerr,na.rm=TRUE)



momidat$sampn=as.integer(gsub('n','',momidat$sampsize))

gonedat$sampn=as.integer(gsub('n','',gonedat$sampn))

stairwaydat$sampn=as.integer(gsub('n','',stairwaydat$sampn))

#momidat<-subset(momidat,Model=="Change")

momi_rad10k_contemp <- subset(momidat, dataset=="rad10k" & Data=="t0")
momi_rad50k_contemp <- subset(momidat, dataset=="rad50k" & Data=="t0")
momi_rad10k_2samp <- subset(momidat, dataset=="rad10k" & Data=="t0t120")
momi_rad50k_2samp <- subset(momidat, dataset=="rad50k" & Data=="t0t120")
momi_rad10k_serial <- subset(momidat, dataset=="rad10k" & Data=="all")
momi_rad50k_serial <- subset(momidat, dataset=="rad50k" & Data=="all")
momi_wgs_contemp <- subset(momidat, dataset=="wgs" & Data=="t0")
momi_wgs_2samp <- subset(momidat, dataset=="wgs" & Data=="t0t120")
momi_wgs_serial <- subset(momidat, dataset=="wgs" & Data=="all")


momi_rad10k_contemp_agg=aggregate(momi_rad10k_contemp,list(momi_rad10k_contemp$sampn),mean)
momi_rad50k_contemp_agg=aggregate(momi_rad50k_contemp,list(momi_rad50k_contemp$sampn),mean)
momi_rad10k_2samp_agg=aggregate(momi_rad10k_2samp,list(momi_rad10k_2samp$sampn),mean)
momi_rad50k_2samp_agg=aggregate(momi_rad50k_2samp,list(momi_rad50k_2samp$sampn),mean)
momi_rad10k_serial_agg=aggregate(momi_rad10k_serial,list(momi_rad10k_serial$sampn),mean)
momi_rad50k_serial_agg=aggregate(momi_rad50k_serial,list(momi_rad50k_serial$sampn),mean)

momi_wgs_contemp_agg=aggregate(momi_wgs_contemp,list(momi_wgs_contemp$sampn),mean)
momi_wgs_2samp_agg=aggregate(momi_wgs_2samp,list(momi_wgs_2samp$sampn),mean)
momi_wgs_serial_agg=aggregate(momi_wgs_serial,list(momi_wgs_serial$sampn),mean)

gone_agg=aggregate(gonedat,list(gonedat$sampn),mean)

stairway_agg=aggregate(stairwaydat,list(stairwaydat$sampn),mean)


###lds missing for now###

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.3),xlab="Sample Size", ylab="Error",main="NeHistoric",cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeHerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeHerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeHerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeHerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeHerr,col="orange",lwd=2)

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,0.45),xlab="Sample Size", ylab="Error",main="NeHistoric",cex.lab=1.4,cex.main=1.4)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeHerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeHerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeHerr,col="orange",lwd=2)
points(gone_agg$Group.1,gone_agg$NeHerr,pch=17,col="red",cex=2)
lines(gone_agg$Group.1,gone_agg$NeHerr,col="red",lwd=2)
points(stairway_agg$Group.1,stairway_agg$NeHerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1,stairway_agg$NeHerr,col="black",lwd=2)

legend(x=120,y=0.25,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE"),lty=c(1,1,1,1,1),col=c("blue","green","orange","black","red"))

text(x=100,y=0.27,labels="generation time = 3 years")

##NeC##

plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,25),xlab="Sample Size", ylab="Error",main="NeContemporary",cex.lab=1.4,cex.main=1.4)

#points(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,pch=15,col="blue",cex=2)
#lines(momi_rad10k_contemp_agg$Group.1,momi_rad10k_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeCerr,pch=16,col="blue",cex=2)
lines(momi_rad50k_contemp_agg$Group.1,momi_rad50k_contemp_agg$NeCerr,col="blue",lwd=2)
#points(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=15,col="green",cex=2)
#lines(momi_rad10k_2samp_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,pch=16,col="green",cex=2)
lines(momi_rad50k_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
#points(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,pch=15,col="orange",cex=2)
#lines(momi_rad10k_serial_agg$Group.1,momi_rad10k_serial_agg$NeCerr,col="orange",lwd=2)
points(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeCerr,pch=16,col="orange",cex=2)
lines(momi_rad50k_serial_agg$Group.1,momi_rad50k_serial_agg$NeCerr,col="orange",lwd=2)

# points(ld_rad10k_contemp_c_agg$Group.1,ld_rad10k_contemp_c_agg$NeCerr,pch=15,col="blue",cex=2)
# lines(ld_rad10k_contemp_c_agg$Group.1,ld_rad10k_contemp_c_agg$NeCerr,col="blue",lwd=2,lty=2)
# points(ld_rad50k_contemp_c_agg$Group.1,ld_rad50k_contemp_c_agg$NeCerr,pch=16,col="blue",cex=2)
# lines(ld_rad50k_contemp_c_agg$Group.1,ld_rad50k_contemp_c_agg$NeCerr,col="blue",lwd=2,lty=2)
# points(ld_rad10k_2samp_c_agg$Group.1,ld_rad10k_2samp_c_agg$NeCerr,pch=15,col="green",cex=2)
# lines(ld_rad10k_2samp_c_agg$Group.1,ld_rad10k_2samp_c_agg$NeCerr,col="green",lwd=2,lty=2)
# points(ld_rad50k_2samp_c_agg$Group.1,ld_rad50k_2samp_c_agg$NeCerr,pch=16,col="green",cex=2)
# lines(ld_rad50k_2samp_c_agg$Group.1,ld_rad50k_2samp_c_agg$NeCerr,col="green",lwd=2,lty=2)
# points(ld_rad10k_serial_c_agg$Group.1,ld_rad10k_serial_c_agg$NeCerr,pch=15,col="orange",cex=2)
# lines(ld_rad10k_serial_c_agg$Group.1,ld_rad10k_serial_c_agg$NeCerr,col="orange",lwd=2,lty=2)
# points(ld_rad50k_serial_c_agg$Group.1,ld_rad50k_serial_c_agg$NeCerr,pch=16,col="orange",cex=2)
# lines(ld_rad50k_serial_c_agg$Group.1,ld_rad50k_serial_c_agg$NeCerr,col="orange",lwd=2,lty=2)

#plot(x=NULL,y=NULL,xlim=c(0,200),ylim=c(0,2),xlab="Sample Size", ylab="Error",main="NeContemporary",cex.lab=1.4,cex.main=1.4)

points(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,pch=17,col="blue",cex=2)
lines(momi_wgs_contemp_agg$Group.1,momi_wgs_contemp_agg$NeCerr,col="blue",lwd=2)
points(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,pch=17,col="green",cex=2)
lines(momi_wgs_2samp_agg$Group.1,momi_rad50k_2samp_agg$NeCerr,col="green",lwd=2)
points(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,pch=17,col="orange",cex=2)
lines(momi_wgs_serial_agg$Group.1,momi_rad10k_2samp_agg$NeCerr,col="orange",lwd=2)
points(gone_agg$Group.1,gone_agg$NeCerr,pch=17,col="red",cex=2)
lines(gone_agg$Group.1,gone_agg$NeCerr,col="red",lwd=2)
points(stairway_agg$Group.1,stairway_agg$NeCerr,pch=17,col="black",cex=2)
lines(stairway_agg$Group.1,stairway_agg$NeCerr,col="black",lwd=2)

legend(x=120,y=2,legend=c("momi2 / Contemporary","momi2 / Two sample","momi2 / Serial","Stairway","GONE"),lty=c(1,1,1,1,1),col=c("blue","green","orange","black","red"))

text(x=100,y=2.3,labels="generation time = 3 years")







### violins ###


momidat200 <- subset(momidat, sampsize=="n200" & dataset=="rad50k")
momidat200$NeHrat <- momidat200$Neh_best/momidat200$trueNeH
momidat200$NeCrat <- momidat200$Nec_best/momidat200$trueNeC

p <- ggplot(momidat200, aes(x=Data, y=NeHrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/200 samples, Historic Ne") + xlab("Scheme") + ylab("NeHhat/trueNeH") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()

p <- ggplot(momidat200, aes(x=Data, y=NeCrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/200 samples, Contemporary Ne") + xlab("Scheme") + ylab("NeChat/trueNeC") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()




momidat100 <- subset(momidat, sampsize=="n100" & dataset=="rad50k")
momidat100$NeHrat <- momidat100$Neh_best/momidat100$trueNeH
momidat100$NeCrat <- momidat100$Nec_best/momidat100$trueNeC

p <- ggplot(momidat100, aes(x=Data, y=NeHrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/100 samples, Historic Ne") + xlab("Scheme") + ylab("NeHhat/trueNeH") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()

p <- ggplot(momidat100, aes(x=Data, y=NeCrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/100 samples, Contemporary Ne") + xlab("Scheme") + ylab("NeChat/trueNeC") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()




momidat100 <- subset(momidat, sampsize=="n100" & dataset=="wgs")
momidat100$NeHrat <- momidat100$Neh/momidat100$trueNeH
momidat100$NeCrat <- momidat100$Nec/momidat100$trueNeC

p <- ggplot(momidat100, aes(x=Data, y=NeHrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/100 samples, Historic Ne") + xlab("Scheme") + ylab("NeHhat/trueNeH") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()

p <- ggplot(momidat100, aes(x=Data, y=NeCrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("momi2, 50k RAD loci/100 samples, Contemporary Ne") + xlab("Scheme") + ylab("NeChat/trueNeC") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()






gonedat$NeHrat <- gonedat$Neh/gonedat$trueNeH
gonedat$NeCrat <- gonedat$Nec/gonedat$trueNeC
gonedat$sampfac <- as.factor(gonedat$sampn)

p <- ggplot(gonedat, aes(x=sampfac, y=NeHrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("GONE, Historic Ne") + xlab("Sample Size" ) + ylab("NeHhat/trueNeH") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()

p <- ggplot(gonedat, aes(x=sampfac, y=NeCrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("GONE, Contemporary Ne") + xlab("Sample Size") + ylab("NeChat/trueNeC") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()



stairwaydat$NeHrat <- stairwaydat$Neh/stairwaydat$trueNeH
stairwaydat$NeCrat <- stairwaydat$Nec/stairwaydat$trueNeC
stairwaydat$sampfac <- as.factor(stairwaydat$sampn)

p <- ggplot(stairwaydat, aes(x=sampfac, y=NeHrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("Stairway, Historic Ne") + xlab("Scheme") + ylab("NeHhat/trueNeH") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()

p <- ggplot(stairwaydat, aes(x=sampfac, y=NeCrat)) + geom_violin()
p + geom_point(shape=16) + ggtitle("Stairway, Contemporary Ne") + xlab("Scheme") + ylab("NeChat/trueNeC") + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10()



