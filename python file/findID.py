from datetime import datetime
import pandas as pd
import csv
import sys
import bz2
import json
from ripe.atlas.cousteau import AtlasResultsRequest
from ripe.atlas.cousteau import AtlasLatestRequest
from ripe.atlas.cousteau.exceptions import APIResponseError
from ripe.atlas.cousteau import Measurement
from ripe.atlas.cousteau import Probe
from ripe.atlas.cousteau import MeasurementRequest
Output = sys.argv[1]
#and decoded["type"]["name"]=="dns"
#and decoded["start_time"] >= 1577861854 and decoded["stop_time"] =="none" or decoded["stop_time"] >= 1578207454
#find inside meta the measurement with 2 years of results. must change some param inside for decode ping or dns and other param.
with bz2.BZ2File('meta-20201109.txt.bz2', 'r') as json_file, open(Output, 'a') as outfile1:
	for line in json_file:
		decoded = json.loads(line)
		# if true use resolver is inside the probe resolve_on_probe e use_probe_resolver sono a true lo start time dice 5 giorni prima della fine dell'anno cosi inserisci start e stop però
		if decoded["dst_addr"] == "8.8.8.8" and decoded["is_oneoff"] == False  and decoded["start_time"] < 1609020000 and decoded["type"]["name"]=="dns":
			print("ID:" + str(decoded["msm_id"]))
			#print(decoded)
			if decoded["stop_time"] == None :
				print("STOPCond1:" + str(decoded["stop_time"]))
				outfile1.write(json.dumps(decoded))
				outfile1.write('\n')
			elif (decoded["stop_time"]-decoded["start_time"] >=424800) and decoded["stop_time"] >= 1578268800:
				# famosi 5 giorni di dati almeno. non serve sono sempre di più se non consideriamo le oneoff
				print("STOPCond2:" + str(decoded["stop_time"]))
				outfile1.write(json.dumps(decoded))
				outfile1.write('\n')

