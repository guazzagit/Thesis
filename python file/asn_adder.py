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
with open(Input,'r') as f, open(Output,'a',newline='') as out:
	df=pd.read_csv(Input2)
	reader1 = DictReader(f)
	new = csv.writer(out)
	new.writerow(fieldnames)
	for line1 in reader1:
		if (df['prb_id']==int(line1['prb_id'])).bool:
			#inded= df.index[df['prb_id'].contains(line1['prb_id'])]
			
			mask=df[df['prb_id']==int(line1['prb_id'])].index.values[0]		
			#print(mask)
			#print(df.iloc[mask]['prb_id'])
			new.writerow([line1['prb_id'],line1['timestamp'],line1['resultset.result.rt'],df.iloc[mask]['asn_v4']])

print("DONE")