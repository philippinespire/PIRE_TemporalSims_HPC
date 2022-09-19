library(tidyverse)
library(ggplot2)

gonedat_basic=read.csv("inferences/GONEdata.csv",header=T)

gonedat_split1=read.csv("inferences/GONEdata_split1.csv",header=T)

gonedat_split2=read.csv("inferences/GONEdata_split2.csv",header=T)

tru=read.csv("/Users/nerdbrained/Desktop/Rutger/slimulations/forwardslims_4manuscript/n500_inferences/truvalue.csv",header=T)
tru$scen=paste(tru$NeAnc,tru$td,tru$lambda)

gonedat_basic$scen=paste(gonedat_basic$NeAnc,gonedat_basic$td,gonedat_basic$lambda)
gonedat_basic$trueNeH=tru$TrueNeH[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$trueNeC=tru$TrueNec[match(gonedat_basic$scen,tru$scen)]
gonedat_basic$NeHerr=abs(gonedat_basic$Neh-gonedat_basic$trueNeH)/gonedat_basic$trueNeH
gonedat_basic$NeCerr=abs(gonedat_basic$Nec-gonedat_basic$trueNeC)/gonedat_basic$trueNeC
gonedat_basic$NeHrat <- gonedat_basic$Neh/gonedat_basic$trueNeH
gonedat_basic$NeCrat <- gonedat_basic$Nec/gonedat_basic$trueNeC
gonedat_basic$chromo="25 x 30 Mb"

gonedat_split1$scen=paste(gonedat_split1$NeAnc,gonedat_split1$td,gonedat_split1$lambda)
gonedat_split1$trueNeH=tru$TrueNeH[match(gonedat_split1$scen,tru$scen)]
gonedat_split1$trueNeC=tru$TrueNec[match(gonedat_split1$scen,tru$scen)]
gonedat_split1$NeHerr=abs(gonedat_split1$Neh-gonedat_split1$trueNeH)/gonedat_split1$trueNeH
gonedat_split1$NeCerr=abs(gonedat_split1$Nec-gonedat_split1$trueNeC)/gonedat_split1$trueNeC
gonedat_split1$NeHrat <- gonedat_split1$Neh/gonedat_split1$trueNeH
gonedat_split1$NeCrat <- gonedat_split1$Nec/gonedat_split1$trueNeC
gonedat_split1$chromo="150 x 5 Mb"

gonedat_split2$scen=paste(gonedat_split2$NeAnc,gonedat_split2$td,gonedat_split2$lambda)
gonedat_split2$trueNeH=tru$TrueNeH[match(gonedat_split2$scen,tru$scen)]
gonedat_split2$trueNeC=tru$TrueNec[match(gonedat_split2$scen,tru$scen)]
gonedat_split2$NeHerr=abs(gonedat_split2$Neh-gonedat_split2$trueNeH)/gonedat_split2$trueNeH
gonedat_split2$NeCerr=abs(gonedat_split2$Nec-gonedat_split2$trueNeC)/gonedat_split2$trueNeC
gonedat_split2$NeHrat <- gonedat_split2$Neh/gonedat_split2$trueNeH
gonedat_split2$NeCrat <- gonedat_split2$Nec/gonedat_split2$trueNeC
gonedat_split2$chromo="199 x 1 Mb"

#gonedat_basic %>% 
#  filter(!grepl('n10e3|td130|td160|td190 l99',scen)) %>% 
#  select('NeHerr','NeCerr','scheme','scen') -> nomaferr 

gonedat_basic %>% 
  filter(!grepl('td130|td160|td190 l99',scen)) -> basico 


gonesplit_comp=rbind(basico,gonedat_split1,gonedat_split2)

gonesplit_comp$scen=gsub("n10e4 constant constant","Constant Size",gonesplit_comp$scen)
gonesplit_comp$scen=gsub("n10e4 td100 l99","Slow Decline",gonesplit_comp$scen)
gonesplit_comp$scen=gsub("n10e4 td190 l95","Fast Decline",gonesplit_comp$scen)
gonesplit_comp$scen=gsub("n10e3 constant constant","Constant Size",gonesplit_comp$scen)
gonesplit_comp$scen=gsub("n10e3 td100 l99","Slow Decline",gonesplit_comp$scen)
gonesplit_comp$scen=gsub("n10e3 td190 l95","Fast Decline",gonesplit_comp$scen)

gonesplit_comp$sampn=gsub("n20","n = 20 contemporary individuals",gonesplit_comp$sampn)
gonesplit_comp$sampn=gsub("n50","n = 50 contemporary individuals",gonesplit_comp$sampn)
gonesplit_comp$sampn=gsub("n100","n = 100 contemporary individuals",gonesplit_comp$sampn)


gonesplit_comp$chromo=factor(gonesplit_comp$chromo,levels=c("199 x 1 Mb","150 x 5 Mb","25 x 30 Mb"))
gonesplit_comp$sampn=factor(gonesplit_comp$sampn,levels=c("n = 20 contemporary individuals","n = 50 contemporary individuals","n = 100 contemporary individuals"))


#### boxen

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeHerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scen) + scale_y_log10()

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeCerr)) + 
  geom_boxplot()
