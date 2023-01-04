#####################
# 1. LOAD LIBRARIES #
#####################

library(rstudioapi)
library(dplyr)
library(lme4)
library(lmerTest)
library(sjstats)
library(car)
library(ggplot2)
library(ggthemes)
library(merTools)

# Set contrasts for statistical analyses and WD for reading in data from same dir as script
options(contrasts = c("contr.sum","contr.poly"))
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#####################
# 2.   LOAD DATA    #
#####################

# Read in size/age/reproductive data and convert categories to factors
all=read.csv('cg_all.csv')
all$round=as.factor(all$round)
all$chemostat=as.factor(all$chemostat)
all$gen=as.factor(all$gen)
all$treatment=as.factor(all$treatment)
all$block=as.factor(all$block)

# Drop bad rows for the non-reproductive analyses
all.2=all[which(is.na(all$bad.angle)),]

# Drop bad rows for the reproductive analyses, calculate fecundity, then store g0, g1, g2 separately for convenience
all.3=all[which(is.na(all$bad.angle) & is.na(all$eggs.damaged) & is.na(all$fuzzy.eggs)),]
all.3$fecundity=all.3$sac.area/(pi*(0.5*all.3$egg.mean)^2)
g0=subset(all.3,gen==0)
g1=subset(all.3,gen==1)
g2=subset(all.3,gen==2)

# Read in survival data for supps
sv=read.csv('survival-sum-standardised.csv')
sv$lineage=as.factor(sv$lineage)
sv$gen=as.factor(sv$gen)
sv$block=as.factor(sv$block)
sv=subset(sv,round==1)


#####################
# 3.   CROSS-GEN    #
# a.   size         #
# b.   maturity     #
# c.   survival     #
#####################


### 3a. SIZE ###

# Fit LMM on size
sizeb=lmer(m.length ~ gen * treatment + block + (1|treatment:chemostat),REML=TRUE,data=subset(all.2,round==1)); anova(sizeb,type='3')

# Random effects, MSE, diagnostics
rand(sizeb)
sjstats::mse(sizeb)
plot(sizeb)
qqnorm(residuals(sizeb))

# Model again collapsing on block to get bootstrapped CIs to plot
sizeb=lmer(m.length~ gen * treatment + (1|treatment:chemostat),REML=TRUE,data=subset(all.2,round==1))

# Bootstrap upper & lower 95% CIs
bb=bootMer(sizeb,
              FUN=function(x)predict(x, re.form=NA),
              nsim=500)

pred.size1=subset(all.2,round==1)
pred.size1$lci=apply(bb$t, 2, quantile, 0.025)
pred.size1$uci=apply(bb$t, 2, quantile, 0.975)
pred.size1$sizepred=predict(sizeb,re.form=NA)

pred.size1 %>%
  group_by(treatment,gen) %>%
  summarise(mean = mean(sizepred),
            hci = mean(uci),
            dci = mean(lci))

