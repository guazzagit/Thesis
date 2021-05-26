from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

# 20160min sono per 14giorni di bin
with open('24104774_ping_2020_format_dataCambiata.json','r') as f, open('24104774_ping_2020_format_dataCambiata_errorRate.json','a') as out:
	for line in f:
		decoded = json.loads(line)
		error=0
		#print(decoded["result"][0])
		
		if "error" in decoded["result"][0] or decoded["rcvd"] == 0:
			error= 100
		else:
			error=(((decoded["sent"]-decoded["rcvd"]))/decoded["sent"])*100

		data_set = {"prb_id": decoded["prb_id"], "timestamp": decoded["timestamp"], "msm_id": decoded["msm_id"], "err_rate": error}

		json_dump = json.dumps(data_set)
		print(json_dump)
		#decoded["result"]=(decoded["sent"]-decoded["rcvd"])/100
		#print(decoded)
		out.write(json_dump)
		out.write('\n')


#		count=0
#		lunghezza=1
#		if "error" in decoded["result"]:
#			count=1
#		else:
##			lunghezza=len(decoded["result"])
#			for i in range(lunghezza):
##
#				if "rtt" in decoded["result"][i]:
#					count+=0
#				else:
#					count+=1
#
#		decoded["result"]=count/lunghezza*100
#		print(decoded)
#		out.write(json.dumps(decoded))
#		out.write('\n')
#		count=0
