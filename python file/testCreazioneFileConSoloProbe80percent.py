from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

df=pd.read_csv('12001626_quad1_2019_formattato_dataCambiata_NOERROR_abuf.csv',parse_dates=['timestamp'])
#print(df['timestamp'])
df['timestamp'] = pd.to_datetime(df['timestamp'])
#print(df['timestamp'])
sort=df.sort_values('timestamp')
TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='120min'))["result.size"].count().size # numero totale di timebins di 2h
grouped = sort.groupby(sort.prb_id)
probe=[]

print(grouped.size())
for group in grouped:

	sort2= group[1].sort_values('timestamp')

	sort2["time"]=sort2.timestamp

	group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='120min'))["result.rt"].median().reset_index()
	group2= group2.dropna() #toglie zeri

	Id=pd.unique(sort2["prb_id"])[0]
	
	countPerProbe = group2["timestamp"].size
	perc = (np.divide(countPerProbe,TimeBins))*100
	
	if perc < 80:
		probe.append(Id)
print(probe)
for elem in probe:
	df= df[df['prb_id']!=elem]


df.to_csv('out.csv', index=False)  


#fa quello ceh dice cioè salva i dati che stanno per 80percent attivi nei vari bin