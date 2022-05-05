library(tidyverse)
library(ggplot2)
library(plyr)

tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
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
momidat_basic$history="Constant"
momidat_basic$method="momi2"

gonedat_basic=read.csv("inferences/GONEdata.csv",header=T)
gonedat_basic$scen=paste(gonedat_basic$NeAnc,gonedat_basic$td,gonedat_basic$lambda)
gonedat_basic$trueNeH=tru$TrueNeH[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$trueNeC=tru$TrueNec[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$NeHerr=abs(gonedat_basic$Neh-gonedat_basic$trueNeH)/gonedat_basic$trueNeH
gonedat_basic$NeCerr=abs(gonedat_basic$Nec-gonedat_basic$trueNeC)/gonedat_basic$trueNeC
gonedat_basic$NeHrat <- gonedat_basic$Neh/gonedat_basic$trueNeH
gonedat_basic$NeCrat <- gonedat_basic$Nec/gonedat_basic$trueNeC
gonedat_basic$history="Constant"
gonedat_basic$method="GONE"

stairdat_basic=read.csv("inferences/stairwaydata.csv",header=T)
stairdat_basic$scen=paste(stairdat_basic$NeAnc,stairdat_basic$td,stairdat_basic$lambda)
stairdat_basic$trueNeH=tru$TrueNeH[match(stairdat_basic$scen,tru$scen)]
stairdat_basic$trueNeC=tru$TrueNec[match(stairdat_basic$scen,tru$scen)]
stairdat_basic$NeHerr=abs(stairdat_basic$Neh-stairdat_basic$trueNeH)/stairdat_basic$trueNeH
stairdat_basic$NeCerr=abs(stairdat_basic$Nec-stairdat_basic$trueNeC)/stairdat_basic$trueNeC
stairdat_basic$NeHrat <- stairdat_basic$Neh/stairdat_basic$trueNeH
stairdat_basic$NeCrat <- stairdat_basic$Nec/stairdat_basic$trueNeC
stairdat_basic$history="Constant"
stairdat_basic$method="Stairway"

momidat_bot=read.csv("inferences/momi_nomaf_data_bot_all_deltaAIC.csv",header=T)
momidat_bot %>% select(AIC2C,AIC1C,AICC)
momidat_bot %>% select(AIC2C,AIC1C,AICC) -> momidat_bot_AICs
momidat_bot$Neh_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nh,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nh1C,momidat_bot$NhC))
momidat_bot$Nec_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nc,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nc1C,momidat_bot$NcC))
momidat_bot$modsel=ifelse(max.col(-momidat_bot_AICs)==1,"Two Changes",ifelse(max.col(-momidat_bot_AICs)==2,"Recent Change","Constant"))
momidat_bot$scen=paste(momidat_bot$NeAnc,momidat_bot$td,momidat_bot$lambda)
momidat_bot$trueNeH=tru$TrueNeH[match(momidat_bot$scen,tru$scen)]
momidat_bot$trueNeC=tru$TrueNec[match(momidat_bot$scen,tru$scen)]
momidat_bot$NeHerr=abs(momidat_bot$Neh_best-momidat_bot$trueNeH)/momidat_bot$trueNeH
momidat_bot$NeCerr=abs(momidat_bot$Nec_best-momidat_bot$trueNeC)/momidat_bot$trueNeC
momidat_bot$NeHrat <- momidat_bot$Neh_best/momidat_bot$trueNeH
momidat_bot$NeCrat <- momidat_bot$Nec_best/momidat_bot$trueNeC
momidat_bot$history="Bottleneck"
momidat_bot$method="momi2"