p
p + facet_wrap(~scen) + scale_y_log10()



######## violins

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,col="purple") + ggtitle("GONE inference on historic Ne") + xlab("Assembly Scheme") + ylab(expression(paste(widehat('N'[E]),'H/N'[E],'H'))) + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10() + facet_wrap(~scen+sampn)

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col="purple") + ggtitle("GONE inference on contemporary Ne") + xlab("Assembly Scheme") + ylab(expression(paste(widehat('N'[E]),'C/N'[E],'C'))) + geom_hline(yintercept=1,linetype="dashed") + scale_y_log10() + facet_wrap(~scen+sampn)

#### plotting both on the same y scale

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeHrat)) + geom_violin()
p + geom_point(shape=16,col="green") + 
  ggtitle("GONE inference and genome quality") + 
  xlab("Assembly Scheme") + 
  ylab(expression(paste(hat(N)["E,H"],'/N'["E,H"]))) +  
  geom_hline(yintercept=1,linetype="dashed") + 
  facet_wrap(~sampn) +
  theme_bw() +
  scale_y_log10(limits=c(0.1,162))

ggsave("plots/gonesplit_NeH_violin_revised0429.pdf",device="pdf")

p <- ggplot(gonesplit_comp, aes(x=chromo, y=NeCrat)) + geom_violin()
p + geom_point(shape=16,col="green") +
  ggtitle("GONE inference and genome quality") +
  xlab("Assembly Scheme") +
  ylab(expression(paste(hat(N)["E,C"],'/N'["E,C"]))) + 
  geom_hline(yintercept=1,linetype="dashed") +
  facet_wrap(~sampn) +
  theme_bw() +
  scale_y_log10(limits=c(0.1,162))

ggsave("plots/gonesplit_NeC_violin_revised0429.pdf",device="pdf")


### nec + neh together

gonesplit1=gonesplit_comp

gonesplit2=gonesplit_comp

gonesplit1$metric="NEH"
gonesplit2$metric="NEC"
gonesplit1$Nerat=gonesplit1$NeHrat
gonesplit2$Nerat=gonesplit2$NeCrat

gonesplit12=rbind(gonesplit1,gonesplit2)

gonesplit12$metric=factor(gonesplit12$metric,levels=c("NEH","NEC"))

p <- ggplot(gonesplit12,aes(y=Nerat, x=chromo, fill=metric)) 
p+ geom_hline(yintercept=1,linetype="dashed",col="gray") + geom_violin(position=position_dodge(width=0.5),scale="width", width=0.3, alpha=0.8,trim="false") +
#  scale_color_manual(values=c("Two Samples"="purple"))+
  scale_fill_manual(values=c("NEH"="black","NEC"="white"))+
  ylab(expression(paste(hat(N)["E"],'/N'["E"]))) +
  xlab("") +
  facet_wrap(~sampn) +
  scale_y_log10(limits=c(0.01,500)) +
  theme_bw() +
  theme(legend.position="none") +
  ggtitle("GONE accuracy under different chromosome assembly schemes")

ggsave("plots/gonesplits_NeHCrat_050922.pdf",device="pdf")


#451946

#shamalahamala22!