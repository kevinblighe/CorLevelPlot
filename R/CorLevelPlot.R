CorLevelPlot <- function(
    data,
    x,
    y,
    titleX = "",
    titleY = "",
    cexTitleX = 1.0,
    rotTitleX = 0,
    colTitleX = "black",
    fontTitleX = 2,
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
    colourkey = TRUE,
    cexCorval = 1.0,
    fontCorval = 1,
    main = "",
    cexMain = 2,
    rotMain = 0,
    colMain = "black",
    fontMain = 2,
    corFUN = "pearson",
    corUSE = "pairwise.complete.obs",
    signifSymbols = c("***", "**", "*", ""),
    signifCutpoints = c(0, 0.001, 0.01, 0.05, 1),
    colBG = "white",
    plotRsquared = FALSE)
{
    if(!requireNamespace("lattice")) {
        stop("Please install lattice first.", call.=FALSE)
    }

    for (i in 1:length(x)) {
        if(!is.numeric(data[,x[i]])) {
            print(paste("Warning: ", x[i],
                " is not numeric - please check the source data as everything will be converted to a matrix",
                sep=""))
        }
    }

    for (i in 1:length(y)) {
        if(!is.numeric(data[,y[i]])) {
            print(paste("Warning: ", y[i],
                " is not numeric - please check the source data as everything will be converted to a matrix",
                sep=""))
        }
    }

    #Convert the data for x and y to data matrix
    #	NAs are left NA
    #	Character (A-Z a-z) are converted to NA
    #	Character numbers are converted to integers
    #	Factors are converted to numbers based on level ordering
    xvals <- data.matrix(data[,which(colnames(data) %in% x)])
    yvals <- data.matrix(data[,which(colnames(data) %in% y)])
    corvals <- stats::cor(xvals, yvals, use = corUSE, method = corFUN)

    #Create a new df with same dimensions as corvals and fill with P values
    pvals <- corvals
    for (i in 1:ncol(xvals)) {
        for (j in 1:ncol(yvals)) {
            pvals[i,j] <- stats::cor.test(xvals[,i],
                yvals[,j],
                use = corUSE,
                method = corFUN)$p.value
            colnames(pvals)[j] <- colnames(yvals)[j]
        }

        rownames(pvals)[i] <- colnames(xvals)[i]
    }

    #Are we plotting R^2 values?
    if (plotRsquared==TRUE) {
        corvals <- corvals ^ 2
    }

    #Determine max and min correlation values in order to define the range
    max <- max(corvals)
    min <- min(corvals)
    if(abs(max)>abs(min)) {
        iUpperRange <- max+0.05
        iLowerRange <- (max*(-1))-0.05
    } else {
        iUpperRange <- abs(min)+0.05
        iLowerRange <- min-0.05
    }
    if (plotRsquared==TRUE) {
        iUpperRange <- max+0.1
        iLowerRange <- 0
    }
	
    #Define the colour scheme/palette
    cols <- grDevices::colorRampPalette(col)

    #Create a new df with same dimensions as corvals
    #Fill with significances encoded with asterisks
    signif <- corvals
    for (i in 1:ncol(pvals)) {
        signif[,i] <- c(stats::symnum(pvals[,i],
            corr = FALSE,
            na = FALSE,
            cutpoints = signifCutpoints,
            symbols = signifSymbols))
    }

    #Create a new df with same dimensions as corvals
    #Fill with r values merged with the encoded significances
    plotLabels <- corvals
    for (i in 1:nrow(corvals)) {
        for(j in 1:ncol(corvals)) {
            plotLabels[i,j] <- paste(round(corvals[i,j],2),
                signif[i,j],
                sep="")
            colnames(plotLabels)[j] <- colnames(corvals)[j]
        }

        rownames(plotLabels)[i] <- rownames(corvals)[i]
    }

    if (posLab == "bottomleft") {
        posLab = 1
        axisTicks = c(1,0)
    } else if (posLab == "topright") {
        posLab = 2
        axisTicks = c(0,1)
    } else if (posLab == "all") {
        posLab = 3
        axisTicks = c(1,1)
    } else if (posLab == "none") {
        posLab = 0
        axisTicks = c(0,0)
    }

    #Define a panel function for adding labels
    #Labels are passed with z as a third dimension
    labels <- function(x, y, z, ...) {
        lattice::panel.levelplot(x, y, z, ...)
        lattice::ltext(x, y,
            labels = plotLabels,
            cex = cexCorval,
            font = fontCorval)
    }

    lattice::levelplot(
        data.matrix(corvals),
        xlab = list(label = titleX,
            cex = cexTitleX,
            rot = rotTitleX,
            col = colTitleX,
            font = fontTitleX),
        ylab = list(label = titleY,
            cex = cexTitleY,
            rot = rotTitleY,
            col = colTitleY,
            font = fontTitleY),
        panel = labels,
        pretty = TRUE,
        par.settings = list(panel.background = list(col = colBG)),
        scales = list(
            x = list(cex = cexLabX,
                rot = rotLabX,
                col = colLabX,
                font = fontLabX),
            y = list(cex = cexLabY,
                rot = rotLabY,
                col = colLabY,
                font = fontLabY),
            tck = axisTicks,
            alternating = posLab),
        aspect = "fill",
        col.regions = cols,
        cuts = 100,
        at = seq(iLowerRange, iUpperRange, 0.01),
        main = list(label = main,
            cex = cexMain,
            rot = rotMain,
            col = colMain,
            font = fontMain),
        colorkey = colourkey)
}
