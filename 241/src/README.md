# Source Folder

Any code to transform, structure, and clean the data is stored here in `src`. Primary source data is stored in the `/data/raw` directory. Data that has gone under modifications will be stored in `/data/interim`. Cleaned data ready for analysis will be stored in `/data/processed`.

# Extracting Interim Data
Data directly exported form qualtrics and stored in `data/raw`

# Processing Data
From qualtrics export import data 
```
file <-'SocialMediaViews_March30_46.csv'
d_raw <- fread(here("data", "raw","pilot", file ), na.strings = c("", "NA"))
```

Then process variables of interest as done in `src/data/clean_pilot_data.R`