---
date: "2022-12-01T00:00:00Z"
external_link: ""
image:
  focal_point: Smart
  preview_only: true
links:
summary: Null
title: "How is agrochemical performance impacted by high temperatures in orchards?"
share: false
profile: false
comments: false
reading_time: false
---



<style>
p.caption {
  font-size: 0.8em;
  padding: 0px 0px 40px 0px;
}
</style>

## Data sourcing

Our client suspected extraordinarily high and low temperatures would impact the performance of their agrochemical used in citrus.

Consumer survey data provided by the client included GPS coordinates for all orchards and date of application. Importantly, this included a record of when the product succeeded or failed (Figure 1).

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/bar-1.png" alt="Overall results from end-user survey on agrochemical success following product application." width="672" />
<p class="caption">Figure 1: Overall results from end-user survey on agrochemical success following product application.</p>
</div>
<br>

To understand where the products were failing 25% of the time, we gathered data from local weather stations located within a few miles of each orchard.

To do so, we programmed a data pipeline that draws historical data based on latitude, longitude, and Julian date to automatically provide the daily max and min temperatures (highest and lowest recorded temperatures that day). Here's a snippet of what we did:


```r
ad <- ad_raw%>% 
  select(lat, lon, app_date = "App. date") %>%
  mutate(pre_date = app_date - 7) %>%
  mutate(across(c(pre_date, app_date), ~ as.character(.x))) %>%
  distinct(lat, lon, app_date, pre_date) %>%
  ungroup() %>%
  mutate(file_index = str_pad(as.character(1:n()), 2, "left", "0")) %>%
  mutate(id = str_pad(as.character(1:nrow(.)), 3, "left", "0")) # nearby station
```

## So what was the impact of daily temperature?
#### Overall results
Product performance was impacted by higher temperatures (Figure 2). There was no impact of minimum temperatures.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/all-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures, across all farms. High temperatures significantly impacted product performance (p &lt; 0.001). The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 80F. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence." width="672" />
<p class="caption">Figure 2: Probability of agrochemical product success in response to daily maximum temperatures, across all farms. High temperatures significantly impacted product performance (p < 0.001). The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 80F. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence.</p>
</div>
<br>

The simplest way to interpret these models is that a steep, S-shaped curve is a strong correlation between product performance and temperature. A flatter curve is a weak correlation. Each dot represents a piece of data collected in the consumer survey.

Our conclusion was clear. Hot days cause product failure - on days that reach high maximum temperatures, growers were more likely to report product failure. Failure starts at 80F and performance plummets shortly afterwards.

However, our client was concerned these results didn’t hold true in all locations. The climate of the two states surveyed vary by a lot more than just daily temperatures.

#### West coast results
You can see that in farms from California there is a strong ‘S’ shaped curve (Figure 3), indicating a sharp temperature threshold at 86F. We concluded that product recommendations should change in California and to tell growers to avoid using this agrochemical on hot days.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/cali-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in California only. High temperatures significantly impacted product performance (p &lt; 0.001). The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 86F. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence." width="672" />
<p class="caption">Figure 3: Probability of agrochemical product success in response to daily maximum temperatures on farms in California only. High temperatures significantly impacted product performance (p < 0.001). The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 86F. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence.</p>
</div>

#### East coast results
However, Floridian farms produced a flatter curve (Figure 3), suggesting that temperature only weakly predicted product success or failure. Something else was causing product failure in this region.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/fl-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only. Here we found no strong statistical impact of temperature on agrochemical performance (p = 0.82), with product success rate steady at around 75%. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence." width="672" />
<p class="caption">Figure 4: Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only. Here we found no strong statistical impact of temperature on agrochemical performance (p = 0.82), with product success rate steady at around 75%. Each point represents a survey response. Shaded region indicates uncertainty: tighter shading indicates higher confidence.</p>
</div>

## Our take-home message

We helped our client make regionally-tailored product recommendations and pinpointed the cause (high temperatures). California citrus orchards changed the agrochemical usage guidelines, and the client is now working with us to investigate what may be mitigating temperature effects and causing 25% failure in Florida citrus orchards.

#### What's next?
We are working with the client to follow their next hunch: cloudy weather might also be responsible for product failure.

Cloud cover data is difficult to extract due to its complexity and density. Large-scale data warehouses include satellite photographs of land surfaces (LandSat program with NASA/USGS), which includes billions of rows of data. The hard part isn’t analyzing the data – its *finding* it.

For this project, we are developing a pipeline to pull all photographs in a 1-5km buffer around surveyed farms. Our team is now organizing data and warehousing it for future modeling efforts. Check out a sample below:


```r
# function to fetch cloud cover data
get_cc <- function(buffer) {
  
  recs <- get_records(
                 time_range = as.character(c(buffer$app_date - 7, buffer$app_date)), 
                 products = get_cloudcov_supported()[5:6], # Sentinel
                 aoi = buffer$geometry, 
                 as_sf = FALSE)
  clouds <- calc_cloudcov(recs, aoi = buffer$geometry, 
                          write_records = FALSE, write_cloud_masks = FALSE, 
                          dir_out = "data/cloud-cover/")
  
  clouds %>%
    write_csv(file = paste0("data/cover-dfs-new/", buffer$id, "_cloud_cover.csv"))
}
```

<img src="orchard.jpeg" style="border-radius: 5%;" />
