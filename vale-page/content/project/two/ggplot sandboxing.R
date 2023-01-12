library(ggplot2)
library(tidyverse)
library(effects)
library(ecodatamisc)

dir = dirname(rstudioapi::getActiveDocumentContext()$path)
demo_dat = read.csv(paste0(dir,"/demo.csv"))

# Simple bar chart
bg = "#1b2724"
wh = "#ffffff"
pl = "#6eb39c"
  
demo_dat %>%
  group_by(Product_success) %>%
  summarize(value = n()) %>%
  ggplot(aes(x = Product_success, y = value)) +
    geom_bar(stat = 'identity', fill = pl) +
    labs(title = '', x = '\nSurvey Response', y = 'Count\n') +
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

demo_dat$response = as.factor(demo_dat$Product_success)
mod = glm(response ~ Daily_high_temp, family=binomial, data=demo_dat)
dat = allEffects(se=TRUE, xlevels=100, mod=mod) %>%
  as.data.frame()

ggplot(data=dat$Daily_high_temp,aes(x=Daily_high_temp, y=fit))+
  geom_line(linewidth=1,colour=pl) +
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se),alpha=.2,fill=pl) +
  labs(title = '', x = '\nDaily max temperature (F)', y = 'Probability of product failure\n') +
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
  geom_point(data=demo_dat, aes(x=Daily_high_temp, y=as.double(response)-1), position=position_jitter(w=0.05, h=0), alpha=.2, colour=pl)


