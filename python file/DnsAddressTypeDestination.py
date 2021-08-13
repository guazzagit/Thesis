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
import multiprocessing
from joblib import Parallel, delayed
from tqdm import tqdm
import ipinfo
from ipwhois.net import Net
from ipwhois.asn import IPASN
from pandarallel import pandarallel
import swifter

access_token = '0cc281a1f8ebe8'
#handler = ipinfo.getHandler(access_token)
#pandarallel.initialize()

def convert_ipv4(ip):
    return tuple(int(n) for n in ip.split('.'))
def convert_ipv6(ip):
    return tuple(str(n) for n in ip.split(':'))

def check_ipv4_in(addr, start, end):
    return convert_ipv4(start) < convert_ipv4(addr) < convert_ipv4(end)

def check_ipv6_in(addr, start, end):
	return convert_ipv6(start) < convert_ipv6(addr) < convert_ipv6(end)

Input = sys.argv[1]
Output = sys.argv[2]
FamousDNS = pd.read_csv("FamousDNS_addr.csv")
#priv_pub_ip2asn = pd.read_csv("ip2asn-combined.csv")
#ipv4=pd.read_csv("ip2asn-v4.csv")
#ipv6=pd.read_csv("ip2asn-v6.csv")
df = pd.read_csv(Input) #,parse_dates=['timestamp']
#read csv cosi leggiamo tutto da li e via il discorso di asn dei famosi.
#prb_id,timestamp,resultset.result.rt,dst_addr,subid,country_code,asn_v4
#fieldnames = ['prb_id','timestamp','resultset.result.rt','dst_addr','country_code','asn_v4','ASN_dest,Type']
df['ASN_dest']=""
df['Type']=""


def myfunc(self):


	if (self['dst_addr'] in FamousDNS['ip'].values):
		pos=np.where(FamousDNS["ip"]==self['dst_addr'])
		as_pub=FamousDNS.iloc[pos[0][0],0]
		self['ASN_dest'] = as_pub
		self['Type'] = 'Public'


	elif (ipaddress.ip_address(self['dst_addr']).is_private):
		self['ASN_dest'] = self['asn_v4']
		self['Type'] = 'Private'
	else:
		try:
			net = Net(self['dst_addr'])
			obj = IPASN(net)
			results = obj.lookup(retry_count=0,asn_methods=['whois'])
			as_unkn= results['asn']
			self['ASN_dest']= as_unkn
			self['Type'] = 'UnknownPublic'
			#print(self['Type'])
			#writer.writerow((self['prb_id'],self['timestamp'],self['resultset.result.rt'],self['dst_addr'],self['country_code'],self['asn_v4'],self['ASN_dest'],self['Type']))

		except:
			asnn=float(self['asn_v4'])
			self['ASN_dest'] = asnn
			self['Type'] = 'Private'
	writer.writerow((self['prb_id'],self['timestamp'],self['resultset.result.rt'],self['dst_addr'],self['country_code'],self['asn_v4'],self['ASN_dest'],self['Type']))

	 
with open(Output,"a",newline='') as out:
	writer = csv.writer(out)
	writer.writerow(['prb_id,timestamp,resultset.result.rt,dst_addr,country_code,asn_v4,ASN_dest,Type'])
	print('start')
	df.swifter.apply(myfunc,axis=1)
	#df.to_csv(Output, index=False)
	print("end")