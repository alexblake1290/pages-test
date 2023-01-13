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


```r
# get max / min temps 
all_temps <- map_dfr(1:length(near_stats), ~ {
  
  print(.x)
  
  # set while conditions 
  i <- 1 # weather station (1 = nearest, 2 = second nearest, ...)
  rec_ind <- FALSE # indicator of records in output
  
  # loop to find nearest weather station with temp data
  while(!rec_ind) {
    near_ids <- map_chr(near_stats[.x], ~ .x %>% slice(i) %>% pull(id))
    ad_ids <- ad %>%
      bind_cols(near_id = near_ids) 
    
    out_row <- ghcnd(ad_ids$near_id[.x], 
                     date_min = parse_date(ad_ids$app_date[.x], format = "%m/%d/%y"), 
                     date_max = parse_date(ad_ids$app_date[.x], format = "%m/%d/%y"),
                     var = c("TMAX", "TMIN")) %>%
    select(id, year, month, element, starts_with("VALUE")) %>%
    filter(element %in% c("TMAX", "TMIN")) %>%
    pivot_longer(starts_with("VALUE"), names_to = "day", values_to = "temp_C") %>%
    mutate(across(day, ~ as.integer(str_sub(.x, 6, nchar(.x)))), 
           across(temp_C, ~ .x / 10)) %>%
    pivot_wider(names_from = "element", values_from = "temp_C") %>%
    mutate(dt = parse_date(paste0(year, "-", 
                                  str_pad(month, 2, "left", "0"), "-", 
                                  str_pad(day,   2, "left", "0"))), 
           index = str_pad(.x, 3, "left", "0")) %>%
    filter(dt == ad_ids$app_date[.x])
    
    # update while conditions
    rec_ind <- ifelse(nrow(out_row) == 1, 
                      ifelse(!is.na(out_row$TMAX) & !is.na(out_row$TMIN), TRUE, FALSE), FALSE)
    i <- i + 1
  }
  return(out_row)
}
)
```
