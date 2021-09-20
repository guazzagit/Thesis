#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
VIrg=","
APP="'"
/usr/local/MATLAB/R2020b/bin/matlab -batch "FindChangePTS($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT2$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "FindChangePTRegions($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT2$APP)"