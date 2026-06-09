# Pollination exclusion- contrasting reproductive strategies among three invasive Asteraceae species in the Eastern Himalaya

## Overview

This repository contains the data and R scripts associated with the manuscript:

"Pollination exclusion reveals contrasting reproductive strategies among three invasive Asteraceae species in the Eastern Himalaya"

The study investigates the reproductive responses of three invasive Asteraceae species (*Ageratum conyzoides*, *Chromolaena odorata*, and *Mikania micrantha*) under different levels of pollinator exclusion. Specifically, we quantified seed set, seed mass, seed developmental success, and pollinator assemblages to evaluate the extent of pollinator dependence and autonomous reproduction.

### Data

seeddata.csv

Contains reproductive data collected from pollination-exclusion experiments, including:

* Species identity
* Pollination treatment (Mesh)
* Number of developed seeds
* Number of under-developed seeds
* Seed set per floret
* Seed mass per seed

Poll_ex_pollinators_chap_2.csv

Contains pollinator observation data, including:

* Plant species
* Pollinator species identity
* Pollinator order
* Number of pollinator interactions

### Scripts

pollination_exclusion_analysis.R

R script used to:

* Calculate seed set and seed mass summaries
* Calculate proportions of under-developed seeds
* Perform correlation analyses between seed set and seed mass
* Summarize pollinator richness and visitation frequencies
* Generate figures presented in the manuscript

## Pollination treatments

* C = Control (unbagged)
* O = Open mesh treatment
* L = Large mesh treatment (~8 mm)
* S = Small mesh treatment (~1 mm)

## Software

Analyses were conducted using:

* R version 4.5.3
* dplyr
* ggplot2

## Data availability

All data and code necessary to reproduce the analyses and figures presented in the manuscript are provided in this repository.
