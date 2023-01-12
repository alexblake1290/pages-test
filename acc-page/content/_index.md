---
title: "null"
sections:
- block: hero
  content:
    title: Agrochemical performance in the field
  design:
    background:
      gradient_end: '#1b2724'
      gradient_start: '#264038'
      text_color_light: yes
    css_class: 'big_headline'
- block: markdown
  design:
    background:
      image:
        filename: apples1.jpg
        size: cover
        position: center
        parallax: yes
        text_color_light: yes
- block: markdown
  content:
    text: |-
      <br>
      
      # {{< icon name="terminal" pack="fas" >}} **Client:** American agrochemical producer
        
      # {{< icon name="python" pack="fab" >}} **Themes:** Herbicide performance, regional climates 
        
      # {{< icon name="r-project" pack="fab" >}} **Impact: End-user wastage down xx%**
  design:
    background:
      image:
        color: '#1b2724'
        text_color_light: yes
    css_style: 'font-size: 250%;'
    spacing:
      padding: ["5px","0","5px","0"]
- block: portfolio
  content:
    filters:
      folders: project
      tags:
      - Intro
      - Problem
      - Solution
    title: ''
    sort_by: Date
    sort_ascending: yes
  design:
    columns: '1'
    flip_alt_rows: yes
    view: community/showcase_rounded
    background:
      color: '#1b2724'
      text_color_light: yes
- block: hero
  content:
    image:
      filename: ecodatalogo.svg
    cta:
      label: Reach out
      url: https://www.ecodata.tech/projects#contact
  design:
    background:
      image:
        filename: apples1.jpg
        size: cover
        position: center
        parallax: yes
        text_color_light: yes
  id: projects
date: "2022-10-24"
type: landing
---
