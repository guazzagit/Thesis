import os, glob
from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np
#join 2 csv file 

Input_1 = sys.argv[1]
Input_2 = sys.argv[2]
Output = sys.argv[3]

df1 = pd.read_csv(Input_1)
print (df1)
df2 = pd.read_csv(Input_2,dtype={'mver': str})
print(df2)
#df2.drop("mver",axis=1, inplace=True) # posso toglierla come no.. da problemi in lettura perchè fa warning ma dato che quella colonna non si usa ...
#df1.drop("mver",axis=1, inplace=True)
df_merged= pd.concat([df1,df2],ignore_index=True)
df_merged.drop("Unnamed: 0",axis=1, inplace=True)
df_merged.to_csv(Output)
