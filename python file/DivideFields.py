import pandas as pd
import csv
import sys
import json
from datetime import datetime
#pd.read_json('data1Puliti.json', lines=True).to_csv('data1Puliti.csv')
#i think is ok  C:/Users/guazz/Desktop/provaprogramma/16474724_nuovo_formattato_dataCambiata_NOERROR.json
#data = []
with open('C:/Users/guazz/Desktop/JSON_Elab/11939688_2019_format_dataCambiata.json','r') as f, open('C:/Users/guazz/Desktop/JSON_Elab/11939688_2019_format_dataCambiata_divisi.json','a') as out:
	for line in f:
		#data.append(json.loads(line))
		Cavolo = json.loads(line)
		leng = len(Cavolo["resultset"])

		for i in range(0, leng):
			fritto=Cavolo.copy()
			print(fritto["resultset"][i])
			string= fritto["resultset"][i]
			fritto.pop("resultset")
			fritto["resultset"] = string
			
			#data.append(fritto)
			json.dump(fritto, out)
			out.write('\n')
	print("step 1 fatto. dati caricati")
	#json.dump(data, out)
#data = pd.json_normalize(data)
#print("step 2 fatto normalizzato")
#for i in range(len(data)):
#	data.timestamp[i] = datetime.fromtimestamp(int(data.timestamp[i])).strftime('%Y-%m-%d %H:%M:%S')
#	print(i)
#print("step 3 fatto convertite le date")
#rs = data.to_csv
#print (rs)
	print("creo csv")
#data.to_csv(r'C:/Users/guazz/Desktop/JSON_Elab/11111111.csv')
	print("fatto csv")
