td100l99=read.table(file="trajectories/td100l99.txt",head=FALSE,sep=" ")
td100l99$pop=td100l99$V4+td100l99$V6

td100l95=read.table(file="trajectories/td100l95.txt",head=FALSE,sep=" ")
td100l95$pop=td100l95$V4+td100l95$V6

td130l99=read.table(file="trajectories/td130l99.txt",head=FALSE,sep=" ")
td130l99$pop=td130l99$V4+td130l99$V6

td130l95=read.table(file="trajectories/td130l95.txt",head=FALSE,sep=" ")
td130l95$pop=td130l95$V4+td130l95$V6

td160l99=read.table(file="trajectories/td160l99.txt",head=FALSE,sep=" ")
td160l99$pop=td160l99$V4+td160l99$V6

td160l95=read.table(file="trajectories/td160l95.txt",head=FALSE,sep=" ")
td160l95$pop=td160l95$V4+td160l95$V6

td190l99=read.table(file="trajectories/td190l99.txt",head=FALSE,sep=" ")
td190l99$pop=td190l99$V4+td190l99$V6

td190l95=read.table(file="trajectories/td190l95.txt",head=FALSE,sep=" ")
td190l95$pop=td190l95$V4+td190l95$V6

constant=read.table(file="trajectories/constant.txt",head=FALSE,sep=" ")
constant$pop=constant$V4+constant$V6


timeseq=seq(1802,2020)

par(mai=c(1.2,1.2,0.2,0.2))

plot(x=NULL,y=NULL,xlim=c(1800,2020),ylim=c(100, 20000),xlab="Year",ylab=expression('N'[E]),cex.lab=1.4,log="y")
lines(timeseq,td190l95$pop,col="red",lwd=3)
lines(timeseq,td100l99$pop,col="gold",lwd=3)
lines(timeseq,td130l99$pop,col="lightblue",lwd=1,lty=2)
lines(timeseq,td160l99$pop,col="violet",lwd=1,lty=2)
lines(timeseq,td190l99$pop,col="blue",lwd=1,lty=2)
lines(timeseq,constant$pop,col="green",lwd=4)

lines(timeseq,td190l95$pop/10,col="red",lwd=3)
lines(timeseq,td100l99$pop/10,col="gold",lwd=3)
lines(timeseq,td130l99$pop/10,col="lightblue",lwd=1,lty=2)
lines(timeseq,td160l99$pop/10,col="violet",lwd=1,lty=2)
lines(timeseq,td190l99$pop/10,col="blue",lwd=1,lty=2)
lines(timeseq,constant$pop/10,col="green",lwd=4)





#### plot with ancient history

library(plotrix)

par(mai=c(1.2,1.2,0.2,0.2),bty="n")
options(scipen=999)

timeseq_ybp1=seq(218,0)

timeseq_ybp2=seq(20000,1000)


gap.plot(x=NULL,y=NULL,gap=c(250,300),gap.axis="x",xlim=c(400,0),ylim=c(100, 200000),xlab="Years before present",ylab=expression('N'[e]),cex.lab=1.4,log="y",xtics=c(0,30,60,90,120,150,180,220),ytics=c(100,1000,10000,100000))


#plot(x=NULL,y=NULL,xlim=c(220,0),ylim=c(100, 20000),xlab="Years before present",ylab=expression('N'[e]),cex.lab=1.4,log="y")
lines(timeseq_ybp1,td190l95$pop,col="#D55E00",lwd=3)
lines(timeseq_ybp1,td100l99$pop,col="#E69F00",lwd=3)
lines(timeseq_ybp1,td130l99$pop,col="#56B4E9",lwd=1.5,lty=3)
lines(timeseq_ybp1,td160l99$pop,col="#CC79A7",lwd=1.5,lty=3)
lines(timeseq_ybp1,td190l99$pop,col="#0072B2",lwd=1.5,lty=3)
lines(timeseq_ybp1,constant$pop,col="#009E73",lwd=4)

lines(timeseq_ybp1,td190l95$pop/10,col="#D55E00",lwd=3)
lines(timeseq_ybp1,td100l99$pop/10,col="#E69F00",lwd=3)
lines(timeseq_ybp1,td130l99$pop/10,col="#56B4E9",lwd=1.5,lty=3)
lines(timeseq_ybp1,td160l99$pop/10,col="#CC79A7",lwd=1.5,lty=3)
lines(timeseq_ybp1,td190l99$pop/10,col="#0072B2",lwd=1.5,lty=3)
lines(timeseq_ybp1,constant$pop/10,col="#009E73",lwd=4)

abline(v=seq(240.1,300),col="white",lwd=8)
axis.break(1,225,style="slash")

paseq1=rep(1000,170)
timeaseq1=seq(400,231)

lines(timeaseq1,paseq1,col="#009E73",lwd=4)

paseq2=rep(10000,170)

lines(timeaseq1,paseq2,col="#009E73",lwd=4)

paseq3=c(rep(110000,85),rep(11000,85))

lines(timeaseq1,paseq3,col="#999933",lwd=2,lty=5)

paseq4=c(rep(1100,85),rep(9000,85))

lines(timeaseq1,paseq4,col="#DDCC77",lwd=2,lty=5)

axis(1,at=c(400,315,231),labels=c(20000,10000,NA))

text(x=150,y=200,labels="Forward Simulations")

arrows(180,350,120,350)

text(x=300,y=200,labels="Coalescent Simulations")

arrows(270,350,330,350)

text(x=0,y=13000,labels=expression('N'['e,C']))

text(x=180,y=13000,labels=expression('N'['e,H']))

text(x=380,y=13000,labels=expression('N'['e,A']))

legend(x=300,y=180000,legend=c("Constant","Ancient Expansion","Ancient Bottleneck"),bty="n",lty=c(1,5,5),col=c("#009E73","#999933","#DDCC77"),cex=0.8,lwd=c(2,2,2))
legend(x=160,y=180000,legend=c("Slow Decline, 30 Years","Slow Decline, 60 Years","Slow Decline, 90 Years","Slow Decline,120 Years","Fast Decline, 30 Years"),bty="n",lty=c(3,3,3,1,1),col=c("#0072B2","#CC79A7","#56B4E9","#E69F00","#D55E00"),cex=0.8,lwd=c(2,2,2))
