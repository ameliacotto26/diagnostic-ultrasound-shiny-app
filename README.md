# Diagnostic Ultrasound Shiny App

## Project Overview

This Shiny app was created to explore diagnostic ultrasound device data from 2025. It uses the cleaned datasets from my data cleaning project and allows users to interact with MAUDE adverse event reports and FDA medical device recall data.

## Data

The app uses two cleaned CSV files:

- `maude_ultrasound_2025_final.csv`
- `fda_ultrasound_recalls_2025_final.csv`

The data focuses on three diagnostic ultrasound device types:

- Pulsed Doppler Ultrasound System
- Pulsed Echo Ultrasound System
- Diagnostic Ultrasound Transducer

## App Features

The app contains two tabs.

### MAUDE Events

This tab allows the user to choose a device type and view the number of MAUDE reports by event type. The graph and summary table update based on the selected device type.

### FDA Recalls

This tab allows the user to choose a device type and view the number of FDA recalls by root cause. The graph and summary table update based on the selected device type.

## Purpose

The purpose of this app is to make the cleaned ultrasound device data easier to explore. Instead of only looking at static tables, the user can filter the data and compare patterns across different device types.

## Tools Used

- R
- Shiny
- tidyverse
- ggplot2