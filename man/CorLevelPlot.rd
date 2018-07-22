\name{CorLevelPlot}
\alias{CorLevelPlot}
\title{Visualise correlation results and test significancies of these}
\description{CorLevelPlot provides a quick and colourful way to visualise
statistically significant correlations between any combination of
categorical and continuous variables. Moreover, the statistical
significancies of these correlations are also provided.}
\usage{
CorLevelPlot(df,
    x,
    y,
    labcex,
    strCorMethod,
    strPalette,
    iNumColours,
    boolReverse,
    boolPlotRSquared,
    strTitle)
}
\arguments{
    \item{toptable}{A data-frame of test statistics (if not a data frame,
    an attempt will be made to convert it to one). Requires at least
    the following: column for transcript names (can be rownames); a column
    for log2 fold changes; a column for nominal or adjusted p-value.
    REQUIRED.}
    \item{df}{ data-frame/matrix}
    \item{x}{vector of column names in df}
    \item{y}{vector of column names in df to be correlated to x}
    \item{labCex}{size of the labels inside the plot area}
    \item{strCorMethod}{one of "pearson", "kendall", "spearman"}
    \item{strPalette}{one of RColorBrewer's palettes (see http://www.r-graph-gallery.com/38-rcolorbrewers-palettes/)}
    \item{iNumColours}{number of colours to use in the palette (if too many chosen, the max will automatically be chosen)}
    \item{boolReverse}{Reverse the palette? (TRUE/FALSE)}
    \item{boolPlotRSquared}{plot R^2 values? (TRUE/FALSE)}
    \item{strTitle}{plot title</li>

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

}
