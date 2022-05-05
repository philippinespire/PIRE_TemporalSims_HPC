library(tidyverse)
library(ggplot2)

tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

momidat_single=read.csv("inferences/momi_nomaf_data_single2samp.csv",header=T)
momidat_single$Neh_best=ifelse(momidat_single$delta<0,momidat_single$Nh,momidat_single$Nh_Cons)
momidat_single$Nec_best=ifelse(momidat_single$delta<0,momidat_single$Nc,momidat_single$Nc_Cons)
momidat_single$scen=paste(momidat_single$NeAnc,momidat_single$td,momidat_single$lambda)
momidat_single$trueNeH=tru$TrueNeH[match(momidat_single$scen,tru$scen)]
momidat_single$trueNeC=tru$TrueNec[match(momidat_single$scen,tru$scen)]
momidat_single$NeHerr=abs(momidat_single$Neh_best-momidat_single$trueNeH)/momidat_single$trueNeH
momidat_single$NeCerr=abs(momidat_single$Nec_best-momidat_single$trueNeC)/momidat_single$trueNeC
momidat_single$NeHrat <- momidat_single$Neh_best/momidat_single$trueNeH
momidat_single$NeCrat <- momidat_single$Nec_best/momidat_single$trueNeC
momidat_single$modsel=ifelse(momidat_single$delta<0,"Change","Constant")

momidat_maf1=read.csv("inferences/momi_maf1_data_deltaAIC.csv",header=T)
momidat_maf1$Neh_best=ifelse(momidat_maf1$delta<0,momidat_maf1$Nh,momidat_maf1$NhC)
momidat_maf1$Nec_best=ifelse(momidat_maf1$delta<0,momidat_maf1$Nc,momidat_maf1$NcC)
momidat_maf1$scen=paste(momidat_maf1$NeAnc,momidat_maf1$td,momidat_maf1$lambda)
momidat_maf1$trueNeH=tru$TrueNeH[match(momidat_maf1$scen,tru$scen)]
momidat_maf1$trueNeC=tru$TrueNec[match(momidat_maf1$scen,tru$scen)]
momidat_maf1$NeHerr=abs(momidat_maf1$Neh_best-momidat_maf1$trueNeH)/momidat_maf1$trueNeH
momidat_maf1$NeCerr=abs(momidat_maf1$Nec_best-momidat_maf1$trueNeC)/momidat_maf1$trueNeC
momidat_maf1$NeHrat <- momidat_maf1$Neh_best/momidat_maf1$trueNeH
momidat_maf1$NeCrat <- momidat_maf1$Nec_best/momidat_maf1$trueNeC
momidat_maf1$modsel=ifelse(momidat_maf1$delta<0,"Change","Constant")

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
momidat_basic$modsel=ifelse(momidat_basic$delta<0,"Constant","Change")


