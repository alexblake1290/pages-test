---
date: "2016-04-27T00:00:00Z"
weight: 2
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

Our analyses confirmed the client’s initial hunch that temperature alone drove product failure. Going further, our data scientists also found that product performance was responding differently to temperature on the East Coast compared to the West.

<img src="cafl_map.svg" style="border-radius: 5%;" />

Building on the client’s question like this added **valuable but tricky nuances** to our results.

## What is the answer?

Some analyses are easy to interpret – we can summarize them with simple bar graphs or time series. But as problems become more complex so do the analyses and their outputs.

> *"We felt the team at Ecodata really valued our time. They walked us through the specifics, but always brought things back to the key highlights. Results and implications of the analyses were clear... we never felt lost in the gritty details."*

One such analysis is the binomial GLM, a powerful tool for yes/no data like our client provided. But the outputs can be tricky to visualize, and tricker when different segments arise in the data such as geography. **Our consultants worked closely with the client explain these outputs comprehensively, but clearly.**

## A case study: how we leverage simple yes/no surveys

A client has provided us with 104 growers reporting success or failure of a product - here we'll use some anonymized results. We’ve enriched the survey with additional environmental data performed a statistical analysis.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/bar-1.png" alt="Simple bar chart showing the overall response from end-user survey on agrochemical success following product application. A plot like this gives a useful summary, but loses valuable detail." width="672" />
<p class="caption">Figure 1: Simple bar chart showing the overall response from end-user survey on agrochemical success following product application. A plot like this gives a useful summary, but loses valuable detail.</p>
</div>

It looks like warmer temperatures degrade agrochemical performance. **But how can we know for sure?** And when exactly is it too hot to use the product?

We can just count the number of 'yes' and 'no' responses. But **that doesn’t tell us how confident we are, or where the temperature cut-offs lie.**

## Solving the problem with binomial GLMs

We use Binomial GLMs. In these models a steep, S-shaped curve shows a strong correlation between product performance and temperature. A flatter curve is a weak correlation.

#### Results are clear on the West Coast

In California we see a steep S-curve, showing a strong correlation between high temperature and agrochemical performance.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/cali-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in California. High temperatures significantly impacted product performance (p &lt; 0.001)." width="672" />
<p class="caption">Figure 2: Probability of agrochemical product success in response to daily maximum temperatures on farms in California. High temperatures significantly impacted product performance (p < 0.001).</p>
</div>

Reported product failures show up along the bottom of the plot (0%) and successes are at the top (100%), represented by dots at different temperatures.

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/calibox-1.png" alt="The product fell below the client's key performance rate of 75% (horizontal line) above 88F." width="672" />
<p class="caption">Figure 3: The product fell below the client's key performance rate of 75% (horizontal line) above 88F.</p>
</div>

This area is where we figure out what the thresholds are. The product begins to fail just under 80F, **when the shaded confidence ribbon drops below 100%.** By 88F the success rate dropped beneath the client's key performance threshold of 75%. Beyond 103F the product no longer worked at all.

#### More  questions from the East Coast

On the other hand, we’re much less confident about how temperature impacts the product for growers in Florida. Success is consistently around 75% at all temperatures, which is great! But why? **Good analyses can create more questions and lead us to a complete understanding of how a product works in the field.**

<div class="figure">
<img src="{{< blogdown/postref >}}index_files/figure-html/fl-1.png" alt="Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only (p = 0.82)." width="672" />
<p class="caption">Figure 4: Probability of agrochemical product success in response to daily maximum temperatures on farms in Florida only (p = 0.82).</p>
</div>

#### Working with uncertainty

The p-value summarizes how confident we are in the model conclusions, or the risk that our model is *wrong*. This kind of uncertainty is helpful: **clients can use model uncertainty to make informed business decisions by placing a dollar value on risk.**

<img src="thinking.jpg" style="border-radius: 5%;" />

In California, a p-value under 0.001 says we’re very confident that spraying at high temperatures would just be a waste - **there's only a 0.1% chance our conclusion is wrong.** Growers can estimate the cost of *not* spraying (e.g. pest damage), adjust for the chance our model is wrong (0.1%), and compare to the savings made by not (wastefully) spraying.

By contrast, in the Florida model we have a p-value of 0.82. So there’s a 82% risk that higher temperatures *don’t* affect the product. In other words, **advising end-users to save their herbicide at high temperatures might lead to pest damage that could’ve been avoided.**

## Distilling things down to actionable insights

Here we'd advise our client to give strong guidance to citrus growers in California. But for end-users in Florida, their advice should be transparent but qualified.

> *"The take-home was simple: don't waste our herbicide above 88F. Clear advice for West Coast orchards made it easy for us to ensure customer satisfaction. We wanted to provide the same kind of clear guidance to our customers in the East, so we asked Ecodata to drill further into the Florida data."*
