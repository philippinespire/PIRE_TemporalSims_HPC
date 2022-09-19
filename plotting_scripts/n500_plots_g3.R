library(tidyverse)
library(ggplot2)
library(plyr)

#tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
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
gonedat_basic$scheme="t0"

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
stairdat_basic$scheme="t0"

momidat_g3=read.csv("inferences/momi_nomaf_data_g3_deltaAIC.csv",header=T)
momidat_g3$Neh_best=ifelse(momidat_g3$delta<0,momidat_g3$Neh,momidat_g3$Neh_change)
momidat_g3$Nec_best=ifelse(momidat_g3$delta<0,momidat_g3$Nec,momidat_g3$Nec_change)
momidat_g3$modsel=ifelse(momidat_g3$delta<0,"Change","Constant")
momidat_g3$scen=paste(momidat_g3$NeAnc,momidat_g3$td,momidat_g3$lambda)
momidat_g3$trueNeH=tru$TrueNeH[match(momidat_g3$scen,tru$scen)]
momidat_g3$trueNeC=tru$TrueNec[match(momidat_g3$scen,tru$scen)]
momidat_g3$NeHerr=abs(momidat_g3$Neh_best-momidat_g3$trueNeH)/momidat_g3$trueNeH
momidat_g3$NeCerr=abs(momidat_g3$Nec_best-momidat_g3$trueNeC)/momidat_g3$trueNeC
momidat_g3$NeHrat <- momidat_g3$Neh_best/momidat_g3$trueNeH
momidat_g3$NeCrat <- momidat_g3$Nec_best/momidat_g3$trueNeC
momidat_g3$gentime="G=3"
momidat_g3$method="momi2"

gonedat_g3=read.csv("inferences/GONEdata_g3.csv",header=T)
gonedat_g3$scen=paste(gonedat_g3$NeAnc,gonedat_g3$td,gonedat_g3$lambda)
gonedat_g3$trueNeH=tru$TrueNeH[match(gonedat_g3$scen,tru$scen)]
gonedat_g3$trueNeC=tru$TrueNec[match(gonedat_g3$scen,tru$scen)]
gonedat_g3$NeHerr=abs(gonedat_g3$Neh-gonedat_g3$trueNeH)/gonedat_g3$trueNeH
gonedat_g3$NeCerr=abs(gonedat_g3$Nec-gonedat_g3$trueNeC)/gonedat_g3$trueNeC
gonedat_g3$NeHrat <- gonedat_g3$Neh/gonedat_g3$trueNeH
gonedat_g3$NeCrat <- gonedat_g3$Nec/gonedat_g3$trueNeC
gonedat_g3$gentime="G=3"
gonedat_g3$method="GONE"
gonedat_g3$scheme="t0"

stairdat_g3=read.csv("inferences/stairwaydata_g3.csv",header=T)
stairdat_g3$scen=paste(stairdat_g3$NeAnc,stairdat_g3$td,stairdat_g3$lambda)
stairdat_g3$trueNeH=tru$TrueNeH[match(stairdat_g3$scen,tru$scen)]
stairdat_g3$trueNeC=tru$TrueNec[match(stairdat_g3$scen,tru$scen)]
stairdat_g3$NeHerr=abs(stairdat_g3$Neh-stairdat_g3$trueNeH)/stairdat_g3$trueNeH
stairdat_g3$NeCerr=abs(stairdat_g3$Nec-stairdat_g3$trueNeC)/stairdat_g3$trueNeC
stairdat_g3$NeHrat <- stairdat_g3$Neh/stairdat_g3$trueNeH
stairdat_g3$NeCrat <- stairdat_g3$Nec/stairdat_g3$trueNeC
stairdat_g3$gentime="G=3"
stairdat_g3$method="Stairway"
stairdat_g3$scheme="t0"

momidat_basic %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_basic_filt

gonedat_basic %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> gonedat_basic_filt

stairdat_basic %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> stairdat_basic_filt

momidat_g3 %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_g3_filt

