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
import multiprocessing as mp
from joblib import Parallel, delayed
from tqdm import tqdm
import ipinfo
from ipwhois.net import Net
from ipwhois.asn import IPASN
#from pandarallel import pandarallel
#import swifter
import gc
#import dask.dataframe as dd
#from dask.base import compute
#import dask.multiprocessing
#from functools import partial
#dask.config.set(scheduler='processes')
from multiprocesspandas import applyparallel



Input = sys.argv[1]
Output = sys.argv[2]
#FamousDNS = pd.read_csv("FamousDNS_addr.csv")
dict_from_csv = pd.read_csv('FamousDNS_addr.csv', index_col=1, squeeze=True).to_dict()
#priv_pub_ip2asn = pd.read_csv("ip2asn-combined.csv")
#ipv4=pd.read_csv("ip2asn-v4.csv")
#ipv6=pd.read_csv("ip2asn-v6.csv") #,parse_dates=['timestamp']
#read csv cosi leggiamo tutto da li e via il discorso di asn dei famosi.
#prb_id,timestamp,resultset.result.rt,dst_addr,subid,country_code,asn_v4
#fieldnames = ['prb_id','timestamp','resultset.result.rt','dst_addr','country_code','asn_v4','ASN_dest,Type']


def myfunc(self):
	with open(Output,"a",newline='') as out:
		writer = csv.writer(out)
		if self[3] in dict_from_csv.keys():
			#pos=np.where(FamousDNS["ip"]==self[3])
			#as_pub=FamousDNS.iloc[pos[0][0],0]
			ASN_dest= dict_from_csv[self[3]]
			Type= 'Public'
			#writer.writerow((self['prb_id'],self['timestamp'],self['resultset.result.rt'],self['dst_addr'],self['country_code'],self['asn_v4'],ASN_dest,Type))


		elif (ipaddress.ip_address(self[3]).is_private):
			ASN_dest = self[6]
			Type= 'Private'
			#writer.writerow((self['prb_id'],self['timestamp'],self['resultset.result.rt'],self['dst_addr'],self['country_code'],self['asn_v4'],ASN_dest,Type))

		else:
			try:
				net = Net(self[3])
				obj = IPASN(net)
				results = obj.lookup(retry_count=0,asn_methods=['whois'])
				as_unkn= results['asn']
				ASN_dest= as_unkn
				#self['ASN_dest']= as_unkn
				Type= 'UnknownPublic'
				#print(self['Type'])
				#writer.writerow((self['prb_id'],self['timestamp'],self['resultset.result.rt'],self['dst_addr'],self['country_code'],self['asn_v4'],self['ASN_dest'],self['Type']))

			except:
				asnn=float(self[6])
				ASN_dest = asnn
				Type = 'Private'
		writer.writerow((self[0],self[1],self[2],self[3],self[5],self[6],ASN_dest,Type))
		out.close()


with open(Output,"a",newline='') as out:
		writer = csv.writer(out)
		writer.writerow(['prb_id,timestamp,resultset.result.rt,dst_addr,country_code,asn_v4,ASN_dest,Type'])
		out.close()
print('start')
number_lines = sum(1 for row in (open(Input)))

rowsize = 500000
for i in range(1,number_lines,rowsize):

	df = pd.read_csv(Input,header=None,nrows = rowsize,skiprows = i)
	#print("chuck_read_ok")
	#df['ASN_dest']=""
	#df['Type']=""
	#data_split = np.array_split(df, 10)
	#pool = mp.Pool(10)	
	#pool.map(_apply_df, data_split)
	#pool.close()
	df.apply_parallel(myfunc, num_processes=10, axis=0)
	#df.apply(myfunc, axis=1)
	#df.to_csv(Output, index=False)
	del df
	gc.collect()
	print("chunk_done")

print("end")