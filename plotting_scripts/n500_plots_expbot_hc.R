library(tidyverse)
library(ggplot2)
library(plyr)

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

momidat_bot=read.csv("inferences/momi_nomaf_data_bot_hc_deltaAIC.csv",header=T)
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

momidat_exp=read.csv("inferences/momi_nomaf_data_exp_hc_deltaAIC.csv",header=T)
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


momidat_basic %>% 
  filter(!grepl('td130|td160|td190 l99|n10e3',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_basic_filt

momidat_bot %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_bot_filt

momidat_exp %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) %>% 
  filter(data == "rad50k" & sampn == "n200" | data == "wgs" & sampn == "n100") -> momidat_exp_filt

expbotcomp=rbind.fill(momidat_basic_filt,momidat_bot_filt,momidat_exp_filt)

expbotcomp$methcomb=paste(expbotcomp$method,expbotcomp$data)

expbotcomp$methcomb=gsub("momi2 wgs","momi2/WGS",expbotcomp$methcomb)
expbotcomp$methcomb=gsub("momi2 rad50k","momi2/RAD",expbotcomp$methcomb)

expbotcomp$methcomb=factor(expbotcomp$methcomb,levels=c("momi2/WGS","momi2/RAD"))

### just look at momis

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

ggsave("plots/expbot_NeHCrat_momiwrong_050922.pdf",device="pdf")


