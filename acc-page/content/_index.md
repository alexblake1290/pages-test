---
title: "Ecodata Technology"
sections:
- block: hero
  content:
    title: |-
    
      Agrochemical performance
    
      in the field
  design:
    spacing:
      padding: ["40px","0","20px","0"]
    background:
      gradient_end: '#1b2724'
      gradient_start: '#264038'
      text_color_light: yes
    css_class: 'big_headline'
- block: markdown
  content:
    text: |-

      ### {{< icon name="user-tie" pack="fas" >}} **Client:** American agrochemical producer
        
      ### {{< icon name="briefcase" pack="fas" >}} **Themes:** Herbicide performance, regional climates 
        
      ### {{< icon name="terminal" pack="fas" >}} **Techniques:** End-user surveys, binomial GLM, image extraction, R
      
      <iframe height="1000px" width="100%" frameborder="no" src="https://ecodatatech.shinyapps.io/ctspongymoth/"> </iframe>
      
  design:
    background:
      image:
        color: '#1b2724'
        text_color_light: yes
    css_class: 'brief'
    spacing:
      padding: ["20px","0","5px","0"]
- block: portfolio
  content:
    filters:
      folders: project
      tags:
      - Intro
      - Problem
      - Solution
    title: ''
    sort_by: Weight
    sort_ascending: yes
  design:
    spacing:
      padding: ["40px","0","40px","0"]
    columns: '1'
    flip_alt_rows: yes
    view: community/showcase_rounded
    background:
      color: '#1b2724'
      text_color_light: yes
- block: markdown
  design:
    background:
      image:
        filename: orchard.jpeg
        size: cover
        position: center
        parallax: yes
        text_color_light: yes
date: "2022-10-24"
type: landing
---
