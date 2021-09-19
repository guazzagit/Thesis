#!/bin/bash
Input1="$1"
Input2="$2"
Input3="$3"
Input4="$4"
EXT2=".csv"
EXT3=".mat"



/usr/local/MATLAB/R2020b/bin/matlab -batch addpath('github_repo'); addpath('/home/guazzelli/disco/file'); addpath('/home/guazzelli/disco/Thesis/Matlab file'); '/home/guazzelli/disco/Thesis/Matlab file/'PlotEuropePING "$Input1$EXT2" "$Input3$EXT3"
