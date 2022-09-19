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
gonedat_basic$scheme="t0"

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
stairdat_basic$scheme="t0"

momidat_bot=read.csv("inferences/momi_nomaf_data_4mods_bot_deltaAIC.csv",header=T)
momidat_bot %>% select(AIC2C,AIC1C,AICC,AICh)
momidat_bot %>% select(AIC2C,AIC1C,AICC,AICh) -> momidat_bot_AICs
momidat_bot$Neh_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nh,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nh1C,ifelse(max.col(-momidat_bot_AICs)==3,momidat_bot$NhC,momidat_bot$Nch)))
momidat_bot$Nec_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nc,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nc1C,ifelse(max.col(-momidat_bot_AICs)==3,momidat_bot$NcC,momidat_bot$Nch)))
momidat_bot$modsel=ifelse(max.col(-momidat_bot_AICs)==1,"Two Changes",ifelse(max.col(-momidat_bot_AICs)==2,"Recent Change",ifelse(max.col(-momidat_bot_AICs)==3,"Constant","Historic Change")))
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
gonedat_bot$scheme="t0"

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
stairdat_bot$scheme="t0"

momidat_exp=read.csv("inferences/momi_nomaf_data_4mods_exp_deltaAIC.csv",header=T)
momidat_exp %>% select(AIC2C,AIC1C,AICC,AICh)
momidat_exp %>% select(AIC2C,AIC1C,AICC,AICh) -> momidat_exp_AICs
momidat_exp$Neh_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_bot$Nh,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nh1C,ifelse(max.col(-momidat_exp_AICs)==3,momidat_exp$NhC,momidat_exp$NcC)))
momidat_exp$Nec_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_bot$Nc,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nc1C,ifelse(max.col(-momidat_exp_AICs)==3,momidat_exp$NcC,momidat_bot$NcC)))
momidat_exp$modsel=ifelse(max.col(-momidat_exp_AICs)==1,"Two Changes",ifelse(max.col(-momidat_exp_AICs)==2,"Recent Change",ifelse(max.col(-momidat_exp_AICs)==3,"Constant","Historic Change")))
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
gonedat_exp$scheme="t0"

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
stairdat_exp$scheme="t0"

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
p + geom_point(shape=16,col=expbotcomp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'H/N'[E],'H'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~history) + scale_y_log10(limits=c(0.01,18.2))

ggsave("plots/expbot_NeH_4mods_violin.pdf",device="pdf")

