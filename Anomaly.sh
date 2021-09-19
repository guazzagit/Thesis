#!/bin/bash
Input1="$1"
Input2="$2"
EXT2=".csv"
RED="_ASN"
python3 "python file/"asn_adder.py "$Input1$EXT2" "python file/"ID_Country_asn.csv "$Input1$RED$EXT2";
python3 "python file/"asn_adder.py "$Input2$EXT2" "python file/"ID_Country_asn.csv "$Input2$RED$EXT2";
python3 "python file/"adtk_test.py "$Input1$RED$EXT2" "2019";
python3 "python file/"adtk_test.py "$Input2$RED$EXT2" "2020";