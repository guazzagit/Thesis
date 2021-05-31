from datetime import datetime
import pandas as pd
import csv
import sys
import json
from ripe.atlas.cousteau import AtlasResultsRequest
from ripe.atlas.cousteau import AtlasLatestRequest
from ripe.atlas.cousteau import AtlasRequest
from ripe.atlas.cousteau import MeasurementRequest
from ripe.atlas.cousteau.exceptions import APIResponseError
from ripe.atlas.cousteau import Measurement
from ripe.atlas.cousteau import Probe
from ripe.atlas.sagan import Result
from ripe.atlas.sagan import DnsResult

#	    "start": 1579293137, questi sono quelli completi per l'arco considerato fin ora.
#	    "stop": 1617870958 quad8MesID Allquad9MEasures
#[10294468, 16453701, 16474724, 23848289, 23975201] DoppioDNSACASO

# 1/01/2020 1:00:00  ==== 1577836800
# 31/12/2020 23:45:00 ==== 1609454700

Input = sys.argv[1] # measure to check if NSID is present
Output = sys.argv[2] # results of ms where NSID is present


def requestfunction(interval, start, stop, MesId):
	stopCondition = 1609454700
	print(interval)
	print(start)
	print(stop)
	print(MesId)
	if start < 1577836800:
		StartTime = 1577836800
	else:
		StartTime=start
	UrlList=[]
	if stop !="none":
		StopTime = stop
		Cond = stop
	else:
		print("eccomi")
		StopTime=StartTime + interval
		Cond = stopCondition

	while StopTime<=Cond:
		#messo 31/12/2020 alle 23:45:00
		NewUrl ="/api/v2/measurements/"+ str(MesId)+"/results/?start=" + str(StartTime) + "&stop=" + str(StopTime)
		UrlList.append(NewUrl)
		StartTime = StartTime+interval
		StopTime = StopTime+interval
		if interval == 0:
			return UrlList	
	return UrlList




with open(Output, 'a') as f, open(Input, 'r') as test:

	for elem in test:
		prova = json.loads(elem)
		if prova.get("id"):
			MesId = prova["id"]
		else:
			MesId=prova["msm_id"]
		print(MesId)
		if prova["probes"] == None:
			probe_id=prova['probes'][0]['id']
			url_path ="/api/v2/measurements/"+ str(MesId)+"/latest/?probe_ids="+str(probe_id)
		else:
			url_path ="/api/v2/measurements/"+ str(MesId)+"/latest"
		#url_path ="https://atlas.ripe.net/api/v2/measurements/"+ str(MesId) +"/results/?start=" + str(inizio) + "&?stop=" + str(fine);

		request = AtlasRequest(**{"url_path": url_path}) #perchè possono essere più di uno i risult.
		(is_success, results) = request.get()
		
		#se è denied lo scheduling allora fa l'else
		if results != []:
			kwargs = {
			    "msm_id": MesId,
			    "start": results[0]["timestamp"],
			    "stop": results[0]["timestamp"],
			    "probe_ids": results[0]["prb_id"]
			}
			#print(kwargs)
			is_success, results = AtlasResultsRequest(**kwargs).create()
			#is_success, results = AtlasLatestRequest(**kwargs).create()
			
			if is_success:
				for result in results:
					decoded = Result.get(result)
					#print(decoded.responses[0].abuf.raw_data)
					try:
						#print(decoded.responses[0].abuf.raw_data)
						if decoded.responses[0].abuf.raw_data['EDNS0']['Option'] !=[] and 'NSID' in decoded.responses[0].abuf.raw_data['EDNS0']['Option'][0]:
								#print(decoded.responses[0].abuf.raw_data['EDNS0']['Option'][0])


								#chiama funzione che prepara gli url e sotto che esegue una cosa alla volta e salva su file.
								#problema con interval uso quello ?

								#faccio la richiesta per vedere se c'è lo stop time 
								url ="/api/v2/measurements/"+ str(MesId)
								request2 = AtlasRequest(**{"url_path": url})
								(is_success, results2) = request2.get()
								if results2["stop_time"]:
									stop = results2["stop_time"]
								else:
									stop = "none"
								if not results2["interval"]:
									interval = 0
								elif results2["interval"]<86400:
									interval = 86400
								else:
									interval = results2["interval"]
								UrlList = requestfunction(interval, results2["start_time"], stop, MesId)
								print(UrlList)
								# va fatto in modo che le faccia async perchè sennò ci mette una vita eterna....
								for obj in UrlList:
									request3 = AtlasRequest(**{"url_path": obj})
									(is_success, results3) = request3.get()
									if is_success:
										for item in results3:
											f.write(json.dumps(item))
											f.write('\n')
								print("all measurements saveD!")
								#ora bisogna mandare tutte le richieste.
						
						else:
							print("no NSID for sure")
					except KeyError:
						print("no NSID for sure(KeyError)")
					except IndexError:
						print("no NSID for sure(IndexError)")
		else:
			print("no NSID for sure(nodata)")


	#	IDlist=[]
	#	for line in IDSource:
	#		decoded1 = json.loads(line)
	#		print(decoded["msm_id"])
	#		IDlist.append(decoded1["msm_id"])  if 'EDSON0' in decoded.responses[0].abuf.raw_data or decoded.responses[0].abuf.raw_data['EDNS0']:
	#		print(IDlist)
