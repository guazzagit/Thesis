import pandas as pd
import csv
import sys
import json
from datetime import datetime
Input = sys.argv[1]
Output = sys.argv[2]
#divide dns resultset field
with open(Input,'r') as f, open(Output,'a') as out:
		for line in f:
			try:
				data = json.loads(line)
				leng = len(data["resultset"])

				for i in range(0, leng):
					elem=data.copy()
					#print(elem["resultset"][i])
					string= elem["resultset"][i]
					elem.pop("resultset")
					elem["resultset"] = string
					
					#data.append(elem)
					json.dump(elem, out)
					out.write('\n')
			except Exception as e:
				print('error:',e)
				print(line)

		print("Done")
	