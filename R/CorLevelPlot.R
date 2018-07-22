#Function:	CorLevelPlot
#Purpose:	Accepts a data matrix/frame and vectors of xy correlates, and generates/plots a correlation matrix with significances for these 
#Parameters:	dfClinParameters, Data-frame/matrix with correlates as column names
#		x, vector of correlates (column names) contained within dfClinParameters
#		y, ||	||	||
#		Size of the labels inside the plot area
#		strCorMethod, one of "pearson", "kendall", "spearman"
#		strPalette, one of RColorBrewer's palettes (see http://svitsrv25.epfl.ch/R-doc/library/RColorBrewer/html/ColorBrewer.html)
#		iNumColours, number of colours to use in the palette (if too many chosen, the max will automatically be chosen)
#		boolReverse, Reverse the palette?
#		boolPlotRSquared, plot R^2 values?
#		strTitle, plot title
#Requires:	lattice, latticeExtra, RColorBrewer
#Written by:	Kevin Blighe, finalised 10th October 2016
CorLevelPlot <- function(df, x, y, labcex, strCorMethod, strPalette, iNumColours, boolReverse, boolPlotRSquared, strTitle)
{
	#Required packages
	require(lattice)
	require(latticeExtra)
	require(RColorBrewer)

	#Check to see if everything is numeric; if not, print a warning message
	for (i in 1:length(x))
	{
		if(!is.numeric(df[,x[i]]))
		{
			print(paste("Warning: ", x[i], " is not numeric - please check the source data as everything will be converted to a matrix", sep=""))
		}
	}
	for (i in 1:length(y))
	{
		if(!is.numeric(df[,y[i]]))
		{
			print(paste("Warning: ", y[i], " is not numeric - please check the source data as everything will be converted to a matrix", sep=""))
		}
	}

	#Convert the data for x and y to data matrix
	#	NAs are left NA
	#	Character (A-Z a-z) are converted to NA
	#	Character numbers are converted to integers
	#	Factors re converted to numbers based on level ordering
	xvals <- data.matrix(df[,which(colnames(df) %in% x)])
	yvals <- data.matrix(df[,which(colnames(df) %in% y)])
	corvals <- cor(xvals, yvals, use="pairwise.complete.obs", method=strCorMethod)

	#Create a new df with same dimensions as corvals and fill with P values
	pvals <- corvals
	for (i in 1:ncol(xvals))
	{
		for (j in 1:ncol(yvals))
		{
			pvals[i,j] <- cor.test(xvals[,i], yvals[,j], use="pairwise.complete.obs", method=strCorMethod)$p.value
			colnames(pvals)[j] <- colnames(yvals)[j]
		}

		rownames(pvals)[i] <- colnames(xvals)[i]
	}

	#Are we plotting R^2 values?
	if (boolPlotRSquared==TRUE)
	{
		corvals <- corvals^2
	}

	#Determine max and min correlation values in order to define the range
	#If all values are low, the range will be smaller
	#This can be visually improved by also adjusting the colour scaling in leveplot() with 'at=seq(iLowerRange,iUpperRange,0.01)'
	max <- max(corvals)
	min <- min(corvals)
	if(abs(max)>abs(min))
	{
		iUpperRange <- max+0.05
		iLowerRange <- (max*(-1))-0.05
	}
	else
	{
		iUpperRange <- abs(min)+0.05
		iLowerRange <- min-0.05
	}
	if (boolPlotRSquared==TRUE)
	{
		iUpperRange <- max+0.1
		iLowerRange <- 0
	}
	
	#Define the colour scheme/palette
	if (boolReverse==TRUE)
	{
		cols <- colorRampPalette(rev(brewer.pal(iNumColours, strPalette)))
	}
	else
	{
		cols <- colorRampPalette(brewer.pal(iNumColours, strPalette))
	}

	#Create a new df with same dimensions as corvals and fill with significances encoded with asterisks
	signif <- corvals
	for (i in 1:ncol(pvals))
	{
		signif[,i] <- c(symnum(pvals[,i], corr=FALSE, na=FALSE, cutpoints=c(0, 0.001, 0.01, 0.05, 1), symbols=c("***", "**", "*", "")))
	}

	#Create a new df with same dimensions as corvals and fill with r values merged with the encoded significances
	plotLabels <- corvals
	for (i in 1:nrow(corvals))
	{
		for(j in 1:ncol(corvals))
		{
			plotLabels[i,j] <- paste(round(corvals[i,j],2), signif[i,j], sep="")
			colnames(plotLabels)[j] <- colnames(corvals)[j]
		}

		rownames(plotLabels)[i] <- rownames(corvals)[i]
	}

	#Define a panel function for adding labels
	#Labels are passed with z as a third dimension
	labels=function(x,y,z,...)
	{
		panel.levelplot(x,y,z,...)
		ltext(x, y, labels=plotLabels, cex=labcex, font=1)
		#panel.text(x, y, plotLabels[x,y], cex=labcex)
	}

	levelplot(data.matrix(corvals), panel=labels, xlab="", ylab="", pretty=TRUE, scales=list(x=list(rot=45)), aspect="fill", col.regions=cols, main=strTitle, cuts=100, at=seq(iLowerRange,iUpperRange,0.01))
}
