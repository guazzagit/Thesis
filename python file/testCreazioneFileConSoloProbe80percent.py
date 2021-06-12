from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np
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
TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='240min'))["resultset.result.rt"].median().size # numero totale di timebins di 2h per dati senza errori
#TimeBins = sort.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].count().size # per la cosa con errori
print(TimeBins)
grouped = sort.groupby(sort.prb_id)
probe=[]

#print(grouped.size())
for group in grouped:

	sort2= group[1].sort_values('timestamp')

	#sort2["time"]=sort2.timestamp
	#print(sort2)
	group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='240min'))["resultset.result.rt"].median().reset_index()  #per  version no error
	#group2 = sort2.groupby(pd.Grouper(key='timestamp',freq='360min'))["af"].median().reset_index() # per la versione solo error
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
df1.drop(df1[df1['prb_id'].isin(probe)], inplace=True)
del df
del sort2
del sort
del group2
del grouped
df1.to_csv(Output, index=False)  


#fa quello ceh dice cioè salva i dati che stanno per 80percent attivi nei vari bin