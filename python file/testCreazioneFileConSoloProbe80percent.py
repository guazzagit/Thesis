from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

# 20160min sono per 14giorni di bin

df1=pd.read_csv('11939688_2020_format_dataCambiata_divisi_NOERROR.csv',parse_dates=['timestamp'],dtype={'mver': str, 'result.size': int, 'resultset.time': int, 'resultset.error.socket':str, 'resultset.error.nameserver':str, 'resultset.dst_name': str, 'resultset.name':str})
df= pd.read_csv('TwoYears_11939688.csv',parse_dates=['timestamp'],dtype={'mver': str, 'result.size': int, 'resultset.time': int, 'resultset.error.socket':str, 'resultset.error.nameserver':str, 'resultset.dst_name': str, 'resultset.name':str})
df['timestamp'] = pd.to_datetime(df['timestamp'])
#print(df['timestamp'])
print(df)
sort=df.sort_values('timestamp')
TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='120min'))["group_id"].count().size # numero totale di timebins di 2h per dati senza errori
#TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].count().size # per la cosa con errori
print(TimeBins)
grouped = sort.groupby(sort.prb_id)
probe=[]

print(grouped.size())
for group in grouped:

	sort2= group[1].sort_values('timestamp')

	sort2["time"]=sort2.timestamp

	group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='120min'))["fw"].median().reset_index()  #per  version no error
	#group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].median().reset_index() # per la versione solo error
	group2= group2.dropna() #toglie zeri

	Id=pd.unique(sort2["prb_id"])[0]
	
	countPerProbe = group2["timestamp"].size
	perc = (np.divide(countPerProbe,TimeBins))*100
	print(perc)
	if perc < 80:
		probe.append(Id)
print(probe)
for elem in probe:
	df1= df1[df1['prb_id']!=elem]


df1.to_csv('11939688_2020_format_dataCambiata_divisi_NOERROR_80percent_all.csv', index=False)  


#fa quello ceh dice cioè salva i dati che stanno per 80percent attivi nei vari bin