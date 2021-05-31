from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

Input = sys.argv[1]
Output = sys.argv[2]
#reduction for failure rate in ping measurement.
# 20160min sono per 14giorni di bin
with open(Input,'r') as f, open(Output,'a') as out:
	for line in f:
		decoded = json.loads(line)
		error=0
		#print(decoded["result"][0])
		
		if "error" in decoded["result"][0] or decoded["rcvd"] == 0:
			error= 100
		else:
			error=(((decoded["sent"]-decoded["rcvd"]))/decoded["sent"])*100

		data_set = {"prb_id": decoded["prb_id"], "timestamp": decoded["timestamp"], "msm_id": decoded["msm_id"], "err_rate": error}

		json_dump = json.dumps(data_set)
		print(json_dump)
		#decoded["result"]=(decoded["sent"]-decoded["rcvd"])/100
		#print(decoded)
		out.write(json_dump)
		out.write('\n')