gonedat_g3 %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> gonedat_g3_filt

stairdat_g3 %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> stairdat_g3_filt


g3comp=rbind.fill(momidat_basic_filt,gonedat_basic_filt,stairdat_basic_filt,momidat_g3_filt,gonedat_g3_filt,stairdat_g3_filt)

g3comp$col=ifelse(g3comp$method == "Stairway","black",ifelse(g3comp$method == "GONE","purple",ifelse(g3comp$scheme=="t0","blue",ifelse(g3comp$scheme=="t0t120","green","orange"))))

g3comp$methcomb=paste(g3comp$method,g3comp$data)

g3comp$methcomb=gsub("GONE wgs","GONE",g3comp$methcomb)
g3comp$methcomb=gsub("Stairway wgs","Stairway",g3comp$methcomb)
g3comp$methcomb=gsub("momi2 wgs","momi2/WGS",g3comp$methcomb)
g3comp$methcomb=gsub("momi2 rad50k","momi2/RAD",g3comp$methcomb)

g3comp$methcomb=factor(g3comp$methcomb,levels=c("GONE","Stairway","momi2/WGS","momi2/RAD"))


#### violins

min(g3comp$NeHrat)
min(g3comp$NeCrat)

max(g3comp$NeHrat)
max(g3comp$NeCrat)


p <- ggplot(g3comp, aes(x=methcomb, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,col=g3comp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'H/N'[E],'H'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~gentime) + scale_y_log10(limits=c(0.03,2150))

ggsave("plots/g3_NeH_violin.pdf",device="pdf")

p <- ggplot(g3comp, aes(x=methcomb, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col=g3comp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'C/N'[E],'C'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~gentime) + scale_y_log10(limits=c(0.03,2150))

ggsave("plots/g3_NeC_violin.pdf",device="pdf")



###contemp-only

g3comp %>% filter(scheme=="t0") -> g3compc

g3comp1=g3compc

g3comp2=g3compc

g3comp1$metric="NEH"
g3comp2$metric="NEC"
g3comp1$Nerat=g3comp1$NeHrat
g3comp2$Nerat=g3comp2$NeCrat

g3comp12=rbind(g3comp1,g3comp2)

g3comp12$metric=factor(g3comp12$metric,levels=c("NEH","NEC"))

p <- ggplot(g3comp12,aes(y=Nerat, x=methcomb, fill=metric, colour=scheme)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NEH"="black","NEC"="white"))+
  ylab(expression(paste(hat(N)["E"],'/N'["E"]))) +
  xlab("") +
  facet_wrap(~gentime) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.001,300000)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/gentime_NeHCrat_050922.pdf",device="pdf")


###momi schemes

g3comp %>% filter(methcomb=="momi2/RAD") -> g3compc

g3comp1=g3compc

g3comp2=g3compc

g3comp1$metric="NEH"
g3comp2$metric="NEC"
g3comp1$Nerat=g3comp1$NeHrat
g3comp2$Nerat=g3comp2$NeCrat

g3comp12=rbind(g3comp1,g3comp2)

g3comp12$metric=factor(g3comp12$metric,levels=c("NEH","NEC"))

g3comp12$scheme=gsub("t0t120","Two Samples",g3comp12$scheme)
g3comp12$scheme=gsub("t0","Contemporary Only",g3comp12$scheme)
g3comp12$scheme=gsub("all","Serial Sampling",g3comp12$scheme)

g3comp12$scheme=factor(g3comp12$scheme,levels=c("Contemporary Only","Two Samples","Serial Sampling"))

p <- ggplot(g3comp12,aes(y=Nerat, x=scheme, fill=metric)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
#  scale_color_manual(values=c("Contem"="black","t0t120"="black",""))+
  scale_fill_manual(values=c("NEH"="black","NEC"="white"))+
  ylab(expression(paste(hat(N)["E"],'/N'["E"]))) +
  xlab("") +
  facet_wrap(~gentime) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.05,800)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/gentime_NeHCrat_momischemes_050922.pdf",device="pdf")
