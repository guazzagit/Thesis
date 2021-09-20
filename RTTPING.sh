#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
Prima="'"
/usr/local/MATLAB/R2020b/bin/matlab -batch "/home/guazzelli/disco/Thesis/Matlab file/PlotEuropePING("$Prima$Input1$EXT2$Prima" "$Prima$Input2$EXT3$Prima")"