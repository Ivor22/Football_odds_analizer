from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from time import sleep
import pandas as pd
import csv
import numpy as np
a=[]
b=[]
DRIVER_LOCATION ="C:\\Users\\dsant\\OneDrive\\Radna površina\\ODDS\\chromedriver_win32_drugi\\chromedriver.exe"
 
for page in range(1,5,1):
    driver = webdriver.Chrome(executable_path = DRIVER_LOCATION) 
    driver.set_window_position(0, 0)
    driver.set_window_size(1000, 768)
    driver.get("https://www.oddsportal.com/soccer/croatia/1-hnl-2020-2021/results/#/page/"+str(page)) 
    driver.implicitly_wait(4)
    driver.find_element_by_xpath('//*[@id="onetrust-accept-btn-handler"]').click()
    driver.implicitly_wait(2)
    dulj_tr = len(driver.find_elements_by_xpath("//table[@id='tournamentTable']/tbody/tr"))
    for i in range(dulj_tr):
        element = (driver.find_element_by_xpath('//*[@id="tournamentTable"]/tbody/tr['+str(i+1)+']').text).replace('\n',',')
        if len(element)>30:
            dulj_td = len(driver.find_elements_by_xpath('//*[@id="tournamentTable"]/tbody/tr['+str(i+1)+']/td'))
            if dulj_td >1:    
                for j in range(dulj_td):
                    element2 = driver.find_element_by_xpath('//*[@id="tournamentTable"]/tbody/tr['+str(i+1)+']/td['+str(j+1)+']').text
                    if j==2:
                        element3 = element2.split(":")
                        a.append(element3[0])
                        a.append(element3[1])
                    else:
                        a.append(element2)
                    if (len(a)==8):
                        b.append(a)
                        a=[]


        print(f"STRANICA:{page}, PODATAK:{i}")
print(1)
odds = pd.DataFrame(b, columns = ['Vrijeme','Tko', 'G1','G2','1', 'X', '2', '#B'])
print(2)
odds.to_csv('hnl-2020-2021_6622.csv', encoding='utf-8', index=False)
print("Gotovo") 