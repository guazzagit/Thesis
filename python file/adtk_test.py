import pandas as pd
import csv
import sys
import json
import numpy as np
from csv import DictReader
from datetime import datetime
from adtk.data import validate_series
from adtk.visualization import plot
from matplotlib import pyplot as plt
from adtk.detector import OutlierDetector
from sklearn.neighbors import LocalOutlierFactor
from adtk.data import validate_events
from adtk.data import split_train_test
from adtk.detector import PersistAD
from adtk.detector import ThresholdAD
from adtk.detector import CustomizedDetectorHD
Input = sys.argv[1] # file
Input2 = sys.argv[2]  #year
def Detector_prive(df):
	soglia=np.mean(df["resultset.result.rt"])
	return (df["resultset.result.rt"] > soglia*2)

def quantile(x,q):
    n = len(x)
    y = np.sort(x)
    return(np.interp(q, np.linspace(1/(2*n), (2*n-1)/(2*n), n), y))

def prctile(x,p):
    return(quantile(x,np.array(p)/100))

lista= [3352, 12479, 3215, 5410, 8228, 12322, 15557, 21502, 35540, 1267, 3269, 12874, 3301, 8473, 553, 680, 3209, 3320, 6805, 6830, 8422, 8767, 8881, 9145, 15943]

s_train = pd.read_csv(Input, index_col=0, parse_dates=True,usecols=[1,2,6])# per file vecchi ear 4 non 8
s_train.sort_values('timestamp',inplace=True)
print(s_train)
print(s_train['asn_v4'])
for elem in lista:
	#rslt_df = s_train[s_train['country_code'] =='DE']
	#rslt_df = rslt_df.drop(columns="country_code")
	rslt_df = s_train[s_train['asn_v4'] ==elem]
	rslt_df = rslt_df.drop(columns="asn_v4")

	#TimeBins = rslt_df.groupby(pd.Grouper(level='timestamp',freq='240min'))["resultset.result.rt"].median()#.reset_index() # numero totale di timebins di 2h per dati senza errori
	TimeBins = rslt_df.groupby(pd.Grouper(level='timestamp',freq='60min'))["resultset.result.rt"].apply(lambda x: prctile(x,90,)).reset_index() # numero totale di timebins di 2h per dati senza errori
	#print(TimeBins)240
	TimeBins["resultset.result.rt"]=TimeBins["resultset.result.rt"].rolling(min_periods=1,center=True,window=5).mean()
	boolean_condition = TimeBins["resultset.result.rt"] > 450
	column_name = "resultset.result.rt"
	new_value = 450
	TimeBins.loc[boolean_condition, column_name] = new_value
	print(TimeBins)
	#TimeBins=TimeBins[TimeBins["timestamp"] < '2020-06-30 23:55:55']
	TimeBins = TimeBins.set_index('timestamp')
	TimeBins = validate_series(TimeBins)

	#persist_ad = PersistAD(window=7, c=3, side='both')
	#anomalies1 = persist_ad.fit_detect(TimeBins)
	#plot(TimeBins, anomaly=anomalies1, ts_linewidth=1, ts_markersize=3, anomaly_color='red', figsize=(20,10), anomaly_tag="marker", anomaly_markersize=5)

	#customized_detector = CustomizedDetectorHD(detect_func=Detector_prive)
	#anomalies = customized_detector.detect(TimeBins)

	#threshold_ad = ThresholdAD(high=150, low=0)
	#anomalies = threshold_ad.detect(TimeBins)
	#plot(TimeBins, anomaly=anomalies, ts_linewidth=1, ts_markersize=5, anomaly_color='red', anomaly_alpha=0.3, curve_group='all');

	outlier_detector = OutlierDetector(LocalOutlierFactor(n_neighbors=5,p=1,contamination=0.05))
	anomalies = outlier_detector.fit_detect(TimeBins)
	name= Input2 +"_"+ str(elem)
	plot(TimeBins, anomaly=anomalies, ts_linewidth=1, ts_markersize=5, anomaly_color='red', anomaly_alpha=0.3, curve_group='all');
	plt.ylim(top=460)
	plt.savefig('%s.pdf' %elem,bbox_inches='tight')
	plt.close()
	del TimeBins
	del rslt_df
	del boolean_condition
