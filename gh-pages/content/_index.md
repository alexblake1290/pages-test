---
title:
sections:
- block: hero
  content:
    title: Climate change impacts on marine foodwebs
    # image:
      # Reference an image in your `assets/media/` folder
      # filename: ecodatalogo.svg
    # Add your Call-To-Action (CTA) button and optional icon
    text: |-
      <br>
      
      **Client:** Major tuna farm
      
      **Themes:** Fisheries and aquaculture, climate change
      
      **Impact: Feedstock efficiency lifted 20%**
      
      This is a test of continuous deployment
  design:
    background:
    # Choose an optional background color, gradient, image, or video
      gradient_end: '#1b2724'
      gradient_start: '#264038'
      text_color_light: true
- block: markdown
  design:
    # See Page Builder docs for all section customization options.
    # Choose how many columns the section has. Valid values: '1' or '2'.
    # columns: '1'  
    background:
      image:
        filename: ocean.jpg
        size: cover
        position: center
        parallax: true
        text_color_light: true
- block: portfolio
  content:
    filters:
      folders: project
      tags: ["Intro","Problem","Solution"]
    title: ""
    sort_by: 'Date'
    sort_ascending: true
  design:
    columns: '1'
    flip_alt_rows: yes
    view: showcase
    background:
    # Choose an optional background color, gradient, image, or video
      color: '#1b2724'
      text_color_light: true
- block: hero
  content:
    image:
      # Reference an image in your `assets/media/` folder
      filename: ecodatalogo.svg
    # Add your Call-To-Action (CTA) button and optional icon
    cta:
      label: Reach out
      url: https://www.ecodata.tech/projects#contact
  design:
    background:
    # Choose an optional background color, gradient, image, or video
    #  color: '#1b2724'
    #  text_color_light: true
      image:
        filename: ocean.jpg
        size: cover
        position: center
        parallax: true
        text_color_light: true
  id: projects
date: "2022-10-24"
type: landing
---
