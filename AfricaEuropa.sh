#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
VIrg=","
APP="'"
/usr/local/MATLAB/R2020b/bin/matlab -batch "AFR_ALL_TESTSign($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT2$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "EU_ALL_TESTSign($APP$Input1$EXT2$APP$VIrg $APP$Input2$EXT2$APP)"