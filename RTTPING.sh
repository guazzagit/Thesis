#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
VIrg=","
APP="'"
echo "/home/guazzelli/disco/Thesis/Matlab file/PlotErrorPing(/home/guazzelli/disco/Thesis/$APP$Input1$EXT2$APP$VIrg /home/guazzelli/disco/Thesis/$APP$Input2$EXT3$APP)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "/home/guazzelli/disco/Thesis/Matlab file/PlotErrorPing($APP/home/guazzelli/disco/Thesis/$Input1$EXT2$APP$VIrg $APP/home/guazzelli/disco/Thesis/$Input2$EXT3$APP)"