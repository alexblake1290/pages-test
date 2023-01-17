---
date: "2016-04-26T00:00:00Z"
external_link: ""
image:
  focal_point: Smart
  preview_only: true
links:
summary: |-
  Agrochemical products deal with all the environmental extremes that occur in the field. Our client suspected high air temperatures were preventing an herbicide from working. A simple survey of growers confirmed their suspicions, but they needed hard numbers to improve their product.
  
  We gathered the rest of the data. Though temperature was important, our data scientists uncovered more questions about product performance on farms in different US states.
  
  Click for more on how we scoped the problem.
tags:
- Intro
title: Temperature impact on herbicide performance
share: false
profile: false
comments: false
reading_time: false
---
<script src="{{< blogdown/postref >}}index_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index_files/lightable/lightable.css" rel="stylesheet" />



<style>
p.caption {
  font-size: 0.8em;
  padding: 0px 0px 40px 0px;
}
.button {
  appearance: none;
  background-color: transparent;
  border: 3px solid #6eb39c;
  border-radius: 15px;
  box-sizing: border-box;
  color: #6eb39c;
  cursor: pointer;
  display: inline-block;
  font-family: Roobert,-apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";
  font-size: 16px;
  font-weight: 600;
  line-height: normal;
  margin: 0;
  min-height: 60px;
  min-width: 0;
  outline: none;
  padding: 16px 24px;
  text-align: center;
  text-decoration: none;
  transition: all 300ms cubic-bezier(.23, 1, 0.32, 1);
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: 33%;
  will-change: transform;
}

.button:disabled {
  pointer-events: none;
}

.button:hover {
  color: #ffffff;
  border: 3px solid #ffffff;
  background-color: transparent;
  box-shadow: rgba(0, 0, 0, 0.25) 0 8px 15px;
  transform: translateY(-2px);
}
.button:active {
  box-shadow: none;
  transform: translateY(0);
}
</style>

## The problem: product failure

Agrochemical products deal with all the environmental extremes that occurs in the field. High temperatures, cold winds, and record droughts prevent products from working as intended. 

> *"We suspected extraordinarily high and low temperatures might impact the performance of our agrochemical used by citrus growers, causing expensive wastage for our customers."*

<img src="img2.jpg" style="border-radius: 5%;" />

The client sales team had collected simple survey responses from growers, recording if their product had worked or not. These end-users were reporting more product failure in spring around days with extremely high maximum temperatures. **What was perplexing is it wasn’t happening on all farms.**

<img src="img3.jpg" style="border-radius: 5%;" />

**So what was really occurring in the field?** And if temperature was the culprit, exactly when did chemical performance degrade? Our client's survey confirmed their suspicions, but they needed hard numbers to improve their product.

<table class=" lightable-minimal" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> State </th>
   <th style="text-align:left;"> Product_success </th>
   <th style="text-align:right;"> Daily_high_temp_Farenheit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Florida </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 95 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> California </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 97 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> California </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 84 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> California </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 106 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> California </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:right;"> 77 </td>
  </tr>
</tbody>
</table>

## Our solution: enriching end-user surveys

> *"Surprisingly, that was all the data we had to provide to Ecodata so they could start answering our questions."*

The rest of the information we used was generated in-house by our environmental data scientists. Daily temperatures, rainfall, even cumulative degree days - all of these were leveraged to enrich the client's existing surveys.

<img src="flowchart.png" style="border-radius: 5%;" />

## Digging deeper

We then used this information to pinpoint temperature thresholds where product failed, so our client knew when exactly their growers could spray to minimize waste.

But how clear-cut these temperature thresholds were depended on state. **We dug deeper to answer why.**

<a href="https://serene-choux-d79a21.netlify.app/" class="button">Home</a><a href="https://serene-choux-d79a21.netlify.app/project/two" class="button">Pt 2: How we dug deeper</a><a href="https://serene-choux-d79a21.netlify.app/project/three" class="button">Pt 3: Our data engineering</a>

