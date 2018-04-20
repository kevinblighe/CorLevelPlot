# CorLevelPlot
<h1>Visualise correlation results, e.g., clinical parameter correlations</h1>
<img src="https://github.com/kevinblighe/CorLevelPlot/blob/master/CorLevelPlot1.png">
<img src="https://github.com/kevinblighe/CorLevelPlot/blob/master/CorLevelPlot2.png"><br>
<h2>Requires</h2>
<ul>
  <li>lattice</li>
  <li>latticeExtra</li>
  <li>RColorBrewer</li>
  </ul>
<h2>Execution</h2>
<code>CorLevelPlot(df, x, y, labcex, strCorMethod, strPalette, iNumColours, boolReverse, boolPlotRSquared, strTitle)</code>
<br>
<h2>Parameters</h2>
<ul>
  <li>df, data-frame/matrix</li>
  <li>x, vector of column names in df</li>
  <li>y, vector of column names in df to be correlated to x</li>
  <li>labCex, size of the labels inside the plot area</li>
  <li>strCorMethod, one of "pearson", "kendall", "spearman"</li>
  <li>strPalette, one of RColorBrewer's palettes (see http://svitsrv25.epfl.ch/R-doc/library/RColorBrewer/html/ColorBrewer.html)</li>
  <li>iNumColours, number of colours to use in the palette (if too many chosen, the max will automatically be chosen)</li>
  <li>boolReverse, Reverse the palette? (TRUE/FALSE)</li>
  <li>boolPlotRSquared, plot R^2 values? (TRUE/FALSE)</li>
  <li>strTitle, plot title</li>
</ul>
<br>
<h2>Credits</h2>
Kevin Blighe; Myles Lewis
