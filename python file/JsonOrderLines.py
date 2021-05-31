from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np
Input = sys.argv[1]
Output = sys.argv[2]

def extract_time(json):
    try:
        return(datetime.strptime(json['timestamp'], '%Y-%m-%d %H:%M:%S'))
    except KeyError:
        return 0


with open(Input, 'r') as unordered, open(Output, 'a') as out:
	lines = []
	for line in unordered:
	    json_obj = json.loads(line)
	    lines.append(json_obj)
	lines.sort(key=extract_time)

	#ok si li ordina. ora vanno divisi in bin e poi fatti i count.
	#for li in lines:
	#	out.write(json.dumps(li))
	#	out.write('\n')