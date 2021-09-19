import requests
import lxml.html as lh
import pandas as pd
from lxml import etree
from bs4 import BeautifulSoup
from pandas.io.html import read_html
from selenium import webdriver
#download table from aspop url 
#require a chrome or other browser driver to work. in this case chrome
url='https://stats.labs.apnic.net/aspop/'
chrome_Driver_path="C:/Users/guazz/Documents/GitHub/Thesis/python file/chromedriver"
driver = webdriver.Chrome(executable_path=chrome_Driver_path)
driver.get(url)

table = driver.find_element_by_xpath('//div[@id="table_div"]')
table_html = table.get_attribute('innerHTML')

df = read_html(table_html)[0]
print (df)
df.to_csv('asn_number_user.csv',index=False)
#driver.close()