p <- ggplot(expbotcomp, aes(x=methcomb, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col=expbotcomp$col) + xlab("Method") + ylab(expression(paste(widehat('N'[E]),'C/N'[E],'C'))) + geom_hline(yintercept=1,linetype="dashed") + facet_wrap(~history) + scale_y_log10(limits=c(0.01,18.2))

ggsave("plots/expbot_NeC_4mods_violin.pdf",device="pdf")

###contemp-only

expbotcomp %>% filter(scheme=="t0") -> expbotcompc

expbotcomp1=expbotcompc

expbotcomp2=expbotcompc

expbotcomp1$metric="NEH"
expbotcomp2$metric="NEC"
expbotcomp1$Nerat=expbotcomp1$NeHrat
expbotcomp2$Nerat=expbotcomp2$NeCrat

expbotcomp12=rbind(expbotcomp1,expbotcomp2)

expbotcomp12$metric=factor(expbotcomp12$metric,levels=c("NEH","NEC"))

p <- ggplot(expbotcomp12,aes(y=Nerat, x=methcomb, fill=metric, colour=scheme)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NEH"="black","NEC"="white"))+
  ylab(expression(paste(hat(N)["E"],'/N'["E"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.005,50)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/expbot_NeHCrat_050922.pdf",device="pdf")



##### just the momis

tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

momidat_bot=read.csv("inferences/momi_nomaf_data_4mods_bot_deltaAIC.csv",header=T)
momidat_bot %>% select(AIC2C,AIC1C,AICC,AICh)
momidat_bot %>% select(AIC2C,AIC1C,AICC,AICh) -> momidat_bot_AICs
momidat_bot$Neh_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nh,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nh1C,ifelse(max.col(-momidat_bot_AICs)==3,momidat_bot$NhC,momidat_bot$Nch)))
momidat_bot$Nec_best=ifelse(max.col(-momidat_bot_AICs)==1,momidat_bot$Nc,ifelse(max.col(-momidat_bot_AICs)==2,momidat_bot$Nc1C,ifelse(max.col(-momidat_bot_AICs)==3,momidat_bot$NcC,momidat_bot$Nch)))
momidat_bot$modsel=ifelse(max.col(-momidat_bot_AICs)==1,"Two Changes",ifelse(max.col(-momidat_bot_AICs)==2,"Recent Change",ifelse(max.col(-momidat_bot_AICs)==3,"Constant","Historic Change")))
momidat_bot$scen=paste(momidat_bot$NeAnc,momidat_bot$td,momidat_bot$lambda)
momidat_bot$trueNeH=tru$TrueNeH[match(momidat_bot$scen,tru$scen)]
momidat_bot$trueNeC=tru$TrueNec[match(momidat_bot$scen,tru$scen)]
momidat_bot$NeHerr=abs(momidat_bot$Neh_best-momidat_bot$trueNeH)/momidat_bot$trueNeH
momidat_bot$NeCerr=abs(momidat_bot$Nec_best-momidat_bot$trueNeC)/momidat_bot$trueNeC
momidat_bot$NeHrat <- momidat_bot$Neh_best/momidat_bot$trueNeH
momidat_bot$NeCrat <- momidat_bot$Nec_best/momidat_bot$trueNeC
momidat_bot$history="Bottleneck"
momidat_bot$method="momi2"

momidat_bot_wrong=read.csv("inferences/momi_nomaf_data_bot_all_deltaAIC.csv",header=T)
#momidat_bot_wrong %>% select(AIC1C,AICC)
momidat_bot_wrong %>% select(AIC1C,AICC) -> momidat_bot_wrong_AICs
momidat_bot_wrong$Neh_best=ifelse(max.col(-momidat_bot_wrong_AICs)==1,momidat_bot_wrong$Nh1C,momidat_bot_wrong$NhC)
momidat_bot_wrong$Nec_best=ifelse(max.col(-momidat_bot_wrong_AICs)==1,momidat_bot_wrong$Nc1C,momidat_bot_wrong$NcC)
momidat_bot_wrong$modsel=ifelse(max.col(-momidat_bot_wrong_AICs)==1,"Recent Change","Constant")
momidat_bot_wrong$scen=paste(momidat_bot_wrong$NeAnc,momidat_bot_wrong$td,momidat_bot_wrong$lambda)
momidat_bot_wrong$trueNeH=tru$TrueNeH[match(momidat_bot_wrong$scen,tru$scen)]
momidat_bot_wrong$trueNeC=tru$TrueNec[match(momidat_bot_wrong$scen,tru$scen)]
momidat_bot_wrong$NeHerr=abs(momidat_bot_wrong$Neh_best-momidat_bot_wrong$trueNeH)/momidat_bot_wrong$trueNeH
momidat_bot_wrong$NeCerr=abs(momidat_bot_wrong$Nec_best-momidat_bot_wrong$trueNeC)/momidat_bot_wrong$trueNeC
momidat_bot_wrong$NeHrat <- momidat_bot_wrong$Neh_best/momidat_bot_wrong$trueNeH
momidat_bot_wrong$NeCrat <- momidat_bot_wrong$Nec_best/momidat_bot_wrong$trueNeC
momidat_bot_wrong$history="Bottleneck"
momidat_bot_wrong$method="momi2"

momidat_bot$wrong="NotWrong"

momidat_bot_wrong$wrong="Wrong"

momidat_bot_rightwrong=rbind.fill(momidat_bot,momidat_bot_wrong)

momidat_bot_rightwrong$scheme=gsub("t0t120","Contemporary Only",momidat_bot_rightwrong$scheme)
momidat_bot_rightwrong$scheme=gsub("t0","Two Samples",momidat_bot_rightwrong$scheme)
momidat_bot_rightwrong$scheme=gsub("all","Serial Sampling",momidat_bot_rightwrong$scheme)

momidat_bot_rightwrong$scheme=factor(momidat_bot_rightwrong$scheme,levels=c("Contemporary Only","Two Samples","Serial Sampling"))


p <- ggplot(momidat_bot_rightwrong,aes(y=NeCrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.005,50)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEC_bot_momiwrong_050922.pdf",device="pdf")

p <- ggplot(momidat_bot_rightwrong,aes(y=NeHrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.005,50)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEH_bot_momiwrong_050922.pdf",device="pdf")


##############

tru=read.csv("inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

momidat_exp=read.csv("inferences/momi_nomaf_data_4mods_exp_deltaAIC.csv",header=T)
momidat_exp %>% select(AIC2C,AIC1C,AICC,AICh)
momidat_exp %>% select(AIC2C,AIC1C,AICC,AICh) -> momidat_exp_AICs
momidat_exp$Neh_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_exp$Nh,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nh1C,ifelse(max.col(-momidat_exp_AICs)==3,momidat_exp$NhC,momidat_exp$Nch)))
momidat_exp$Nec_best=ifelse(max.col(-momidat_exp_AICs)==1,momidat_exp$Nc,ifelse(max.col(-momidat_exp_AICs)==2,momidat_exp$Nc1C,ifelse(max.col(-momidat_exp_AICs)==3,momidat_exp$NcC,momidat_exp$Nch)))
momidat_exp$modsel=ifelse(max.col(-momidat_exp_AICs)==1,"Two Changes",ifelse(max.col(-momidat_exp_AICs)==2,"Recent Change",ifelse(max.col(-momidat_exp_AICs)==3,"Constant","Historic Change")))
momidat_exp$scen=paste(momidat_exp$NeAnc,momidat_exp$td,momidat_exp$lambda)
momidat_exp$trueNeH=tru$TrueNeH[match(momidat_exp$scen,tru$scen)]
momidat_exp$trueNeC=tru$TrueNec[match(momidat_exp$scen,tru$scen)]
momidat_exp$NeHerr=abs(momidat_exp$Neh_best-momidat_exp$trueNeH)/momidat_exp$trueNeH
momidat_exp$NeCerr=abs(momidat_exp$Nec_best-momidat_exp$trueNeC)/momidat_exp$trueNeC
momidat_exp$NeHrat <- momidat_exp$Neh_best/momidat_exp$trueNeH
momidat_exp$NeCrat <- momidat_exp$Nec_best/momidat_exp$trueNeC
momidat_exp$history="Expansion"
momidat_exp$method="momi2"

momidat_exp_wrong=read.csv("inferences/momi_nomaf_data_exp_all_deltaAIC.csv",header=T)
momidat_exp_wrong %>% select(AIC1C,AICC)
momidat_exp_wrong %>% select(AIC1C,AICC) -> momidat_exp_wrong_AICs
momidat_exp_wrong$Neh_best=ifelse(max.col(-momidat_exp_wrong_AICs)==1,momidat_exp_wrong$Nh1C,momidat_exp_wrong$NhC)
momidat_exp_wrong$Nec_best=ifelse(max.col(-momidat_exp_wrong_AICs)==1,momidat_exp_wrong$Nc1C,momidat_exp_wrong$NcC)
momidat_exp_wrong$modsel=ifelse(max.col(-momidat_exp_wrong_AICs)==1,"Recent Change","Constant")
momidat_exp_wrong$scen=paste(momidat_exp_wrong$NeAnc,momidat_exp_wrong$td,momidat_exp_wrong$lambda)
momidat_exp_wrong$trueNeH=tru$TrueNeH[match(momidat_exp_wrong$scen,tru$scen)]
momidat_exp_wrong$trueNeC=tru$TrueNec[match(momidat_exp_wrong$scen,tru$scen)]
momidat_exp_wrong$NeHerr=abs(momidat_exp_wrong$Neh_best-momidat_exp_wrong$trueNeH)/momidat_exp_wrong$trueNeH
momidat_exp_wrong$NeCerr=abs(momidat_exp_wrong$Nec_best-momidat_exp_wrong$trueNeC)/momidat_exp_wrong$trueNeC
momidat_exp_wrong$NeHrat <- momidat_exp_wrong$Neh_best/momidat_exp_wrong$trueNeH
momidat_exp_wrong$NeCrat <- momidat_exp_wrong$Nec_best/momidat_exp_wrong$trueNeC
momidat_exp_wrong$history="Expansion"
momidat_exp_wrong$method="momi2"

momidat_exp$wrong="NotWrong"

momidat_exp_wrong$wrong="Wrong"

momidat_exp_rightwrong=rbind.fill(momidat_exp,momidat_exp_wrong)

momidat_exp_rightwrong$scheme=gsub("t0t120","Contemporary Only",momidat_exp_rightwrong$scheme)
momidat_exp_rightwrong$scheme=gsub("t0","Two Samples",momidat_exp_rightwrong$scheme)
momidat_exp_rightwrong$scheme=gsub("all","Serial Sampling",momidat_exp_rightwrong$scheme)

momidat_exp_rightwrong$scheme=factor(momidat_exp_rightwrong$scheme,levels=c("Contemporary Only","Two Samples","Serial Sampling"))

p <- ggplot(momidat_exp_rightwrong,aes(y=NeCrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.0001,10000)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEC_exp_momiwrong_050922.pdf",device="pdf")

p <- ggplot(momidat_exp_rightwrong,aes(y=NeHrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.005,50)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEH_exp_momiwrong_050922.pdf",device="pdf")


######

momi_comb=rbind.fill(momidat_bot_rightwrong,momidat_exp_rightwrong)

p <- ggplot(momi_comb,aes(y=NeCrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.0001,20000)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEC_expbot_momiwrong_050922.pdf",device="pdf")

p <- ggplot(momi_comb,aes(y=NeHrat, x=scheme, fill=wrong)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
  scale_color_manual(values=c("t0"="black"))+
  scale_fill_manual(values=c("NotWrong"="white","Wrong"="red"))+
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +
  xlab("") +
  facet_wrap(~history) +
  # facet_grid(cols=vars(method),rows=vars(data)) +
  scale_y_log10(limits=c(0.005,50)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("")

ggsave("plots/NEH_expbot_momiwrong_050922.pdf",device="pdf")