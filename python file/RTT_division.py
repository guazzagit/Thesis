from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np
Input = sys.argv[1] #
Output = sys.argv[2]  #
# 20160min sono per 14giorni di bin
with open(Input,'r') as f, open(Output,'a') as out:
	for line in f:
		decoded = json.loads(line)
		print(decoded["result"][0])
		count=0
		lunghezza=1
		if "error" in decoded["result"]:
			count=1
		else:
			lunghezza=len(decoded["result"])
			for i in range(lunghezza):
				if "rtt" in decoded["result"][i]:
					count+=0
				else:
					count+=1

		decoded["result"]=count/lunghezza*100
		print(decoded)
		out.write(json.dumps(decoded))
		out.write('\n')
		count=0
