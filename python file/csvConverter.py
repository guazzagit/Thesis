import pandas as pd
import csv
import sys
import json
from datetime import datetime

#create csv from a json file.
data = []
Input = sys.argv[1]
Output = sys.argv[2]
with open(Input,'r') as f:
    for line in f:
        data.append(json.loads(line))
print("step 1 Done. File loaded")

data = pd.json_normalize(data)
print("step 2 Done. Normalization")

print("create csv")
data.to_csv(Output)
print("Csv ready")

#va ma per file piccoli. se son file grandi chiaramente ciclare per 10.000000 righe è troppo lento. tolto il discorso timestamp viaggia come una palla.