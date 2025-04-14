library(ggplot2)
library(tidyverse)
library(effects)
library(ggeffects)
library(ecodatamisc)

dir = dirname(rstudioapi::getActiveDocumentContext()$path)

demo_dat = read.csv(paste0(dir,"/demo.csv"))
demo_dat$response = as.factor(demo_dat$Product_success)
dat2 = subset(demo_dat,State=="California")
dat3 = subset(demo_dat,State=="Florida")

# Simple bar chart
bg = "#1b2724"
wh = "#ffffff"
pl = "#6eb39c"
  
demo_dat %>%
  group_by(Product_success) %>%
  summarize(value = n()) %>%
  ggplot(aes(x = Product_success, y = value)) +
    geom_bar(stat = 'identity', fill = pl) +
    labs(title = '', x = '\nWas the product effective?', y = 'Survey response count\n') +
    ylim(0,80) +
    theme_ecodata() +
    theme(
      panel.background = element_rect(fill=bg, colour=NA),
      plot.background = element_rect(fill=bg, colour=NA),
      axis.line = element_line(colour=wh),
      axis.text = element_text(colour=wh),
      axis.title.x = element_text(colour=wh),
      axis.title.y = element_text(colour=wh),
      panel.border = element_rect(colour=wh,fill=NA)
    )
    
# Simple glm plotggplot2




# Overall
mod1 = glm(response ~ Daily_high_temp, family=binomial, data=demo_dat)
eff1 = allEffects(se=TRUE, xlevels=100, mod=mod1) %>%
  as.data.frame()

ggplot(data=eff1$Daily_high_temp,aes(x=Daily_high_temp, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  scale_y_continuous(labels=scales::percent) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  labs(title = '', x = '\nDaily max. temp. (F)\nAll farms', y = 'Product success (%)\n') +
  theme_ecodata() +
  theme(
    panel.background = element_blank(),
    plot.background = element_rect(fill=bg, colour=bg),
    axis.line = element_line(colour=wh),
    axis.text = element_text(colour=wh),
    axis.title.x = element_text(colour=wh),
    axis.title.y = element_text(colour=wh),
    panel.border = element_rect(colour=wh,fill=NA)
  ) +
  geom_point(data=demo_dat, aes(x=Daily_high_temp, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.3, colour=pl)
ggsave("test.png", dpi=300, height=3, width=3, units="in")

summary(mod1)


# California

mod2 = glm(response ~ Daily_high_temp, family=binomial, data=dat2)
eff2 = allEffects(se=TRUE, xlevels=100, mod=mod2) %>%
  as.data.frame()

ggplot(data=eff2$Daily_high_temp,aes(x=Daily_high_temp, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  geom_hline(yintercept=0.75,colour=wh,linetype="dashed") +
  scale_y_continuous(labels=scales::percent) +
  labs(title = '', x = 'Daily max. temp. (F)\n\nCalifornia', y = 'Product success (%)\n') +
  theme_ecodata() +
  theme(
    panel.background = element_rect(fill=bg, colour=NA),
    plot.background = element_rect(fill=bg, colour=NA),
    axis.line = element_line(colour=wh),
    axis.text = element_text(colour=wh),
    axis.title.x = element_text(colour=wh),
    axis.title.y = element_text(colour=wh),
    panel.border = element_rect(colour=wh,fill=NA)
  ) +
  geom_point(data=dat2, aes(x=Daily_high_temp, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.3, colour=pl) +
  geom_rect(aes(xmin = 75, xmax = 95, ymin = .25, ymax = .975), 
          fill = "NA", alpha = 0.4, color = wh, linewidth = 1.5)

summary(mod2)



# Florida: temp only

mod3 = glm(response ~ Daily_high_temp, family=binomial, data=dat3)
eff3 = allEffects(se=TRUE, xlevels=100, mod=mod3) %>%
  as.data.frame()

ggplot(data=eff3$Daily_high_temp,aes(x=Daily_high_temp, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  scale_y_continuous(labels=scales::percent) +
  labs(title = '', x = '\nDaily max. temp. (F)\nFlorida', y = 'Product success (%)\n') +
  theme_ecodata() +
  theme(
    panel.background = element_rect(fill=bg, colour=NA),
    plot.background = element_rect(fill=bg, colour=NA),
    axis.line = element_line(colour=wh),
    axis.text = element_text(colour=wh),
    axis.title.x = element_text(colour=wh),
    axis.title.y = element_text(colour=wh),
    panel.border = element_rect(colour=wh,fill=NA)
  ) +
  geom_point(data=dat3, aes(x=Daily_high_temp, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.3, colour=pl)

summary(mod3)



# Florida: cloud cover
mod4 = glm(response ~ Cloud_cover, family=binomial, data=dat3); summary(mod4)
eff4 = allEffects(se=TRUE, xlevels=100, mod=mod4) %>%
  as.data.frame()

ggplot(data=eff4$Cloud_cover,aes(x=Cloud_cover, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  labs(title = '', x = '\nAverage weekly cloud cover (%)', y = 'Probability of product success\n') +
  theme_ecodata() +
  theme(
    panel.background = element_rect(fill=bg, colour=NA),
    plot.background = element_rect(fill=bg, colour=NA),
    axis.line = element_line(colour=wh),
    axis.text = element_text(colour=wh),
    axis.title.x = element_text(colour=wh),
    axis.title.y = element_text(colour=wh),
    panel.border = element_rect(colour=wh,fill=NA)
  ) +
  geom_point(data=dat3, aes(x=Cloud_cover, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.3, colour=pl)




# Florida: cloud cover * temp
dat3 = dat3 %>%
  mutate(cloudiness = case_when(
    Cloud_cover > 80 ~ "Overcast",
    Cloud_cover < 30 ~ "Sunny",
    TRUE ~ "Partially Sunny")
  )
  
eff5 = allEffects(se=TRUE, xlevels=100, mod=mod5) %>%
  as.data.frame()

mod5 = glm(response ~ Daily_high_temp * Cloud_cover, family=binomial, data=dat3); summary(mod5)
df = ggpredict(mod5, terms=c("Daily_high_temp[all]", "Cloud_cover[20,55]"), ci.lvl=NA)
ggplot(df,aes(x=x,y=predicted,group=group)) +
  geom_line(linewidth=1,colour=pl,aes(linetype=group)) +
  labs(title = '', x = '\nDaily max temperature (F)', y = 'Probability of product success\n') +
  theme_ecodata() +
  theme(
    legend.position="none",
    panel.background = element_rect(fill=bg, colour=NA),
    plot.background = element_rect(fill=bg, colour=NA),
    axis.line = element_line(colour=wh),
    axis.text = element_text(colour=wh),
    axis.title.x = element_text(colour=wh),
    axis.title.y = element_text(colour=wh),
    panel.border = element_rect(colour=wh,fill=NA)
  )



#trying to find that damn line

ggplot(data=eff3$Daily_high_temp,aes(x=Daily_high_temp, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  scale_y_continuous(labels=scales::percent) +
  labs(title = '', x = '\nDaily max. temp. (F)\nFlorida', y = 'Product success (%)\n') +
  theme_ecodata() +
  geom_point(data=dat3, aes(x=Daily_high_temp, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.3, colour=pl)
