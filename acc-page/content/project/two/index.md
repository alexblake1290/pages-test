---
date: "2016-04-27T00:00:00Z"
external_link: ""
image:
  focal_point: Smart
  preview_only: true
links:
summary: |-
  
  With our eye for details, we noticed that product performance subtly differed across state lines. Higher temperatures clearly drove product failure in California, but the relationship was murkier in Florida.
  
  We prioritize client time and comprehension. As the problem expanded in complexity, so did our models. An important part of our work is unpacking the results for actionable insights. This helped us and our client to quickly zero in on a root cause and develop new product recommendations.
  
  Click for more on how we report complexity with clarity.
tags:
- Problem
title: Straightforward answers from complex models
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

## Uncovering hidden complexities

Our client’s initial hunch was that temperature alone drove product failure. With additional analyses, our data scientists found that the impact of temperature on product performance depended on state.

<img src="analyst.jpg" style="border-radius: 5%;" />

Breaking down the client’s question like this added tricky nuances to our results.

## What is the answer?

We value the time of our clients. Good product teams want to get into specifics, and the specifics are our strong suit. But “highlights” convey key results quickly without getting lost in the nitty gritty details.

When reporting to clients, we like to walk through the models used to draw conclusions. Some model outputs are easy to interpret – like bar graphs or time series. But as problems become more complex so do the analyses and their outputs.

One such tool is the binomial GLM, which used with yes/no data like our client provided. The outputs can be tricky to visualize, and tricker when different segments arise in the data such as geography. Our consultants worked closely with the client explain these outputs comprehensively, but clearly.

## A case study: leveraging simple yes/no surveys

A client has provided us with 104 growers reporting success or failure of a product. We’ve enriched the survey with additional environmental data performed a statistical analysis. It looks like relatively cold temperatures negatively impact product performance.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/bar-1.png" alt="Simple bar chart showing the overall results from end-user survey on agrochemical success following product application. A plot like this provides a useful summary but loses valuable detail." width="672" />
<p class="caption">Figure 1: Simple bar chart showing the overall results from end-user survey on agrochemical success following product application. A plot like this provides a useful summary but loses valuable detail.</p>
</div>

But how can we know for sure? And when exactly is it too hot and when is it ok to use the product? We can just count the number of 'yes' and 'no' responses. But that doesn’t tell us how confident we are, or where the temperature cut-offs lie.

## Solving the problem with binomial GLMs

The simplest way to interpret these models is that a steep, S-shaped curve is a strong correlation between product performance and temperature. A flatter curve is a weak correlation.

#### Results are clear on the West Coast

In California, the results are very clear. The client can advise their end-users to save their herbicide at high temperatures as the risk-adjusted cost of failing to spray is very low. We’re very confident it would just be a waste.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/cali-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in California only. High temperatures significantly impacted product performance (p &lt; 0.001). Each dot represents a survey response." width="672" />
<p class="caption">Figure 2: Probability of agrochemical product success in response to daily maximum temperatures on farms in California only. High temperatures significantly impacted product performance (p < 0.001). Each dot represents a survey response.</p>
</div>

Reported product failures show up along the bottom of the plot (0%) and successes are at the top (100%), represented by dots at different temperatures.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/calibox-1.png" alt="The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 86F. Shaded region indicates uncertainty: tighter shading indicates higher confidence." width="672" />
<p class="caption">Figure 3: The product fell below the client's key success rate of 75% (horizontal line) once temperatures exceeded 86F. Shaded region indicates uncertainty: tighter shading indicates higher confidence.</p>
</div>

This area is where we figure out what the thresholds are. The product begins to fail at at low rates just below 80F, when the shaded confidence ribbon drops below 100%. By 88F the success rate dropped below the client's key threshold of 75% and beyond 103F the product no longer succeeded at all.

#### More  questions from the East Coast

On the other hand, we’re much less confident about how temperature impacts the product for growers in Florida. Something else is causing product failure in this state.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/fl-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only." width="672" />
<p class="caption">Figure 4: Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only.</p>
</div>

#### Working with uncertainty

With a confidence (measured with p-value) of 0.82, there’s a 82% risk that higher temperatures *don’t* affect the product. In other words, advising end-users to save their herbicide at high temperatures might lead to pest damage that could’ve been avoided.

This kind of uncertainty is ok – uncertainty is critical to know and allows clients to price risk, like the risk of telling end-users the wrong thing to do. If the cost of pest damage are high, then it might make sense to spray just in case. But if the cost of pest damage is low, the risk-adjusted cost of wasting herbicide might be higher.

## Distilling things down to actionable insights

Here we would suggest that our client provide confident advice to end-users in states like Nebraska with clear patterns in the data. Above 88F, don’t waste the product. Less accidental waste means more satisfied customers.

<img src="thinking.jpg" style="border-radius: 5%;" />

For end-users in Florida, their advice should be transparent but qualified. They wouldn’t want to bet the farm on it (no pun intended). A result like this justifies a closer look for the product team or maybe warning salespeople that there is a small risk of high temperatures messing up the product.

Our client wanted to know exactly when their Pennsylvanian customers should spray, so we dug even deeper and found the answer in cloud cover.

(Links to other pages)