gonedat_bot=read.csv("inferences/GONEdata_bot.csv",header=T)
gonedat_bot$scen=paste(gonedat_bot$NeAnc,gonedat_bot$td,gonedat_bot$lambda)
gonedat_bot$trueNeH=tru$TrueNeH[match(gonedat_bot$scen,tru$scen)]
gonedat_bot$trueNeC=tru$TrueNec[match(gonedat_bot$scen,tru$scen)]
gonedat_bot$NeHerr=abs(gonedat_bot$Neh-gonedat_bot$trueNeH)/gonedat_bot$trueNeH
gonedat_bot$NeCerr=abs(gonedat_bot$Nec-gonedat_bot$trueNeC)/gonedat_bot$trueNeC
gonedat_bot$NeHrat <- gonedat_bot$Neh/gonedat_bot$trueNeH
gonedat_bot$NeCrat <- gonedat_bot$Nec/gonedat_bot$trueNeC
gonedat_bot$history="Bottleneck"
gonedat_bot$method="GONE"

stairdat_bot=read.csv("inferences/stairwaydata_bot.csv",header=T)
stairdat_bot$scen=paste(stairdat_bot$NeAnc,stairdat_bot$td,stairdat_bot$lambda)
stairdat_bot$trueNeH=tru$TrueNeH[match(stairdat_bot$scen,tru$scen)]
stairdat_bot$trueNeC=tru$TrueNec[match(stairdat_bot$scen,tru$scen)]
stairdat_bot$NeHerr=abs(stairdat_bot$Neh-stairdat_bot$trueNeH)/stairdat_bot$trueNeH
stairdat_bot$NeCerr=abs(stairdat_bot$Nec-stairdat_bot$trueNeC)/stairdat_bot$trueNeC
stairdat_bot$NeHrat <- stairdat_bot$Neh/stairdat_bot$trueNeH
stairdat_bot$NeCrat <- stairdat_bot$Nec/stairdat_bot$trueNeC
stairdat_bot$history="Bottleneck"
stairdat_bot$method="Stairway"

momidat_exp=read.csv("inferences/momi_nomaf_data_exp_all_deltaAIC.csv",header=T)
momidat_exp %>% select(AIC2C,AIC1C,AICC)
momidat_exp %>% select(AIC2C,AIC1C,AICC) -> momidat_exp_AICs
momidat_exp$Neh_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_exp$Nh,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nh1C,momidat_exp$NhC))
momidat_exp$Nec_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_exp$Nc,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nc1C,momidat_exp$NcC))
momidat_exp$modsel=ifelse(max.col(-momidat_exp_AICs)==1,"Two Changes",ifelse(max.col(-momidat_exp_AICs)==2,"Recent Change","Constant"))
momidat_exp$scen=paste(momidat_exp$NeAnc,momidat_exp$td,momidat_exp$lambda)
momidat_exp$trueNeH=tru$TrueNeH[match(momidat_exp$scen,tru$scen)]
momidat_exp$trueNeC=tru$TrueNec[match(momidat_exp$scen,tru$scen)]
momidat_exp$NeHerr=abs(momidat_exp$Neh_best-momidat_exp$trueNeH)/momidat_exp$trueNeH
momidat_exp$NeCerr=abs(momidat_exp$Nec_best-momidat_exp$trueNeC)/momidat_exp$trueNeC
momidat_exp$NeHrat <- momidat_exp$Neh_best/momidat_exp$trueNeH
momidat_exp$NeCrat <- momidat_exp$Nec_best/momidat_exp$trueNeC
momidat_exp$history="Expansion"
momidat_exp$method="momi2"

gonedat_exp=read.csv("inferences/GONEdata_exp.csv",header=T)
gonedat_exp$scen=paste(gonedat_exp$NeAnc,gonedat_bot$td,gonedat_exp$lambda)
gonedat_exp$trueNeH=tru$TrueNeH[match(gonedat_exp$scen,tru$scen)]
gonedat_exp$trueNeC=tru$TrueNec[match(gonedat_exp$scen,tru$scen)]
gonedat_exp$NeHerr=abs(gonedat_exp$Neh-gonedat_exp$trueNeH)/gonedat_exp$trueNeH
gonedat_exp$NeCerr=abs(gonedat_exp$Nec-gonedat_exp$trueNeC)/gonedat_exp$trueNeC
gonedat_exp$NeHrat <- gonedat_exp$Neh/gonedat_exp$trueNeH
gonedat_exp$NeCrat <- gonedat_exp$Nec/gonedat_exp$trueNeC
gonedat_exp$history="Expansion"
gonedat_exp$method="GONE"

