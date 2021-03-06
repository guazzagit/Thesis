from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np
from csv import DictReader
# save data for probes that are 80% active in 2019/2020
# 20160min sono per 14giorni di bin
Input_Base = sys.argv[1]
Input_twoYears = sys.argv[2]
Output = sys.argv[3]

df1=pd.read_csv(Input_Base,parse_dates=['timestamp'])
df= pd.read_csv(Input_twoYears,parse_dates=['timestamp'])
df['timestamp'] = pd.to_datetime(df['timestamp'])
#print(df['timestamp'])
#print(df)
sort=df.sort_values('timestamp')
if "result.rt" in sort:
	TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='240min'))["result.rt"].median().size # numero totale di timebins di 2h per dati senza errori
else:
	TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].count().size # per la cosa con errori
print(TimeBins)
grouped = sort.groupby(sort.prb_id)
probe=[]

#print(grouped.size())
for group in grouped:

	sort2= group[1].sort_values('timestamp')

	#sort2["time"]=sort2.timestamp
	#print(sort2)
	if "result.rt" in sort2:
		group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='240min'))["result.rt"].median().reset_index()  #per  version no error
	else:
		group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].median().reset_index() # per la versione solo error
	group2= group2.dropna() #toglie zeri

	Id=pd.unique(sort2["prb_id"])[0]

	countPerProbe = group2["timestamp"].size
	#print(group2)
	#print(countPerProbe)
	perc = (np.divide(countPerProbe,TimeBins))*100
	#print(perc)
	if perc < 80:
		probe.append(Id)
print(probe)
del df
del sort2
del sort
del group2
del grouped
inded= df1.index[df1['prb_id'].isin(probe)].tolist()
#print(inded)
df1.drop(labels=inded,axis=0,inplace=True)
df1.to_csv(Output, index=False) 
print("end")
#fa quello ceh dice cioè salva i dati che stanno per 80percent attivi nei vari bin