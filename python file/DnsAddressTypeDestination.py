import pandas as pd
import csv
from csv import DictReader, DictWriter
import sys
import json
import numpy as np
from csv import DictReader
from datetime import datetime
import ipaddress
from aslookup import get_as_data
import pyasn
from ipwhois import IPWhois


Input = sys.argv[1]
Output = sys.argv[2]
FamousDNS = pd.read_csv("FamousDNS_addr.csv")
#read csv cosi leggiamo tutto da li e via il discorso di asn dei famosi.
#prb_id,timestamp,resultset.result.rt,dst_addr,subid,country_code,asn_v4
#fieldnames = ['prb_id','timestamp','resultset.result.rt','dst_addr','country_code','asn_v4','ASN_dest,Type']
with open(Input,"r",encoding="utf8") as f:
	read = csv.reader(f)
	next(read)
	with open(Output, "a",newline='') as result:
		writer = csv.writer(result)
		writer.writerow(['prb_id,timestamp,resultset.result.rt,dst_addr,country_code,asn_v4,ASN_dest,Type'])
		for r in read:
			
			if (r[3] in FamousDNS['ip'].values):
				pos=np.where(FamousDNS["ip"]==r[3])[0][0]
				as_pub=FamousDNS.iloc[pos,0]
				writer.writerow((r[0],r[1],r[2],r[3],r[5],r[6],as_pub,'Public'))
			elif (ipaddress.ip_address(r[3]).is_private):
				writer.writerow((r[0],r[1],r[2],r[3],r[5],r[6],r[6],'Private'))
			else:
				obj = IPWhois(r[3])
				res=obj.lookup_rdap(asn_methods=['dns', 'whois', 'http'])
				as_unkn= res['asn']
				writer.writerow((r[0],r[1],r[2],r[3],r[5],r[6],as_unkn,'UnknownPublic'))
				

