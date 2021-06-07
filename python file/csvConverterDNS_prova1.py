import pandas as pd
import csv
import sys
import json
from datetime import datetime
from pandas.io.json import json_normalize
from flatten_json import flatten
#create csv from a json file.
Input = sys.argv[1]
Output = sys.argv[2]
#fieldnames = ['from','fw','group_id','lts','msm_id','msm_name','prb_id','stored_timestamp','timestamp','type','resultset','resultset.af','resultset.dst_addr','resultset.dst_port','resultset.lts','resultset.proto','resultset.result.ANCOUNT','resultset.result.ARCOUNT','resultset.result.ID','resultset.result.NSCOUNT','resultset.result.QDCOUNT','resultset.result.abuf','resultset.result.rt','resultset.result.size','resultset.src_addr','resultset.subid','resultset.submax','resultset.time','mver']
fieldnames = ['prb_id','timestamp','resultset.result.rt']
with open(Input,'r') as f, open(Output, 'a',newline='') as out:
    new = csv.writer(out)
    new.writerow(fieldnames)
    y=0
    for line in f:
        x= json.loads(line)
        if "result" not in x["resultset"]:
            y=float("NaN")
        else:
            y=x["resultset"]["result"]["rt"]

        new.writerow([x["prb_id"],x["timestamp"],y])

print("CSV DONE")