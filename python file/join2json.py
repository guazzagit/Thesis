from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

Input_2019 = sys.argv[1]
Input_2020 = sys.argv[2]
Output = sys.argv[3]
data1=data2=""
#join 2 json file. 2019 and 2020 
with open(Input_2019, 'r') as Anno2019:

	data1=Anno2019.read()

with open(Input_2020, 'r') as Anno2020:
	data2=Anno2020.read()


data1+=data2

with open (Output,'w') as out:
	out.write(data1)
	print("finish")