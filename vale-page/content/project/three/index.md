---
title: 'Question 3 for Agrochemical Scoping Project: How does average cloud cover
  impact product performance on the East Coast?'
external_link: ''
date: "2016-04-27T00:00:00Z"
links: null
summary: null
image:
  focal_point: Smart
  preview_only: yes
share: no
profile: no
comments: no
reading_time: no
---



## Data sourcing

Cloud cover data is difficult to extract due to its complexity
and density. Large-scale data warehouses include satellite photographs of
land surfaces (LandSat program with NASA/USGS), which includes billions of
rows of data. The hard part isn’t analyzing the data – its *finding* it.

For this project, we developed a pipeline to pull all photographs in a 1-5km
buffer around surveyed farms. We then wrote a script to calculate the %
cloud cover from these aggregated photos. This process was repeated 7
times at each location to get the average weekly cloud cover.

In all, this gives us an accurate representation of how much cloudiness a farm
experienced before pesticide was applied to citrus trees.

<img src="map.png" style="border-radius: 5%;" />
Figure 1. Example “windows” of cloud cover data collected from sites in
Florida State. These are nine example locations provided in the
precision ag dataset from the client.

Of the three questions posed, this was the trickiest, but we hope it is also
the most useful. The underlying statistics & figures are the same as in
Question 2, but instead of temperature, we are looking at weekly % cloud
cover.

## Overall result from the cloud-cover analysis

As with high temperatures in Florida, product failure was slightly less likely on farms that have experienced a week of high cloud cover (Figure 2). Generally, the rate of failure is stable across all ranges of cloud cover (25% chance of product failure occurring).


```
## 
## Call:
## glm(formula = response ~ Cloud_cover, family = binomial, data = dat3)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.7848  -1.2491   0.7367   0.9365   1.1458  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept) -0.03271    0.61190  -0.053    0.957
## Cloud_cover  0.01536    0.01154   1.331    0.183
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 57.286  on 44  degrees of freedom
## Residual deviance: 55.425  on 43  degrees of freedom
## AIC: 59.425
## 
## Number of Fisher Scoring iterations: 4
```

<img src="{{< blogdown/postref >}}index_files/figure-html/cloud-1.png" width="672" />
(Figure 2: weak prediction with just cloud cover)

However, when accounting for temperature and cloud cover at the same time, we found that hot, clear days were much more likely to cause product failure than hot but cloudy days (Figure 3). When cloud cover is below 15%, hot days above 35.4C were much more likely to result in product failure, similar to the results found in California.


```
## 
## Call:
## glm(formula = response ~ Daily_high_temp * Cloud_cover, family = binomial, 
##     data = dat3)
## 
## Deviance Residuals: 
##      Min        1Q    Median        3Q       Max  
## -2.76102  -0.14589   0.09834   0.46179   1.23467  
## 
## Coefficients:
##                              Estimate Std. Error z value Pr(>|z|)   
## (Intercept)                 48.920843  17.684286   2.766  0.00567 **
## Daily_high_temp             -0.621579   0.227233  -2.735  0.00623 **
## Cloud_cover                 -0.909722   0.324100  -2.807  0.00500 **
## Daily_high_temp:Cloud_cover  0.011730   0.004192   2.798  0.00514 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 57.286  on 44  degrees of freedom
## Residual deviance: 25.086  on 41  degrees of freedom
## AIC: 33.086
## 
## Number of Fisher Scoring iterations: 7
```

<img src="{{< blogdown/postref >}}index_files/figure-html/interaction-1.png" width="672" />
(Figure 3: great p value for interaction of temp and cloudiness)

## What is the takeaway?

For end-users on the moist East coast, the best recommendation may be to avoid
using products on days with warm AND clear nights/mornings. That is, resembling a dry, hot Californian climate. On overcast days, they may be able to get away with applying pesticide anyway. But it isn't guaranteed to perform as well as under cooler conditions.