stairdat_exp=read.csv("inferences/stairwaydata_exp.csv",header=T)
stairdat_exp$scen=paste(stairdat_exp$NeAnc,gonedat_bot$td,stairdat_exp$lambda)
stairdat_exp$trueNeH=tru$TrueNeH[match(stairdat_exp$scen,tru$scen)]
stairdat_exp$trueNeC=tru$TrueNec[match(stairdat_exp$scen,tru$scen)]
stairdat_exp$NeHerr=abs(stairdat_exp$Neh-stairdat_exp$trueNeH)/stairdat_exp$trueNeH
stairdat_exp$NeCerr=abs(stairdat_exp$Nec-stairdat_exp$trueNeC)/stairdat_exp$trueNeC
stairdat_exp$NeHrat <- stairdat_exp$Neh/stairdat_exp$trueNeH
stairdat_exp$NeCrat <- stairdat_exp$Nec/stairdat_exp$trueNeC
stairdat_exp$history="Expansion"
stairdat_exp$method="Stairway"

momidat_basic %>% 
  filter(!grepl('td130|td160|td190 l99|n10e3',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_basic_filt

gonedat_basic %>% 
  filter(!grepl('td130|td160|td190 l99|n10e3',scen)) %>% 
  filter(sampn=="n100")-> gonedat_basic_filt

stairdat_basic %>% 
  filter(!grepl('td130|td160|td190 l99|n10e3',scen)) %>% 
  filter(sampn=="n100")-> stairdat_basic_filt

momidat_bot %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_bot_filt

gonedat_bot %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> gonedat_bot_filt

stairdat_bot %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> stairdat_bot_filt

momidat_exp %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_exp_filt

gonedat_exp %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> gonedat_exp_filt

stairdat_exp %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(sampn=="n100")-> stairdat_exp_filt

expbotcomp=rbind.fill(momidat_basic_filt,gonedat_basic_filt,stairdat_basic_filt,momidat_bot_filt,gonedat_bot_filt,stairdat_bot_filt,momidat_exp_filt,gonedat_exp_filt,stairdat_exp_filt)

expbotcomp$col=ifelse(expbotcomp$method == "Stairway","black",ifelse(expbotcomp$method == "GONE","purple",ifelse(expbotcomp$scheme=="t0","blue",ifelse(expbotcomp$scheme=="t0t120","green","orange"))))

expbotcomp$methcomb=paste(expbotcomp$method,expbotcomp$data)

expbotcomp$methcomb=gsub("GONE wgs","GONE",expbotcomp$methcomb)
expbotcomp$methcomb=gsub("Stairway wgs","Stairway",expbotcomp$methcomb)
expbotcomp$methcomb=gsub("momi2 wgs","momi2/WGS",expbotcomp$methcomb)
expbotcomp$methcomb=gsub("momi2 rad50k","momi2/RAD",expbotcomp$methcomb)

expbotcomp$methcomb=factor(expbotcomp$methcomb,levels=c("GONE","Stairway","momi2/WGS","momi2/RAD"))


### filter by datatype???

p <- ggplot(expbotcomp, aes(x=method, y=NeHerr)) + 
  geom_boxplot()
p
p + facet_wrap(~history) 
+ scale_y_log10()

p <- ggplot(expbotcomp, aes(x=method, y=NeCerr)) + 
  geom_boxplot()
p
p + facet_wrap(~history) + scale_y_log10()

#### violins

p <- ggplot(expbotcomp, aes(x=methcomb, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,col=expbotcomp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'H/N'[E],'H'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~history) + scale_y_log10(limits=c(0.01,8))

ggsave("plots/expbot_NeH_violin.pdf",device="pdf")

p <- ggplot(expbotcomp, aes(x=methcomb, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col=expbotcomp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'C/N'[E],'C'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~history) + scale_y_log10(limits=c(0.01,8))

ggsave("plots/expbot_NeC_violin.pdf",device="pdf")
