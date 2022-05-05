momiconf=read.csv(file="inferences/momi_nomaf_data_deltaAIC.csv",head=TRUE)

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$bestmod=ifelse(momiconf$AIC_change>momiconf$AIC_cons,"Constant","Change")
momiconf$correctmod=ifelse(momiconf$lambda=="constant","Constant","Change")
momiconf$correct=ifelse(momiconf$bestmod==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))
  
momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

library(caret)

cm<-confusionMatrix(data=factor(momiconf$bestmod),reference=factor(momiconf$correctmod))

plt <- as.data.frame(cm$table)
plt$Prediction <- factor(plt$Prediction, levels=rev(levels(plt$Prediction)))

ggplot(plt, aes(Prediction,Reference, fill= Freq)) +
  geom_tile() + geom_text(aes(label=Freq)) +
  scale_fill_gradient(low="white", high="#009194") +
  labs(x = "Generative Model",y = "Best Fit Model") +
  scale_x_discrete(labels=c("Constant Size","Decline")) +
  scale_y_discrete(labels=c("Size Change","Constant Size"))

library(dplyr)
library(tidyverse)

##### confusion plots

titulo=expression(paste('WGS, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs1k.pdf",device="pdf")

titulo=expression(paste('WGS, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs10k.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k1k.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k10k.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k1k.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k10k.pdf",device="pdf")

# ### combined nes
# 
# momiconf %>%
#   filter(data=="wgs") %>%
#   unite("DeclineScenario",td,lambda) %>%
#   group_by(DeclineScenario,sampn,scheme) %>%
#   summarize(Correct=sum(correct=="Correct")) %>%
#   ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
#   geom_tile() +
#   ggtitle("WGS") +
#   scale_fill_gradient(low="red",high="blue",limits=c(0,10)) +
#   scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
#   facet_wrap(~sampn)
# 
# momiconf %>%
#   filter(data=="rad10k") %>%
#   unite("DeclineScenario",td,lambda) %>%
#   group_by(DeclineScenario,sampn,scheme) %>%
#   summarize(Correct=sum(correct=="Correct")) %>%
#   ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
#   geom_tile() +
#   ggtitle("10k RAD loci") +
#   scale_fill_gradient(low="red",high="blue",limits=c(0,10)) +
#   scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
#   facet_wrap(~sampn)
# 
# 
# momiconf %>%
#   filter(data=="rad50k") %>%
#   unite("DeclineScenario",td,lambda) %>%
#   group_by(DeclineScenario,sampn,scheme) %>%
#   summarize(Correct=sum(correct=="Correct")) %>%
#   ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
#   geom_tile() +
#   ggtitle("50k RAD loci") +
#   scale_fill_gradient(low="red",high="blue",limits=c(0,10)) +
#   scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
#   facet_wrap(~sampn)

##### accuracy for constant simulations where change was chosen as the best model

par(mfrow=c(1,1))

cons_wrong=momiconf[which(momiconf$correct=="Incorrect" & momiconf$DeclineScenario=="Constant"),]

p <- ggplot(cons_wrong, aes(x=ratio, y=data)) + 
  geom_violin()
p + coord_flip() + geom_point(shape=16) + ylab("Data Type") + xlab("NeH/NeC") + geom_vline(xintercept=1,linetype="dashed") + scale_x_log10()

#### do g = 3

momiconf=read.csv(file="inferences/momi_nomaf_data_g3_deltaAIC.csv",head=TRUE)

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$bestmod=ifelse(momiconf$AIC_change>momiconf$AIC_cons,"Constant","Change")
momiconf$correctmod=ifelse(momiconf$lambda=="constant","Constant","Change")
momiconf$correct=ifelse(momiconf$bestmod==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))


titulo=expression(paste('WGS, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs1k_g3.pdf",device="pdf")

titulo=expression(paste('WGS, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs10k_g3.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k1k_g3.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k10k_g3.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 1k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e3") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k1k_g3.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k10k_g3.pdf",device="pdf")

#### do expansion
#### no historic-only change!!

momiconf=read.csv(file="inferences/momi_nomaf_data_exp_hc_deltaAIC.csv",head=TRUE)

momiconf %>% select(AIC2C,AIC1C,AICC,AICh) -> momiconf_AICs
momiconf$modsel=ifelse(max.col(-momiconf_AICs)==1,"Two Changes",ifelse(max.col(-momiconf_AICs)==2,"Recent Change",ifelse(max.col(-momiconf_AICs)==3,"Constant","Historic Change")))

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$correctmod=ifelse(momiconf$lambda=="constant","Historic Change","Two Changes")
momiconf$correct=ifelse(momiconf$modsel==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

titulo=expression(paste('WGS, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs10k_exp_hc.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k10k_exp_hc.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k10k_exp_hc.pdf",device="pdf")

#### do bottleneck
#### no historic-only change!!

momiconf=read.csv(file="inferences/momi_nomaf_data_bot_all_deltaAIC.csv",head=TRUE)

momiconf %>% select(AIC2C,AIC1C,AICC) -> momidat_bot_AICs
momiconf$modsel=ifelse(max.col(-momidat_bot_AICs)==1,"Two Changes",ifelse(max.col(-momidat_bot_AICs)==2,"Recent Change","Constant"))

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$correctmod=ifelse(momiconf$lambda=="constant","Constant","Two Changes")
momiconf$correct=ifelse(momiconf$modsel==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

titulo=expression(paste('WGS, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_wgs10k_bot.pdf",device="pdf")

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad10k10k_bot.pdf",device="pdf")

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  theme(axis.text.x = element_text(angle = 15))+
  facet_wrap(~sampn)
ggsave("plots/momi_confusion_rad50k10k_bot.pdf",device="pdf")

#### do singleton
#### we don't need this - for all singletons change is selected!!

momiconf=read.csv(file="inferences/momi_nomaf_data_single2samp.csv",head=TRUE)

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$bestmod=ifelse(momiconf$AIC>momiconf$AIC_Cons,"Constant","Change")
momiconf$correctmod=ifelse(momiconf$lambda=="constant","Constant","Change")
momiconf$correct=ifelse(momiconf$bestmod==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  facet_wrap(~sampn)

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  facet_wrap(~sampn)

#### do maf

#### do maf
#### we don't need this - for all singletons change is selected!!

momiconf=read.csv(file="inferences/momi_maf1_data_deltaAIC.csv",head=TRUE)

# momiconf_constant=subset(momiconf,momiconf$td=="constant" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td100l99=subset(momiconf,momiconf$td=="td100" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td130l99=subset(momiconf,momiconf$td=="td130" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td160l99=subset(momiconf,momiconf$td=="td160" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l99=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l99" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_td190l95=subset(momiconf,momiconf$td=="td190" & momiconf$lambda =="l95" & momiconf$scheme=="t0t120" & momiconf$sampn=="n200")
# momiconf_n200=subset(momiconf,momiconf$sampn=="n200")

momiconf$bestmod=ifelse(momiconf$AIC>momiconf$AICC,"Constant","Change")
momiconf$correctmod=ifelse(momiconf$lambda=="constant","Constant","Change")
momiconf$correct=ifelse(momiconf$bestmod==momiconf$correct,"Correct","Incorrect")

momiconf$td=gsub("td100","120Gens",momiconf$td)
momiconf$td=gsub("td130","90Gens",momiconf$td)
momiconf$td=gsub("td160","60Gens",momiconf$td)
momiconf$td=gsub("td190","30Gens",momiconf$td)

momiconf$lambda=gsub("l99","Slow",momiconf$lambda)
momiconf$lambda=gsub("l95","Fast",momiconf$lambda)

momiconf %>% unite("DeclineScenario",td,lambda) -> momiconf

momiconf$DeclineScenario=gsub("constant_constant","Constant",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",momiconf$DeclineScenario)
momiconf$DeclineScenario=factor(momiconf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

momiconf$sampn=gsub("n20","n = 20",momiconf$sampn)
momiconf$sampn=gsub("n50","n = 50",momiconf$sampn)
momiconf$sampn=gsub("n100","n = 100",momiconf$sampn)
momiconf$sampn=gsub("n200","n = 200",momiconf$sampn)
momiconf$sampn=factor(momiconf$sampn,levels=c("n = 20","n = 50","n = 100","n = 200"))

titulo=expression(paste('10k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad10k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  facet_wrap(~sampn)

titulo=expression(paste('50k RAD loci, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="rad50k") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  facet_wrap(~sampn)

titulo=expression(paste('WGS, Ancestral ',N[E],' = 10k'))
momiconf %>%
  filter(data=="wgs") %>%
  filter(NeAnc=="n10e4") %>%
  group_by(DeclineScenario,sampn,scheme) %>%
  dplyr::summarize(Correct=sum(correct=="Correct")) %>%
  ggplot(aes(scheme,DeclineScenario,fill=Correct)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="red",high="blue",limits=c(0,5)) +
  scale_x_discrete(labels=c("Serial","Two Samples","Contemporary")) +
  facet_wrap(~sampn)



#### NeEst infinites in similar fash

neestinf=read.csv(file="inferences/LDNeoutall.csv",head=TRUE)

neestinf$td=gsub("100","120Gens",neestinf$td)
neestinf$td=gsub("130","90Gens",neestinf$td)
neestinf$td=gsub("160","60Gens",neestinf$td)
neestinf$td=gsub("190","30Gens",neestinf$td)

neestinf$l=gsub("99","Slow",neestinf$l)
neestinf$l=gsub("95","Fast",neestinf$l)

neestinf %>% 
  filter(scheme == "2samp") %>%
  filter(maf == 0.05) %>% 
  unite("DeclineScenario",td,l) -> neestinf

neestinf$DeclineScenario=gsub("constant_constant","Constant",neestinf$DeclineScenario)
neestinf$DeclineScenario=gsub("30Gens_Slow","Slow Decline,30 Generations",neestinf$DeclineScenario)
neestinf$DeclineScenario=gsub("60Gens_Slow","Slow Decline,60 Generations",neestinf$DeclineScenario)
neestinf$DeclineScenario=gsub("90Gens_Slow","Slow Decline,90 Generations",neestinf$DeclineScenario)
neestinf$DeclineScenario=gsub("120Gens_Slow","Slow Decline,120 Generations",neestinf$DeclineScenario)
neestinf$DeclineScenario=gsub("30Gens_Fast","Fast Decline,30 Generations",neestinf$DeclineScenario)
neestinf$DeclineScenario=factor(neestinf$DeclineScenario,levels=c("Constant","Slow Decline,30 Generations","Slow Decline,60 Generations","Slow Decline,90 Generations","Slow Decline,120 Generations","Fast Decline,30 Generations"))

neestinf$nsamp=gsub("50","n = 50",neestinf$nsamp)
neestinf$nsamp=gsub("100","n = 100",neestinf$nsamp)
neestinf$nsamp=gsub("200","n = 200",neestinf$nsamp)
neestinf$sampn=factor(neestinf$nsamp,levels=c("n = 20","n = 50","n = 100","n = 200"))

titulo=expression(paste('Proportion ',N[E],'H infinite, 50k RAD loci, Ancestral ',N[E],' = 1k'))
neestinf %>%
  filter(nloc=="50k") %>%
  filter(timepoint=="t0") %>% 
  filter(nhist==10000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeH_rad50k1k.pdf",device="pdf")

titulo=expression(paste('Proportion ',N[E],'H infinite, 50k RAD loci, Ancestral ',N[E],' = 10k'))
neestinf %>%
  filter(nloc=="50k") %>%
  filter(timepoint=="t0") %>% 
  filter(nhist==100000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeH_rad50k10k.pdf",device="pdf")


titulo=expression(paste('Proportion ',N[E],'H infinite, 10k RAD loci, Ancestral ',N[E],' = 1k'))
neestinf %>%
  filter(nloc=="10k") %>%
  filter(timepoint=="t0") %>% 
  filter(nhist==10000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeH_rad10k1k.pdf",device="pdf")

titulo=expression(paste('Proportion ',N[E],'H infinite, 10k RAD loci, Ancestral ',N[E],' = 10k'))
neestinf %>%
  filter(nloc=="10k") %>%
  filter(timepoint=="t0") %>% 
  filter(nhist==100000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeH_rad10k10k.pdf",device="pdf")







titulo=expression(paste('Proportion ',N[E],'C infinite, 50k RAD loci, Ancestral ',N[E],' = 1k'))
neestinf %>%
  filter(nloc=="50k") %>%
  filter(timepoint=="t120") %>% 
  filter(nhist==10000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeC_rad50k1k.pdf",device="pdf")

titulo=expression(paste('Proportion ',N[E],'C infinite, 50k RAD loci, Ancestral ',N[E],' = 10k'))
neestinf %>%
  filter(nloc=="50k") %>%
  filter(timepoint=="t120") %>% 
  filter(nhist==100000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeC_rad50k10k.pdf",device="pdf")


titulo=expression(paste('Proportion ',N[E],'C infinite, 10k RAD loci, Ancestral ',N[E],' = 1k'))
neestinf %>%
  filter(nloc=="10k") %>%
  filter(timepoint=="t120") %>% 
  filter(nhist==10000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeC_rad10k1k.pdf",device="pdf")

titulo=expression(paste('Proportion ',N[E],'C infinite, 10k RAD loci, Ancestral ',N[E],' = 10k'))
neestinf %>%
  filter(nloc=="10k") %>%
  filter(timepoint=="t120") %>% 
  filter(nhist==100000) %>%
  group_by(DeclineScenario,sampn) %>%
  dplyr::summarize(nInfinite=sum(Ne=="Infinite")) %>%
  mutate(Infinite=nInfinite/5) %>% 
  ggplot(aes(sampn,DeclineScenario,fill=Infinite)) +
  geom_tile() +
  ggtitle(titulo) +
  scale_fill_gradient(low="blue",high="red",limits=c(0,1)) +
  xlab("Number of samples")

ggsave("plots/neestinf_NeC_rad10k10k.pdf",device="pdf")