momidat_single_fast=momidat_single[which(momidat_single$scen=="n10e4 td190 l95" & momidat_single$data=="n200" & momidat_single$sampn=="rad50k"),]
momidat_maf1_fast=momidat_maf1[which(momidat_maf1$scen=="n10e4 td190 l95" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]
momidat_basic_fast=momidat_basic[which(momidat_basic$scen=="n10e4 td190 l95" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]

momidat_single_slow=momidat_single[which(momidat_single$scen=="n10e4 td100 l99" & momidat_single$data=="n200" & momidat_single$sampn=="rad50k"),]
momidat_maf1_slow=momidat_maf1[which(momidat_maf1$scen=="n10e4 td100 l99" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]
momidat_basic_slow=momidat_basic[which(momidat_basic$scen=="n10e4 td100 l99" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]

momidat_single_constant=momidat_single[which(momidat_single$scen=="n10e4 constant constant" & momidat_single$data=="n200" & momidat_single$sampn=="rad50k"),]
momidat_maf1_constant=momidat_maf1[which(momidat_maf1$scen=="n10e4 constant constant" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]
momidat_basic_constant=momidat_basic[which(momidat_basic$scen=="n10e4 constant constant" & momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]

momidat_single_rad50kn200=momidat_single[which(momidat_single$data=="n200" & momidat_single$sampn=="rad50k"),]
momidat_maf1_rad50kn200=momidat_maf1[which(momidat_maf1$sampn=="n200" & momidat_maf1$data=="rad50k"),]
momidat_basic_rad50kn200=momidat_basic[which(momidat_basic$sampn=="n200" & momidat_basic$data=="rad50k"),]


momidat_maf1_rad50kn200 %>% select('NeHerr','NeCerr','scheme','scen','NeCrat','NeHrat') -> maf1err 
maf1err$maf="Minor Allele Filter"
maf1err$scen=gsub("n10e4 constant constant","Constant",maf1err$scen)
maf1err$scen=gsub("n10e4 td100 l99","Slow Decline",maf1err$scen)
maf1err$scen=gsub("n10e4 td190 l95","Fast Decline",maf1err$scen)
maf1err$scheme=gsub("t0","Contemporary",maf1err$scheme)
maf1err$scheme=gsub("Contemporaryt120","Two Samples",maf1err$scheme)
maf1err$scheme=gsub("all","Serial Sampling",maf1err$scheme)

momidat_basic_rad50kn200 %>% 
  filter(!grepl('n10e3|td130|td160|td190 l99',scen)) %>% 
  select('NeHerr','NeCerr','scheme','scen','NeCrat','NeHrat') -> nomaferr 

nomaferr$maf="No Minor Allele Filter"
nomaferr$scen=gsub("n10e4 constant constant","Constant",nomaferr$scen)
nomaferr$scen=gsub("n10e4 td100 l99","Slow Decline",nomaferr$scen)
nomaferr$scen=gsub("n10e4 td190 l95","Fast Decline",nomaferr$scen)
nomaferr$scheme=gsub("t0","Contemporary",nomaferr$scheme)
nomaferr$scheme=gsub("Contemporaryt120","Two Samples",nomaferr$scheme)
nomaferr$scheme=gsub("all","Serial Sampling",nomaferr$scheme)
nomaferr= na.omit(nomaferr)

mafcomp=rbind(nomaferr,maf1err)

mafcomp$col=ifelse(mafcomp$scheme=="Contemporary","blue",ifelse(mafcomp$scheme=="Two Samples","green","orange"))

mafcomp$scheme=factor(mafcomp$scheme, levels=c("Contemporary","Two Samples","Serial Sampling"))

### boxen

p <- ggplot(mafcomp, aes(x=maf, y=NeHerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scheme)
p + facet_wrap(~scen)


p <- ggplot(mafcomp, aes(x=maf, y=NeCerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scheme)
p + facet_wrap(~scen)

#### violins

p <- ggplot(mafcomp, aes(x=maf, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,colour="cornflowerblue") +
  theme_bw() +
  ggtitle("momi2 inference on historic Ne") +
  xlab("Filtering") +
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  geom_hline(yintercept=1,linetype="dashed") +
  facet_wrap(~scheme) + scale_y_log10(limits=c(0.001,10))

ggsave("plots/maf_NeH_violins_revised0429.pdf",device="pdf")

p <- ggplot(mafcomp, aes(x=maf, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,colour="cornflowerblue") + 
  theme_bw() +
  ggtitle("momi2 inference on contemporary Ne") + 
  xlab("Filtering") +
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  geom_hline(yintercept=1,linetype="dashed") +
  facet_wrap(~scheme)  + scale_y_log10(limits=c(0.001,10))

ggsave("plots/maf_NeC_violins_revised0429.pdf",device="pdf")


### singletons

nomaferr$maf="None"

nomaferr %>%
  filter(scheme=="Two Samples") -> nomaf2samp

momidat_single %>% 
  filter(scheme=="t0t120") %>% 
  select('NeHerr','NeCerr','scheme','scen','NeCrat','NeHrat','maf') -> singleerr 
singleerr$scen=gsub("n10e4 constant constant","Constant",singleerr$scen)
singleerr$scen=gsub("n10e4 td100 l99","Slow Decline",singleerr$scen)
singleerr$scen=gsub("n10e4 td190 l95","Fast Decline",singleerr$scen)
singleerr$scheme=gsub("t0t120","Two Samples",singleerr$scheme)
singleerr$maf=gsub("e0.0001","1e-4",singleerr$maf)
singleerr$maf=gsub("e0.001","1e-3",singleerr$maf)
singleerr$maf=gsub("e1e-05","1e-5",singleerr$maf)

mafcomp=rbind(nomaf2samp,singleerr)

mafcomp$col=ifelse(mafcomp$scheme=="Contemporary","blue",ifelse(mafcomp$scheme=="Two Samples","green","orange"))

mafcomp$scheme=factor(mafcomp$scheme, levels=c("Contemporary","Two Samples","Serial Sampling"))

####

p <- ggplot(mafcomp, aes(x=maf, y=NeHerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scen)

p <- ggplot(mafcomp, aes(x=maf, y=NeCerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scen)


#### violins

p <- ggplot(mafcomp, aes(x=maf, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,col=mafcomp$col) + ggtitle("momi2 inference on historic Ne") + xlab("Assembly Scheme") + ylab(expression(paste(widehat('N'[E]),'H/N'[E],'H'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~scen) + scale_y_log10(limits=c(0.001,10))

p <- ggplot(mafcomp, aes(x=maf, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col=mafcomp$col) + ggtitle("momi2 inference on contemporary Ne") + xlab("Assembly Scheme") + ylab(expression(paste(widehat('N'[E]),'C/N'[E],'C'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~scen)  + scale_y_log10(limits=c(0.001,10))

#### no wrap

p <- ggplot(mafcomp, aes(x=maf, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,colour="cornflowerblue") + 
  theme_bw()+ ggtitle("momi2 inference on historic Ne") + 
  xlab("Singleton Rate") + 
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) + 
  geom_hline(yintercept=1,linetype="dashed") + 
  scale_y_log10(limits=c(0.001,10))

ggsave("singleton_NeH_violins_revised0429.pdf",device="pdf")

p <- ggplot(mafcomp, aes(x=maf, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,colour="cornflowerblue") + 
  theme_bw()+ ggtitle("momi2 inference on contemporary Ne") + 
  xlab("Singleton Rate") + 
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) + 
  geom_hline(yintercept=1,linetype="dashed") + 
  scale_y_log10(limits=c(0.001,10))

ggsave("singleton_NeC_violins_revised0429.pdf",device="pdf")
