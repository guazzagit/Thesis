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

def quantile(x,q):
    n = len(x)
    y = np.sort(x)
    return(np.interp(q, np.linspace(1/(2*n), (2*n-1)/(2*n), n), y))

def prctile(x,p):
    return(quantile(x,np.array(p)/100))


s_train = pd.read_csv("./16430285_2020_format_div_dateChanged_80perc_asn.csv", index_col=0, parse_dates=True,usecols=[1,2,3])#ricorda di rimett123
s_train.sort_values('timestamp',inplace=True)
print(s_train)

#rslt_df = s_train[s_train['country_code'] =='DE']
#rslt_df = rslt_df.drop(columns="country_code")

#TimeBins = s_train.groupby(pd.Grouper(level='timestamp',freq='240min'))["resultset.result.rt"].median()#.reset_index() # numero totale di timebins di 2h per dati senza errori
TimeBins = s_train.groupby(pd.Grouper(level='timestamp',freq='240min'))["resultset.result.rt"].apply(lambda x: prctile(x,90,)).reset_index() # numero totale di timebins di 2h per dati senza errori
#print(TimeBins)240
print(TimeBins)
#TimeBins=TimeBins[TimeBins["timestamp"] < '2020-06-30 23:55:55']
TimeBins = TimeBins.set_index('timestamp')
TimeBins = validate_series(TimeBins)

#persist_ad = PersistAD(window=7, c=3, side='both')
#anomalies1 = persist_ad.fit_detect(TimeBins)
#plot(TimeBins, anomaly=anomalies1, ts_linewidth=1, ts_markersize=3, anomaly_color='red', figsize=(20,10), anomaly_tag="marker", anomaly_markersize=5)

#threshold_ad = ThresholdAD(high=150, low=0)
#anomalies = threshold_ad.detect(TimeBins)
#plot(TimeBins, anomaly=anomalies, ts_linewidth=1, ts_markersize=5, anomaly_color='red', anomaly_alpha=0.3, curve_group='all');

outlier_detector = OutlierDetector(LocalOutlierFactor(n_neighbors=150,contamination=0.05))
anomalies = outlier_detector.fit_detect(TimeBins)

plot(TimeBins, anomaly=anomalies, ts_linewidth=1, ts_markersize=5, anomaly_color='red', anomaly_alpha=0.3, curve_group='all');
plt.savefig('test3.png')