# Plot and save figure
levels(pred.size1$treatment) <- c("High food","Low food")
ggplot(pred.size1, aes(x=gen, y=sizepred, group=treatment)) + #linetype=treatment, 
  geom_line(stat="identity", position=position_dodge(.1), aes(colour=treatment)) + geom_point(stat="identity", position=position_dodge(0.1), aes(shape=treatment,colour=treatment)) +
  geom_errorbar(aes(ymin=lci, ymax=uci, colour=treatment), width=.2, position=position_dodge(.1)) +
  labs(x="\nGeneration",y="Body size (mm)\n",linetype="Lineage",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("size.png", dpi=300, height=4, width=4, units="in")


### 3b. TIME TO MATURITY ###

# Fit LMM on age at maturity
ageb=lmer(age.at.maturity~ treatment * gen + block + (1|treatment:chemostat),REML=TRUE,data=subset(all.2,round==1)); anova(ageb,type='3')

# Check random effects, get MSE, model diagnostics
sjstats::mse(ageb)
rand(ageb)
plot(ageb) #residuals appear fairly randomly scattered
qqnorm(residuals(ageb)) #a bit of an uptick right at the tail ends but seems pretty ok

# Collapse on block for CI bootstrapping
ageb=lmer(age.at.maturity~ treatment * gen + (1|treatment:chemostat),REML=TRUE,data=subset(all.2,round==1))

# Bootstrap 95% CIs
bb=bootMer(ageb,
              FUN=function(x)predict(x, re.form=NA),
              nsim=500)

pred.a=subset(all.2,round==1 & !is.na(age.at.maturity))
pred.a$lci=apply(bb$t, 2, quantile, 0.025)
pred.a$uci=apply(bb$t, 2, quantile, 0.975)
pred.a$apred=predict(ageb,re.form=NA) 

pred.a %>%
  group_by(treatment,gen) %>%
  summarise(mean = mean(apred),
            hci = mean(uci),
            dci = mean(lci))

# Plot and save figures
levels(pred.a$treatment)=c("High food","Low food")
ggplot(pred.a, aes(x=gen, y=apred, group=treatment)) + 
  geom_line(stat="identity", position=position_dodge(.1), aes(colour=treatment)) + geom_point(stat="identity", position=position_dodge(0.1), aes(shape=treatment, colour=treatment)) +
  geom_errorbar(aes(ymin=lci, ymax=uci, colour=treatment), width=.2, position=position_dodge(.1)) +
  labs(x="\nGeneration",y="Age at maturity (days)\n",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("age at maturity.png", dpi=300, height=4, width=4, units="in")


### 3c. SURVIVAL (supp) ###

# LMM on survival rate
sv0=lmer(standardised.survival~lineage+gen+block+(1|lineage:Chemostat),REML=TRUE,data=sv); summary(sv0); anova(sv0,type='3')

#Check random effects, MSE, other diagnostics
rand(sv0)
sjstats::mse(sv0)
plot(sv0)
qqnorm(residuals(sv0))

# Drop block for the CI bootstrapping to collapse replicates
sv1=lmer(standardised.survival~lineage+gen+(1|lineage:Chemostat),REML=TRUE,data=sv)

# Bootstrap 95% CI intervals
bb=bootMer(sv1,
           FUN=function(x)predict(x, re.form=NA),
           nsim=500)
pr.sv=sv
pr.sv$lci=apply(bb$t, 2, quantile, 0.025)
pr.sv$uci=apply(bb$t, 2, quantile, 0.975)
pr.sv$svpred=predict(sv1,re.form=NA)
pr.sv %>%
  group_by(lineage) %>%
  summarise(mean = mean(svpred),
            hci = mean(uci),
            dci = mean(lci))

# Plot and save figure for supps
levels(pr.sv$lineage)=c("High food","Low food")
ggplot(pr.sv, aes(x=gen, y=svpred, group=lineage)) + 
  geom_line(stat="identity", position=position_dodge(.1), aes(colour=lineage)) + geom_point(stat="identity", position=position_dodge(0.1), aes(shape=lineage, colour=lineage)) +
  geom_errorbar(aes(ymin=lci, ymax=uci, colour=lineage), width=.2, position=position_dodge(.1)) +
  labs(x="\nGeneration",y="Survival rate (daily)\n",linetype="Lineage",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("survival.png", dpi=300, height=4, width=4, units="in")


#####################
# 4.  REPRODUCTION  # 
# a.  egg-size      #
# b.  fecundity     #
# c.  scaling       #
#####################


### 4a. EGG-SIZE ###

# Fit separate LMMs for g0, g1, g2
# Interactions removed from final g0, g1 models due to insignificance
egg0=lmer(egg.mean~ treatment + m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g0,round==1)); anova(egg0,type='3')
egg1=lmer(egg.mean~ treatment + m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g1,round==1)); anova(egg1,type='3')
egg2=lmer(egg.mean~ treatment * m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g2,round==1)); anova(egg2,type='3')

