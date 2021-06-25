import numpy as np
import pandas as pd
import scipy.io as sio
import pickle, time
import os
from collections import OrderedDict as odict
from functools import reduce
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix,cohen_kappa_score
from bokeh.plotting import figure,output_file,output_notebook,show
import bokeh
import csv
import xlwt

path = "./data/NORB/NORB_sample10000.csv" 
Data = pd.read_csv(path)
#label=np.array(Data.iloc[:,-1])
data=np.array(Data.iloc[:,:])

#nnn=1
hash_length=100

data=data-np.mean(data,axis=1,keepdims=True)
#group_counts=np.unique(label).shape[0]

for i in range(10):
    j=i+1
    weights=np.random.random((data.shape[1],hash_length))
    hashes=(data@weights)>0
    #maxl1distance=2*hash_length

    # save csv
    #f=open('./data/simhashdata/simhash_hashlength_1000_Kolod.csv','w',encoding='utf-8',newline="")
    #csv_writer=csv.writer(f)
    #csv_writer.writerows(hashes)
    #f.close()

    # save xlsx
    dataframe = pd.DataFrame(hashes)
    dataframe.to_excel('./data/simhashdata/simhash_hashlength_100_NORB_sample10000_'+str(j)+'.xlsx')

    # save mat
    sio.savemat('./data/simhashdata/simhash_hashlength_100_NORB_sample10000_'+str(j)+'.mat',{'simhashdata':hashes})
    

