#!/bin/bash
Input1="$1" # 2019
Input2="$2" # corrisp 2019
Input3="$3" #2020
Input4="$4" # corrisp2020'
EXT2=".csv"
EXT3=".mat"
VIrg=","
APP="'"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotEurope($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotEurope($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotEurope90Percent($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotEurope90Percent($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotCountry($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotCountry($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotCountry90Percent($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "PlotCountry90Percent($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "plotError($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "plotError($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "plotError_regions($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "plotError_regions($APP$Input3$EXT2$APP$VIrg $APP$Input4$EXT3$APP)"
