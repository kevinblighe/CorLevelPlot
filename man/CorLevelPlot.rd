\name{CorLevelPlot}
\alias{CorLevelPlot}
\title{Visualise correlation results and test significancies of these}
\description{CorLevelPlot provides a quick and colourful way to visualise
statistically significant correlations between any combination of
categorical and continuous variables. Moreover, the statistical
significancies of these correlations are also provided.}
\usage{
CorLevelPlot(data,
    x,
    y,
    titleX = "",
    cexTitleX = 1.0,
    rotTitleX = 0,
    colTitleX = "black",
    fontTitleX = 2,
    titleY = "",
    cexTitleY = 1.0,
    rotTitleY = 0,
    colTitleY = "black",
    fontTitleY = 2,
    cexLabX = 1.0,
    rotLabX = 0,
    colLabX = "black",
    fontLabX = 2,
    cexLabY = 1.0,
    rotLabY = 0,
    colLabY = "black",
    fontLabY = 2,
    posLab = "bottomleft",
    col = c("blue4", "blue3", "blue2", "blue1", "white",
        "red1", "red2", "red3", "red4"),
    posColKey = "right",
    cexLabColKey = 1.0,
    cexCorval = 1.0,
    colCorval = "black",
    fontCorval = 1,
    scale = TRUE,
    main = "",
    cexMain = 2,
    rotMain = 0,
    colMain = "black",
    fontMain = 2,
    corFUN = "pearson",
    corUSE = "pairwise.complete.obs",
    signifSymbols = c("***", "**", "*", ""),
    signifCutpoints = c(0, 0.001, 0.01, 0.05, 1),
    colFrame = "white",
    plotRsquared = FALSE)
}
\arguments{
    \item{data}{A data-frame/matrix of test correlates. Can be categoricalor
    continuos variables. REQUIRED.}
    \item{x}{A vector of column names in data - will be converted to numerical
    vaules. REQUIRED.}
    \item{y}{A vector of column names in data - will be converted to numerical
    vaules. REQUIRED.}
    \item{titleX}{X-axis title. DEFAULT = "". OPTIONAL.}
    \item{cexTitleX}{X-axis title cex. DEFAULT = 1.0. OPTIONAL.}
    \item{rotTitleX}{X-axis title rotation in degrees. DEFAULT = 0. OPTIONAL.}
    \item{colTitleX}{X-axis title colour. DEFAULT = "black". OPTIONAL.}
    \item{fontTitleX}{X-axis title font style. 1, plain; 2, bold; 3, italic; 4,
    bold-italic. DEFAULT = 2. OPTIONAL.}
    \item{titleY}{Y-axis title. DEFAULT = "". OPTIONAL.}
    \item{cexTitleY}{Y-axis title cex. DEFAULT = 1.0. OPTIONAL.}
    \item{rotTitleY}{Y-axis title rotation in degrees. DEFAULT = 0. OPTIONAL.}
    \item{colTitleY}{Y-axis title colour. DEFAULT = "black". OPTIONAL.}
    \item{fontTitleY}{Y-axis title font style. 1, plain; 2, bold; 3, italic; 4,
    bold-italic. DEFAULT = 2. OPTIONAL.}
    \item{cexLabX}{X-axis labels cex. DEFAULT = 1.0. OPTIONAL.}
    \item{rotLabX}{X-axis labels rotation in degrees. DEFAULT = 0. OPTIONAL.}
    \item{colLabX}{X-axis labels colour. DEFAULT = "black". OPTIONAL.}
    \item{fontLabX}{X-axis labels font style. 1, plain; 2, bold; 3, italic; 4,
    bold-italic. DEFAULT = 2. OPTIONAL.}
    \item{cexLabY}{Y-axis labels cex. DEFAULT = 1.0. OPTIONAL.}
    \item{rotLabY}{Y-axis labels rotation in degrees. DEFAULT = 0. OPTIONAL.}
    \item{colLabY}{Y-axis labels colour. DEFAULT = "black". OPTIONAL.}
    \item{fontLabY}{Y-axis labels font style. 1, plain; 2, bold; 3, italic; 4,
    bold-italic. DEFAULT = 2. OPTIONAL.}
    \item{posLab}{Positioning of the X- and Y-axis labels. "bottomleft", bottom
    and left; "topright", top and right; "all", bottom / top and left /right;
    "none", no labels. DEFAULT = "bottomleft". OPTIONAL.}
    \item{col}{Colour shade gradient for RColorBrewer. DEFAULT = c("blue4",
    "blue3", "blue2", "blue1", "white", "red1", "red2", "red3", "red4").
    OPTIONAL.}
    \item{posColKey}{Position of colour key. "bottom", "left", "top", "right".
    DEFAULT = "right". OPTIONAL.}
    \item{cexLabColKey}{Cex for colour key labels. DEFAULT = 1.0. OPTIONAL.}
    \item{cexCorval}{Cex for correlation values to display withn plot. DEFAULT
    = 1.0. OPTIONAL.}
    \item{colCorval}{Correlation values colour. DEFAULT = "black". OPTIONAL.}
    \item{fontCorval}{Font style for correlation values to display withn plot.
    1, plain; 2, bold; 3, italic; 4, bold-italic. DEFAULT = 1. OPTIONAL.}
    \item{scale}{Scale the colour range to max and min cor values.
    DEFAULT = TRUE. OPTIONAL.}
    \item{main}{Plot title. DEFAULT = "". OPTIONAL.}
    \item{cexMain}{Plot title cex. DEFAULT = 2. OPTIONAL.}
    \item{rotMain}{Plot title rotation in degrees. DEFAULT = 0. OPTIONAL.}
    \item{colMain}{Plot title colour. DEFAULT = "black". OPTIONAL.}
    \item{fontMain}{Plot title font style. 1, plain; 2, bold; 3, italic; 4,
    bold-italic. DEFAULT = 2. OPTIONAL.}
    \item{corFUN}{Correlation method: "pearson", "spearman", or "kendall".
    DEFAULT = "pearson". OPTIONAL.}
    \item{corUSE}{Method for handling missing values (see documentation for cor
    function via ?cor). "everything", "all.obs", "complete.obs",
    "na.or.complete", or "pairwise.complete.obs". DEFAULT =
    "pairwise.complete.obs". OPTIONAL.}
    \item{signifSymbols}{Statistical significance symbols to display beside
    correlation values. DEFAULT = c("***", "**", "*", ""). OPTIONAL.}
    \item{signifCutpoints}{Cut-points for statistical significance. DEFAULT =
    c(0, 0.001, 0.01, 0.05, 1). OPTIONAL.}
    \item{colFrame}{Frame colour. DEFAULT = "white". OPTIONAL.}
    \item{plotRsquared}{Plot R-squared values. TRUE / FALSE. DEFAULT = FALSE.
    OPTIONAL.}
}
\details{
CorLevelPlot provides a quick and colourful way to visualise
statistically significant correlations between any combination of
categorical and continuous variables. Moreover, the statistical
significancies of these correlations are also provided.
}
\value{
A \code{\link{lattice}} object.
}
\author{
Kevin Blighe <kevin@clinicalbioinformatics.co.uk>
}
\examples{
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
    MEturquoise <- ESturquoise * scaledy +
        sqrt(1 - ESturquoise ^ 2) * rnorm(no.obs)
    MEblue <- 0.6 * MEturquoise + sqrt(1 - 0.6 ^ 2) * rnorm(no.obs)
    MEbrown <- ESbrown * scaledy + sqrt(1 - ESbrown ^ 2) * rnorm(no.obs)
    MEyellow <- ESyellow * scaledy + sqrt(1 - ESyellow ^ 2) * rnorm(no.obs)
    ModuleEigengeneNetwork1 <- data.frame(y, MEturquoise, MEblue, MEbrown,
        MEgreen, MEyellow)

    CorLevelPlot(data = ModuleEigengeneNetwork1,
        x = c("y", "MEturquoise", "MEblue", "MEbrown", "MEgreen", "MEyellow"),
        y = c("y", "MEturquoise", "MEblue", "MEbrown", "MEgreen", "MEyellow"),
        titleX = "X correlates",
        cexTitleX = 3.0,
        rotTitleX = 0,
        colTitleX = "forestgreen",
        fontTitleX = 2,
        titleY = "Y correlates",
        cexTitleY = 2.0,
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
        posLab = "bottomleft",
        col = c("blue4", "blue3", "blue2", "blue1", "white",
            "red1", "red2", "red3", "red4"),
        posColKey = "right",
        cexLabColKey = 1.0,
        cexCorval = 1.0,
        colCorval = "black",
        fontCorval = 4,
        scale = TRUE,
        main = "WGCNA example",
        cexMain = 2,
        rotMain = 360,
        colMain = "red4",
        fontMain = 4,
        corFUN = "pearson",
        corUSE = "pairwise.complete.obs",
        signifSymbols = c("***", "**", "*", ""),
        signifCutpoints = c(0, 0.001, 0.01, 0.05, 1),
        colFrame = "white",
        plotRsquared = FALSE)
}
