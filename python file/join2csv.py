import os, glob
from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

path = "C:/Users/guazz/Desktop/JSON_Elab/12001626/"

df1 = pd.read_csv('C:/Users/guazz/Desktop/JSON_Elab/12001626/12001626_quad1_2019_formattato_dataCambiata_NOERROR_abuf1.csv')
df2 = pd.read_csv('C:/Users/guazz/Desktop/JSON_Elab/12001626/12001626_quad1_2020_formattato_dataCambiata_NOERROR_abuf2.csv')
df_merged= pd.concat([df1,df2],ignore_index=True)
df_merged.to_csv( "TwoYears_12001626_join.csv", index=False)