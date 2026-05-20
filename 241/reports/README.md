# Guidelines for Report and knitting

## General Guidelines

This directory has the following structure:

``` bash
.
├── README.md
├── report.qmd
├── report.pdf
└── report_sections
    ├── introduction.qmd
    ├── lit_review.qmd
    ├── methodology.qmd
    ├── results.qmd
    ├── discussion.qmd
    ├── conclusion.qmd
    
```

The top level file is the file that you use to compile all of your code. It will "take-in" the code that you've written in each of the `report_sections*.qmd` files after you have saved them. Report sections should be placed in `report_sections.qmd` directory.

-   set `report.qmd` as working directory.
-   work on report sections in `report_sections` when ready knit from `report.qmd`.

## Data

To import data use similar approach as

```         
file <-'SocialMediaViews_March30_46.csv'
d_raw <- fread(here("data", "raw","pilot", file ), na.strings = c("", "NA"))
```

using `here` package where arguments are directories. For example the above code would retrieve data from `/data/raw/pilot/file_name` .
