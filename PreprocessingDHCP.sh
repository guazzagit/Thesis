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
DIV="_div"
ASN="_asn"
node "NodeJs file/"FormatDHCP.js "$Input1$EXT" "$Output1$form$EXT";
python3 "python file/"DivideFields.py "$Output1$form$EXT" "$Output1$form$DIV$EXT"
node "NodeJs file/"ChangeDateFormat.js "$Output1$form$DIV$EXT" "$Output1$form$DIV$date$EXT";
python3 "python file/"csvConverterDNS_Field_Reduction.py "$Output1$form$DIV$date$EXT" "$Output1$form$DIV$date$EXT2";
node "NodeJs file/"FormatDHCP.js "$Input2$EXT" "$Output2$form$EXT";
python3 "python file/"DivideFields.py "$Output2$form$EXT" "$Output2$form$DIV$EXT"
node "NodeJs file/"ChangeDateFormat.js "$Output2$form$DIV$EXT" "$Output2$form$DIV$date$EXT";
python3 "python file/"csvConverterDNS_Field_Reduction.py "$Output2$form$DIV$date$EXT" "$Output2$form$DIV$date$EXT2";
python3 "python file/"join2csv_noUnnamed.py "$Output1$form$DIV$date$EXT2" "$Output2$form$DIV$date$EXT2" "TwoYears$EXT2";
python3 "python file/"DnsAddressTypeDestination.py "$Output1$form$DIV$date$EXT2" "$Output1$form$DIV$date$ASN$EXT2"
python3 "python file/"DnsAddressTypeDestination.py "$Output2$form$DIV$date$EXT2" "$Output2$form$DIV$date$ASN$EXT2"
python3 "python file/"testCreazioneFileConSoloProbe80percentDHCP.py "$Output1$form$DIV$date$EXT2" "TwoYears$EXT2" "$Output1$form$DIV$date$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDHCP.py "$Output2$form$DIV$date$EXT2" "TwoYears$EXT2" "$Output2$form$DIV$date$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDHCP.py "$Output1$form$DIV$date$ASN$EXT2" "TwoYears$EXT2" "$Output2$form$DIV$date$ASN$OTTO$EXT2";
python3 "python file/"testCreazioneFileConSoloProbe80percentDHCP.py "$Output2$form$DIV$date$ASN$EXT2" "TwoYears$EXT2" "$Output2$form$DIV$date$ASN$OTTO$EXT2";
