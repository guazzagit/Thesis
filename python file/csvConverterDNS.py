import pandas as pd
import csv
import sys
import json
from datetime import datetime
Input = sys.argv[1]
Output = sys.argv[2]
data = []
with open(Input,'r') as f:
    for line in f:
        data.append(json.loads(line))
print("step 1 fatto. dati caricati")

data = pd.json_normalize(data)
print("step 2 fatto normalizzato")
#for i in range(len(data)):
#   data.timestamp[i] = datetime.fromtimestamp(int(data.timestamp[i])).strftime('%Y-%m-%d %H:%M:%S')
#   print(i)
#print("step 3 fatto convertite le date")
#rs = data.to_csv
#print (rs)
print("creo csv")
data.to_csv(Output)
print("fatto csv")

