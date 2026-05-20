# Guidelines for Submitting Documents

## General Guidelines

This repository has the following structure:

``` bash
.
├── README.md
├── power.Rmd
├── power.pdf
└── questions
    ├── power_1.Rmd
    ├── power_2.Rmd
    ├── power_3.Rmd
```

The top level file is the file that you use to compile all of your code. It will "take-in" the code that you've written in each of the `power_*.Rmd` files after you have saved them. Your answers to each question should be placed inside each of the `power_*.Rmd` files.

-   Once you have forked and then cloned this repository, you should immediately be able to knit to a PDF.
-   When you begin an analysis, say, #1, you open `./power_analysis/power_1.Rmd` and write and execute your code in this file, and then knit everything completed to this point by returning to the top-level `power.Rmd` file.

## Submission

-   Submission is through Gradescope.

## Description

An experiment's power is the probability that it rejects the null hypothesis of no-effect. In this assignment, we would like your group to conduct a power analysis so that you can form an early indicator of the number of data points you will have to collect.

The deliverable of this power analysis should take the following form:

It should be no more than a few printed pages when compiled. It should produce its report from source code (i.e. and .Rmd file) that can be shared and run by a collaborator. There are many tools to aid conducting a power analysis. We list several here here as a reference for the future:

G\*PowerLinks to an external site. EGAP Power CalculatorLinks to an external site. However for this assignment we would like you to conduct your power analysis through simulation, rather than relying on analytic formulae. Here is why:

When you simulate the data generating process, you are forced to confront several decision points about your data that you do not when you use an analytic tool. Power analysis through simulation is much more flexible than power analysis using analytic formulae. Whereas it is difficult to, say, conduct an analytic power analysis with robust standard errors this is relatively straight forward when you simulate. By simulating your power analysis, you will be forced to think about some of the most core concepts of power.

## Requirements:

-   The group must produce a power analysis under three different scenarios. These could be differences in the assumed treatment effect size, or the dispersion of the data, or some other such change.

-   The assumed effect size should be justified with some evidence. This could be from previously published research, from professional knowledge, or from qualitative interviews with subjects.

-   The statistical technique used to calculate power should match, as much as is possible, the technique that will be used with the real data. If you believe that you will use a regression with robust standard errors in your final analysis, your power analysis should also use this technique. If you think that you will have repeated measures of an individual and will use a panel-data model, then your power analysis should also use this technique.

-   The power analysis should, at least, contain a plot that has sample size along the x-axis, achieved power on the y-axis, and three lines (one for each scenario) that represent the achieved power.