# Check random effects, get MSE, check diagnostics for each model
sjstats::mse(egg0); rand(egg0); plot(egg0); qqnorm(residuals(egg0))
sjstats::mse(egg1); rand(egg1); plot(egg1); qqnorm(residuals(egg1))
sjstats::mse(egg2); rand(egg2); plot(egg2); qqnorm(residuals(egg2))

# Plot G2 results
pred.egg2=cbind(subset(g2,round==1),predict(egg2))
levels(pred.egg2$treatment)=c("High food","Low food")
ggplot(pred.egg2,aes(y=egg.mean, x=m.length, group=interaction(chemostat, treatment), col=treatment, shape=treatment)) + 
  geom_line(aes(y=predict(egg2)), size=0.5) +
  geom_point(alpha = 0.6) + 
  guides(col=FALSE) +
  labs(x="\nMaternal size (mm)",y="Egg diameter (mm)\n",color="Lineage",linetype="Lineage",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("egg size g2.png", dpi=300, height=4, width=4, units="in")


### 4b. FECUNDITY ###

# Fit separate LMMs for g0, g1, g2
# Interactions removed from final g0, g1 models due to insignificance
fec0=lmer(fecundity~ treatment + m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g0,round==1)); anova(fec0,type='3')
fec1=lmer(fecundity~ treatment + m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g1,round==1)); anova(fec1,type='3')
fec2=lmer(fecundity~ treatment * m.length + block + (1|treatment:chemostat),REML=TRUE,data=subset(g2,round==1)); anova(fec2,type='3')

# Check random effects, get MSE, check diagnostics for each model
sjstats::mse(fec0); rand(fec0); plot(fec0); qqnorm(residuals(fec0))
sjstats::mse(fec1); rand(fec1); plot(fec1); qqnorm(residuals(fec1))
sjstats::mse(fec2); rand(fec2); plot(fec2); qqnorm(residuals(fec2))

# Plot the G2 results
pred.fec2=cbind(subset(g2,round==1),predict(fec2))
levels(pred.fec2$treatment)=c("High food","Low food")
ggplot(pred.fec2,aes(y=fecundity, x=m.length, group=interaction(chemostat, treatment), col=treatment, shape=treatment)) + 
  geom_line(aes(y=predict(fec2)), size=0.5) +
  geom_point(alpha = 0.6) + 
  guides(col=FALSE) +
  labs(x="\nMaternal size (mm)",y="Fecundity\n",color="Lineage",linetype="Lineage",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("fecundity g2.png", dpi=300, height=4, width=4, units="in")


### 4c. REPRODUCTIVE SCALING ###

# Pull egg size and fecundity model coefficients & calculate reproductive volume
pred.rvol2=cbind(subset(g2,round==1),predict(egg2),predict(fec2))
levels(pred.rvol2$treatment)=c("High food","Low food")
pred.rvol2$rv2=((4/3)*pi*(pred.rvol2$"predict(egg2)"/2)^3)*pred.rvol2$"predict(fec2)"

# Plot and save figure
ggplot(pred.rvol2,aes(y=rv2, x=m.length, group=interaction(chemostat, treatment), col=treatment, shape=treatment)) + 
  geom_smooth(method="lm",aes(), size=0.5, se=F) +
  geom_point(alpha = 0.6) + 
  guides(col=FALSE) +
  labs(x="\nMaternal size (mm)",y=bquote('Reproductive volume '~(mm^2)),color="Lineage",linetype="Lineage",shape="Lineage") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.position = "none",legend.box.background = element_rect(color="black", size=1)) + scale_colour_brewer(palette="Set1")
ggsave("reproductive volume.png", dpi=300, height=4, width=4, units="in") #72dpi and 300x300=4.16 x 4.16 in