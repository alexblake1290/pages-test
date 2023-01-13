---
date: "2022-12-1T00:00:00Z"
external_link: ""
image:
  focal_point: Smart
  preview_only: true
links:
summary: Null
title: "How does high temperature on orchards impact agrochemical performance?"
share: false
profile: false
comments: false
reading_time: false
---



## Data sourcing

Our client suspected extraordinarily high and low temperatures would impact the performance of their agrochemical used in citrus.

Consumer survey data provided by the client included GPS coordinates for all orchards and date of application. Importantly, this included a record of when the product succeeded or failed.

<img src="{{< blogdown/postref >}}index_files/figure-html/bar-1.png" width="672" />

To understand where the products were failing 25% of the time, we gathered data from local weather stations located within a few miles of each orchard. To do so, we programmed a data pipeline that draws historical data based on latitude, longitude, and Julian date to automatically provide the daily max temperature (highest recorded temperature that day).



## So what was the impact of daily temperature?
#### Overall results
Product performance was impacted by higher temperatures (Figure 1).

<img src="{{< blogdown/postref >}}index_files/figure-html/all-1.png" width="672" />
(Figure 1: Good result combining the data)

The simplest way to interpret these models is that steep, s-shaped curve is a strong correlation, while a flatter curve is a weak correlation. Each dot represents a piece of data collected in the consumer survey.

Our conclusion was clear. Hot days cause product failure - on days that reach high maximum temperatures, growers were more likely to report product failure. Failure starts at 80F and plummets shortly afterwards.

However, our client was concerned these results didn’t hold true in all locations. The climate of the two states surveyed vary by a lot more than daily temperatures.


#### West coast results
You can see that in farms from California there is a strong ‘S’ shaped curve (Figure 2), indicating a sharp temperature threshold at 35.6C (XXF). We concluded that product recommendations should change in California and to tell growers to avoid using this agrochemical on hot days.

<img src="{{< blogdown/postref >}}index_files/figure-html/cali-1.png" width="672" />
(Figure 2: Great result just focusing on California)

#### East coast results
However, Floridian farms produced a flatter curve (Figure 3), suggesting that temperature only weakly predicted product success or failure. Something else was causing product failure at in this region.

<img src="{{< blogdown/postref >}}index_files/figure-html/fl-1.png" width="672" />
(Figure 3: mediocre result from Florida)

## Our take-home message

We helped our client make regionally-tailored product recommendations and pinpointed the cause (high temperatures). California citrus orchards changed the agrochemical usage guidelines, and the client is now working with us to investigate what may be causing 25% failure in Florida citrus orchards.

#### What's next?
We are working with the client to follow their next hunch: cloudy weather might also be responsible for product failure.

Cloud cover data is difficult to extract due to its complexity and density. Large-scale data warehouses include satellite photographs of land surfaces (LandSat program with NASA/USGS), which includes billions of rows of data. The hard part isn’t analysing the data – its *finding* it.

For this project, we are developing a pipeline to pull all photographs in a 1-5km buffer around surveyed farms. Our team is now organizing data and warehousing it for future modelling efforts. Check out a sample below:


