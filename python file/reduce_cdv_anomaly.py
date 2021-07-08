import pandas as pd
import csv
import sys
from csv import DictReader, DictWriter
import json
from datetime import datetime
from pandas.io.json import json_normalize
from flatten_json import flatten
#create csv from a json file.
Input = sys.argv[1]
Output = sys.argv[2]
with open(Input, "r",encoding="utf8") as source:
	reader = csv.reader(source)
	
	with open(Output, "a",newline='',encoding="utf8") as result:
		writer = csv.writer(result)
		writer.writerow('timestamp,resultset.result.rt,nation')
		for r in reader:
			#if(r[4]=="3269.0" and r[3]=='IT'):
				
				# Use CSV Index to remove a column from CSV
				#r[3] = r['year']
				writer.writerow((r[1],r[2],r[3]))
