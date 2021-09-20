#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
EXT3=".mat"
echo '$Input1$EXT2'
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r "try; /home/guazzelli/disco/Thesis/Matlab file/PlotEuropePING "$Input1$EXT2" "$Input2$EXT3"; catch; end; quit;"