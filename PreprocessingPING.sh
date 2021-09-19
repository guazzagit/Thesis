#!/bin/bash
Input1="$1"
Output1="$2"
Input2="$3"
Output2="$4"
EXT=".json"
EXT2=".csv"
form="_format"
date="_DateChanged"
NER="_NOERROR"
OER="_ONLYERROR"
OTTO="_80percent"
node "NodeJs file/"formatPing.js "$Input1$EXT" "$Output1$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output1$form$EXT" "$Output1$form$date$EXT";
python3 "python file/"csvConverterDNS.py "$Output1$form$date$EXT" "$Output1$form$date$EXT2";
node "NodeJs file/"formatPing.js "$Input2$EXT" "$Output2$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output2$form$EXT" "$Output2$form$date$EXT";
python3 "python file/"csvConverterDNS.py "$Output2$form$date$EXT" "$Output2$form$date$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$EXT2" "$Output2$form$date$EXT2" "TwoYears$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$EXT2" "TwoYears$EXT2" "$Output1$form$date$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$EXT2" "TwoYears$EXT2" "$Output1$form$date$OTTO$EXT2";