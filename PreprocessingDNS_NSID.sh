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
NSID="NSID"
OER="_ONLYERROR"
OTTO="_80percent"
node "NodeJs file/"FormatData.js "$Input1$EXT" "$Output1$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output1$form$EXT" "$Output1$form$date$EXT";
cat "$Output1$form$date$EXT" | python3 "python file/"saveNsID.py -dall;
mv risult.json "$Output1$form$date$NSID$EXT" #non fa
node "NodeJs file/"TypeSelectionDNS.js "$Output1$form$date$NSID$EXT" "$Output1$form$date$NSID$NER$EXT" OK;
node "NodeJs file/"TypeSelectionDNS.js "$Output1$form$date$NSID$EXT" "$Output1$form$date$NSID$OER$EXT" NO;
python3 "python file/"csvConverterDNS.py "$Output1$form$date$NSID$OER$EXT" "$Output1$form$date$NSID$OER$EXT2";
python3 "python file/"csvConverterDNS.py "$Output1$form$date$NSID$NER$EXT" "$Output1$form$date$NSID$NER$EXT2";
python3 "python file/"csvConverterDNS.py "$Output1$form$date$EXT" "$Output1$form$date$EXT2";
node "NodeJs file/"FormatData.js "$Input2$EXT" "$Output2$form$EXT";
node "NodeJs file/"ChangeDateFormat.js "$Output2$form$EXT" "$Output2$form$date$EXT";
cat "$Output2$form$date$EXT" | python3 "python file/"saveNsID.py -dall;
mv risult.json "$Output2$form$date$NSID$EXT"  # non fa
node "NodeJs file/"TypeSelectionDNS.js "$Output2$form$date$NSID$EXT" "$Output2$form$date$NSID$NER$EXT" OK;
node "NodeJs file/"TypeSelectionDNS.js "$Output2$form$date$NSID$EXT" "$Output2$form$date$NSID$OER$EXT" NO;
python3 "python file/"csvConverterDNS.py "$Output2$form$date$NSID$OER$EXT" "$Output2$form$date$NSID$OER$EXT2";
python3 "python file/"csvConverterDNS.py "$Output2$form$date$NSID$NER$EXT" "$Output2$form$date$NSID$NER$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$NSID$OER$EXT2" "$Output2$form$date$NSID$OER$EXT2" "TwoYears$OER$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$NSID$NER$EXT2" "$Output2$form$date$NSID$NER$EXT2" "TwoYears$NER$EXT2";
python3 "python file/"join2csv.py "$Output1$form$date$EXT2" "$Output2$form$date$EXT2" "TwoYears$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$NSID$NER$EXT2" "TwoYears$NER$EXT2" "$Output1$form$date$NSID$NER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output1$form$date$NSID$OER$EXT2" "TwoYears$OER$EXT2" "$Output1$form$date$NSID$OER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output2$form$date$NSID$NER$EXT2" "TwoYears$NER$EXT2" "$Output2$form$date$NSID$NER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output2$form$date$NSID$OER$EXT2" "TwoYears$OER$EXT2" "$Output2$form$date$NSID$OER$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDNS.py "$Output2$form$date$EXT2" "TwoYears$EXT2" "$Output2$form$date$OTTO$EXT2";
