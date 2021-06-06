import pandas as pd
import csv
import sys
import json
from datetime import datetime
from pandas.io.json import json_normalize
from flatten_json import flatten
#create csv from a json file.
def flatten_json(y):
    out = {}

    def flatten(x, name=''):
        if type(x) is dict:
            for a in x:
                flatten(x[a], name + a + '.')
        elif type(x) is list:
            i = 0
            for a in x:
                flatten(a, name + str(i) + '.')
                i += 1
        else:
            out[name[:-1]] = x

    flatten(y)
    return out

Input = sys.argv[1]
Output = sys.argv[2]
fieldnames = ['from','fw','group_id','lts','msm_id','msm_name','prb_id','stored_timestamp','timestamp','type','resultset','resultset.af','resultset.dst_addr','resultset.dst_port','resultset.lts','resultset.proto','resultset.result.ANCOUNT','resultset.result.ARCOUNT','resultset.result.ID','resultset.result.NSCOUNT','resultset.result.QDCOUNT','resultset.result.abuf','resultset.result.rt','resultset.result.size','resultset.src_addr','resultset.subid','resultset.submax','resultset.time','mver']
fieldnames = ['prb_id','timestamp','resultset.result.rt']
with open(Input,'r') as f, open(Output, 'a',newline='') as out:
	new = csv.writer(out)
	new.writerow(fieldnames)
	for line in f:
		x= json.loads(line)
		new.writerow([x["prb_id"],x["timestamp"],x["resultset"]["result"]["rt"]])

print("CSV DONE")

#va ma per file piccoli. se son file grandi chiaramente ciclare per 10.000000 righe è troppo lento.
# tolto il discorso timestamp viaggia come una palla.
	