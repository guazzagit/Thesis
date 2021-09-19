#!/bin/bash
Input1="$1"
Input2="$2"
Input3="$3"
Input4="$4"
EXT2=".csv"
EXT3=".mat"
addpath('github_repo')
addpath('/home/guazzelli/disco/file')
addpath('/home/guazzelli/disco/Thesis/Matlab file')
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotEuropePING "$Input1$EXT2" "$Input3$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotEuropePING "$Input1$EXT2" "$Input4$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotEurope90PercentPING "$Input1$EXT2" "$Input3$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotEurope90PercentPING "$Input1$EXT2" "$Input4$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotCountryPING "$Input1$EXT2" "$Input3$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotCountryPING "$Input1$EXT2" "$Input4$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotCountry90PercentPING "$Input1$EXT2" "$Input3$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotCountry90PercentPING "$Input1$EXT2" "$Input4$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotErrorPing "$Input1$EXT2" "$Input3$EXT3"
/usr/local/MATLAB/R2020b/bin/matlab -nodisplay -nodesktop -r '/home/guazzelli/disco/Thesis/Matlab file/'PlotErrorPing "$Input1$EXT2" "$Input4$EXT3"