import os, glob
from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

#path = "C:/Users/guazz/Desktop/JSON_Elab/12001626/"

df1 = pd.read_csv('16474724_2020_formattato_dataCambiata_NOERROR_80percent.csv')
print (df1)
df2 = pd.read_csv('16474724_2020_formattato_dataCambiata_ONLYERROR_80percent.csv',dtype={'mver': str})
print(df2)
#df2.drop("mver",axis=1, inplace=True) # posso toglierla come no.. da problemi in lettura perchè fa warning ma dato che quella colonna non si usa ...
#df1.drop("mver",axis=1, inplace=True)
df_merged= pd.concat([df1,df2],ignore_index=True)
df_merged.drop("Unnamed: 0",axis=1, inplace=True)
df_merged.to_csv("16474724_2020_all_80perc.csv")
