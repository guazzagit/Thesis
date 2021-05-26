from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

data1=data2=""

with open('16453685_ping_2019_format_dataCambiata.json', 'r') as Anno2019:

	data1=Anno2019.read()

with open('16453685_ping_2020_format_dataCambiata.json', 'r') as Anno2020:
	data2=Anno2020.read()


data1+=data2

with open ('TwoYears_16453685.json','w') as out:
	out.write(data1)
	print("finish")