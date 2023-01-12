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

Our  client's team had a strong assumption that the local
weather conditions, especially high and low temperatures, would impact the
performance of their pesticide product.

End-user survey data provided by the client included GPS
coordinates for all farms and date of application, so we used that information
to pull from local weather stations located within a few miles. To do so, we
developed a pipeline that draws historical data based on latitude, longitude,
and Julian date to automatically provide the daily max temperature (highest
recorded temperature that day).

## Modeling info

We ran three models: overall performance, and performance broken down by state (California and Florida). Similar to in Question 1, these were binomial GLMs, but since
temperature is continuous, the figures appear different.

The simplest way to interpret these models is that steep, s-shaped curve is a
strong correlation, while a flatter curve is a weak correlation. Each dot
represents an observation from a farm (temperatures and a record of
product failure or success).

## What is the takeaway from the analysis of daily temperature?
#### Overall results
Product performance was impacted by higher temperatures (Figure 1).

(Figure 1: OK result combining the data)

Hot days may cause pesticide failure - on days that reach high maximum temperatures,
growers were more likely to report product failure. 

However there's still some scatter in the combined results. We sliced through the data in several other ways including altitude, crop species, [list some others]. However it was state that turned out to be key.

#### West coast results
You can see that in farms from California there is a strong 'S' shaped curve (Figure 2), indicating a sharp temperature threshold at 35.6C (XXF). If you look at the original data (cyan dots) in Figure 2, you can see that pesticide success only occurred twice once maximum daily temperature went over 35C (XXF).

(Figure 2: GREAT result just focusing on California)

#### East coast results
However, Floridian farms produced a flatter curve (Figure 3), suggesting that temperature only weakly predicted product success or failure.

(Figure 3: mediocre result from Florida)

<img src="{{< blogdown/postref >}}index_files/figure-html/ggplot2-1.png" width="672" />
This means there must be some other factor at play on the East Coast vs the West, which may be interacting with temperature.  By determining this unknown factor then we can pinpoint similar clear thresholds for end-users in Florida as well.

## Our take-home message

Given the key result in Figure 1, the best recommendation may be to avoid
using products on days with warm nights/mornings, especially on farms in California. However the pattern is less clear from farms in Florida. More investigation is definitely needed!
