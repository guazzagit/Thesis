from datetime import datetime
import pandas as pd
import csv
import sys
import bz2
import json

#with open("16474724_nuovo.json", "r") as file:
#    first_line = file.readline()
#    for last_line in file:
#        pass
#print(last_line)



data = []
with  bz2.BZ2File('20201109.json.bz2','r') as f, open('ID_Country_asn.json', 'a') as output:
	for line in f:
		file = json.loads(line)
		for elem in file["objects"]:
			string= {"prb_id":elem["id"],"country_code":elem["country_code"], "asn_v4":elem["asn_v4"]}
			string2= "{\"prb_id\":" + str(elem["id"]) +", " +"\"country_code\":"+ "\""+ str(elem["country_code"]) +"\"asn_v4\":"+ "\""+ str(elem["asn_v4"]) +"\""+ "}\n"
			value=json.dumps(string, separators=(',', ':'))
			output.write(value)
			output.write("\n")