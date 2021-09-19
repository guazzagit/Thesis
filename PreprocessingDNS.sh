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
node "NodeJs file/"FormatData.js "$Input1$EXT" "$Output1$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output1$form$EXT" "$Output1$form$date$EXT";
node "NodeJs file/"TypeSelectionDNS.js "$Output1$form$date$EXT" "$Output1$form$date$NER$EXT" OK;
node "NodeJs file/"TypeSelectionDNS.js "$Output1$form$date$EXT" "$Output1$form$date$OER$EXT" NO;
python3 "python file/"csvConverterDNS.py "$Output1$form$date$OER$EXT" "$Output1$form$date$OER$EXT2";
python3 "python file/"csvConverterDNS.py "$Output1$form$date$NER$EXT" "$Output1$form$date$NER$EXT2";
node "NodeJs file/"FormatData.js "$Input2$EXT" "$Output2$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output2$form$EXT" "$Output2$form$date$EXT";
node "NodeJs file/"TypeSelectionDNS.js "$Output2$form$date$EXT" "$Output2$form$date$NER$EXT" OK;
node "NodeJs file/"TypeSelectionDNS.js "$Output2$form$date$EXT" "$Output2$form$date$OER$EXT" NO;
python3 "python file/"csvConverterDNS.py "$Output2$form$date$OER$EXT" "$Output2$form$date$OER$EXT2";
python3 "python file/"csvConverterDNS.py "$Output2$form$date$NER$EXT" "$Output2$form$date$NER$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$OER$EXT2" "$Output2$form$date$OER$EXT2" "TwoYears$OER$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$NER$EXT2" "$Output2$form$date$NER$EXT2" "TwoYears$NER$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$NER$EXT2" "TwoYears$NER$EXT2" "$Output1$form$date$NER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$OER$EXT2" "TwoYears$OER$EXT2" "$Output1$form$date$OER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output2$form$date$NER$EXT2" "TwoYears$NER$EXT2" "$Output2$form$date$NER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output2$form$date$OER$EXT2" "TwoYears$OER$EXT2" "$Output2$form$date$OER$OTTO$EXT2";
