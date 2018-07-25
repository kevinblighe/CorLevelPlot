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

```{r ex1, fig.height = 8, fig.width = 8, fig.cap = "Example 1: WGCNA trait-to-eigengene plot"}

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

    CorLevelPlot(data = ModuleEigengeneNetwork1,
        x = c("y", "MEturquoise", "MEblue", "MEbrown", "MEgreen", "MEyellow"),
        y = c("y", "MEturquoise", "MEblue", "MEbrown", "MEgreen", "MEyellow"),
        titleX = "X correlates",
        cexTitleX = 3.0,
        rotTitleX = 0,
        colTitleX = "forestgreen",
        fontTitleX = 2,
        titleY = "Y\ncorrelates",
        cexTitleY = 4.0,
        rotTitleY = 100,
        colTitleY = "gold",
        fontTitleY = 4,
        cexLabX = 1.0,
        rotLabX = 45,
        colLabX = "grey20",
        fontLabX = 1,
        cexLabY = 1.0,
        rotLabY = 30,
        colLabY = "royalblue",
        fontLabY = 1,
        col = c("blue4", "blue3", "blue2", "blue1", "white", "red1", "red2", "red3", "red4"),
        colourkey = TRUE,
        cexCorval = 1.0,
        fontCorval = 4,
        main = "WGCNA example",
        cexMain = 2,
        rotMain = 360,
        colMain = "red4",
        fontMain = 4,
        corFUN = "pearson",
        corUSE = "pairwise.complete.obs",
        signifSymbols = c("***", "**", "*", ""),
        signifCutpoints = c(0, 0.001, 0.01, 0.05, 1),
        colBG = "white",
        plotRsquared = FALSE,
        axisTicks = c(1,1))

```

## Example 2: Iris dataset principal components analysis:

```{r ex2, fig.height = 8, fig.width = 14, fig.cap = "Example 2: Iris dataset principal components analysis"}

    library(datasets)
    data(iris)

    # order the categories in the 'Species' column
    # CorLevelPlot will conver these to 1, 2, 3, ...
    iris$Species <- factor(iris$Species, levels=c("setosa", "versicolor", "virginica"))

    i <- CorLevelPlot(data = iris,
        x = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
        y = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
        col = c("white", "cornsilk1", "yellow", "gold", "forestgreen", "darkgreen"),
        cexCorval = 1.5,
        fontCorval = 2,
        rotLabX = 45,
        main = "Iris correlates",
        plotRsquared = TRUE)

    pca <- stats::prcomp(iris[,c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")])
    df <- data.frame(pca$x, iris)

    ii <- CorLevelPlot(data = df,
        x = c("PC1", "PC2", "PC3", "PC4"),
        y = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
        titleX = "Principal\ncomponents",
        cexTitleX = 2.0,
        rotTitleX = 0,
        fontTitleX = 2,
        titleY = "Iris components",
        cexTitleY = 2.0,
        rotTitleY = 90,
        fontTitleY = 2,
        col = c("blue1", "skyblue", "white", "pink", "red1"),
        cexCorval = 1.5,
        fontCorval = 2,
        rotLabX = 45,
        main = "Iris PC correlates",
        plotRsquared = FALSE)

    require(rasterVis)
    require(gridExtra)
    require(grid)

    grid.arrange(
        arrangeGrob(i,
            top = textGrob("A",
            x = unit(0.05,"npc"),
            y = unit(0.9,"npc"),
            just = c("left","top"),
            gp = gpar(fontsize=32))),
        arrangeGrob(ii,
            top = textGrob("B",
            x = unit(0.05,"npc"),
            y = unit(0.9,"npc"),
            just = c("left","top"),
            gp = gpar(fontsize=32))),
        ncol = 2)

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
