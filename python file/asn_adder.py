import pandas as pd
import csv
import sys
from csv import DictReader, DictWriter
import json
from datetime import datetime
from pandas.io.json import json_normalize
from flatten_json import flatten
#create csv from a json file.
Input = sys.argv[1]
Input2 = sys.argv[2]
Output= sys.argv[3]

#fieldnames = ['from','fw','group_id','lts','msm_id','msm_name','prb_id','stored_timestamp','timestamp','type','resultset','resultset.af','resultset.dst_addr','resultset.dst_port','resultset.lts','resultset.proto','resultset.result.ANCOUNT','resultset.result.ARCOUNT','resultset.result.ID','resultset.result.NSCOUNT','resultset.result.QDCOUNT','resultset.result.abuf','resultset.result.rt','resultset.result.size','resultset.src_addr','resultset.subid','resultset.submax','resultset.time','mver']
fieldnames = ['prb_id','timestamp','resultset.result.rt','asn']
df=pd.read_csv(Input2)
df1=pd.read_csv(Input,parse_dates=['timestamp'])
lista=df['prb_id'].tolist()
lista_asn=df['asn_v4'].tolist()
inded= df1.index[df1['prb_id'].isin(lista)].tolist()
result=pd.merge(df1,df,how="left", on=["prb_id"])

#print(inded)
result.drop("Unnamed: 0",axis=1, inplace=True)
#print(result)
result.to_csv(Output, index=False) 
print("DONE")
