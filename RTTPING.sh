#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
VIrg=","
echo "/home/guazzelli/disco/Thesis/Matlab file/PlotEuropePING($Input1$EXT2$VIrg $Input2$EXT3)"
/usr/local/MATLAB/R2020b/bin/matlab -batch "/home/guazzelli/disco/Thesis/Matlab file/PlotEuropePING($Input1$EXT2$VIrg $Input2$EXT3)"