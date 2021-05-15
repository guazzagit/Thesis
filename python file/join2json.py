from datetime import datetime
import pandas as pd
import csv
import sys
import json
import numpy as np

data1=data2=""

with open('C:/Users/guazz/Desktop/JSON_Elab/12001626_quad1_2019_formattato_dataCambiata_NOERROR_abuf.json', 'r') as Anno2019:

	data1=Anno2019.read()

with open('C:/Users/guazz/Desktop/JSON_Elab/12001626_quad1_formattato_dataCambiata_NOERROR_ABUF.json', 'r') as Anno2020:
	data2=Anno2020.read()


data1+=data2

with open ('TwoYears_12001626.json','w') as out:
	out.write(data1)
	print("finish")