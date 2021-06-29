import pandas as pd
from adtk.data import validate_series
from adtk.visualization import plot
from matplotlib import pyplot as plt
from adtk.detector import OutlierDetector
from sklearn.neighbors import LocalOutlierFactor
from adtk.data import validate_events
from adtk.data import split_train_test

s_train = pd.read_csv("./ouTEst_ANOMALY.csv", index_col="timestamp", parse_dates=True)
s_train.sort_values('timestamp',inplace=True)
s_train = validate_series(s_train)
print(s_train)
outlier_detector = OutlierDetector(LocalOutlierFactor(contamination=0.1))
anomalies = outlier_detector.fit_detect(s_train)
plot(s_train, anomaly=anomalies, ts_linewidth=1, ts_markersize=5, anomaly_color='red', anomaly_alpha=0.3, curve_group='all');
plt.show()
