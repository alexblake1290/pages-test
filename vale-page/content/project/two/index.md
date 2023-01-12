---
date: "2016-04-27T00:00:00Z"
external_link: ""
image:
  focal_point: Smart
  preview_only: true
links:
summary: Null
title: "Question 2 for Agrochemical Scoping Project: How does daily temperature on orchards impact product performance?"
share: false
profile: false
comments: false
reading_time: false
---



## Data sourcing

The team at Valent had a strong assumption that the local
weather conditions, especially high and low temperatures, would impact the
performance of Accede. Survey data provided by Valent included GPS
coordinates for all farms and date of application, so we used that information
to pull from local weather stations located within a few miles. To do so, we
developed a pipeline that draws historical data based on latitude, longitude,
and Julian date to automatedly provide the daily max temp (highest
recorded temp that day) and the daily min temperature (the lowest recorded
temp that day).

## Modeling info

We ran two models for overthinning and two models for
underthinning. Similar to in Question 1, these were binomial GLMs, but since
temperature is continuous, the figures appear different.

The simplest way to interpret these models is that steep, s-shaped curve is a
strong correlation, while a flatter curve is a weak correlation. Each dot
represents an observation from a farm (temperatures and a record of
overthinning vs. good thinning).

## What is the takeaway from the analysis of daily temperature?

Overthinning was not impacted by daily minimum temps (Figure 1), but
underthinning was (Figure 2).

Hot days may cause underthinning. Days that start quite warm are more
likely to produce some underthinning on farms. If 15 Celsius is the low, that
means that coldest part of the day is about 59 Fahrenheit. It’s likely that it
gets much hotter (see Figs 3 and 4) which then drives underthinning.

If you look at the original data (black dots), you can see that good thinning
only occurred twice once minimum temperature went over 16C (61F).

We did not see any evidence that the daily highs impacted underthinning or
overthinning (Figures 3 and 4). Good thinning still occurred at some
locations that spiked 40 Celsius (over 100F).

Given the key result in Figure 2, the best recommendation may be to avoid
using products on days with warm nights/mornings. More investigation is
definitely needed!

## Figures

<img src="{{< blogdown/postref >}}index_files/figure-html/ggplot2-1.png" width="672" />

