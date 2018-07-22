---
title: "Visualise correlation results and test significancies of these"
author: "Kevin Blighe"
date: "`r Sys.Date()`"
package: "`r packageVersion('CorLevelPlot')`"
output:
    rmarkdown::html_document:
    highlight: pygments
    toc: true
    fig_width: 5
bibliography: library.bib
vignette: >
    %\VignetteIndexEntry{Visualise correlation results and test significancies of these}
    %\VignetteEngine{knitr::rmarkdown}
    %\VignetteEncoding{UTF-8}
    %\usepackage[utf8]{inputenc}
---

CorLevelPlot provides a quick and colourful way to visualise
statistically significant correlations between any combination of
categorical and continuous variables. Moreover, the statistical
significancies of these correlations are also provided.

```{r, echo=FALSE}

    library(knitr)
    opts_chunk$set(tidy = TRUE, message = FALSE, warning = FALSE)

```

## Example CorLevelPlot plots

Install and load CorLevelPlot:

```{r}

    source("https://bioconductor.org/biocLite.R")
    biocLite("CorLevelPlot")
    library(CorLevelPlot)

```

## Example 1: WGCNA (weighted gene co-expression analysis) simulated data:

The following code taken from [Tutorial for the WGCNA package for R - 1. Simulation of expression and trait data](https://labs.genetics.ucla.edu/horvath/CoexpressionNetwork/Rpackages/WGCNA/Tutorials/Simulated-01-dataSimulation.pdf)

```{r ex1, fig.height = 8, fig.width = 6, fig.cap = "Example 1: plot the most basic plot"}

    # simulate trait-to-eigengene data
    no.obs <- 50
    ESturquoise <- 0; ESbrown <- -0.6; ESgreen <- 0.6; ESyellow <- 0
    ESvector <- c(ESturquoise, ESbrown, ESgreen, ESyellow)
    nGenes1 <- 3000
    simulateProportions1 <- c(0.2, 0.15, 0.08, 0.06, 0.04)
    set.seed(1)
    MEgreen <- rnorm(no.obs)
    scaledy <- MEgreen * ESgreen + sqrt(1 - ESgreen ^ 2) * rnorm(no.obs)
    y <- ifelse( scaledy > median(scaledy), 2, 1)
    MEturquoise <- ESturquoise * scaledy + sqrt(1 - ESturquoise ^ 2) * rnorm(no.obs)
    MEblue <- 0.6 * MEturquoise + sqrt(1 - 0.6 ^ 2) * rnorm(no.obs)
    MEbrown <- ESbrown * scaledy + sqrt(1 - ESbrown ^ 2) * rnorm(no.obs)
    MEyellow <- ESyellow * scaledy + sqrt(1 - ESyellow ^ 2) * rnorm(no.obs)
    ModuleEigengeneNetwork1 <- data.frame(y, MEturquoise, MEblue, MEbrown, MEgreen, MEyellow)

    CorLevelPlot(ModuleEigengeneNetwork1, c("y", "MEturquoise", "MEblue"), c("y", "MEturquoise", "MEblue", "MEbrown", "MEgreen", "MEyellow"), 0.8, "spearman", "RdBu", 9, FALSE, FALSE, "WGCNA example")

```


## Example 10: plot multiple plots on the same page:

```{r ex10, fig.height = 8, fig.width = 11, fig.cap = "Example 10: plot multiple plots on the same page"}


```


## Acknowledgments

The development of *CorLevelPlot* has benefited from contributions and suggestions from:

[Myles Lewis](https://www.qmul.ac.uk/whri/people/academic-staff/items/lewismyles.html)

## Session info

```{r}

sessionInfo()

```

## References

[@CorLevelPlot]
