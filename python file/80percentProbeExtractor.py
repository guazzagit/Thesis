from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

def extract_time(json):
    try:
        # Also convert to int since update_time will be string.  When comparing
        # strings, "10" is smaller than "2".
        print((json['timestamp']))
        return(datetime.strptime(json['timestamp'], '%Y-%m-%d %H:%M:%S'))
    except KeyError:
        return 0


with open('C:/Users/guazz/Desktop/JSON_Elab/test_in.json', 'r') as unordered, open('C:/Users/guazz/Desktop/JSON_Elab/out.json', 'a') as out:
	lines = []
	for line in unordered:
	    json_obj = json.loads(line)
	    lines.append(json_obj)
	lines.sort(key=extract_time)
	#ok si li ordina. ora vanno divisi in bin e poi fatti i count.
	#for li in lines:
	#	out.write(json.dumps(li))
	#	out.write('\n')
