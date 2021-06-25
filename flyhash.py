import numpy as np
import pandas as pd
import pickle, time
import os
from collections import OrderedDict as odict
from functools import reduce
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix,cohen_kappa_score
from bokeh.plotting import figure,output_file,output_notebook,show
import bokeh
import csv

path = "./data/NORB/NORB_sample10000.csv"    
Data = pd.read_csv(path)
#label=np.array(Data.iloc[:,-1])
data=np.array(Data.iloc[:,:])

hash_length=100
sampling_ratio=0.1
K=20
embedding_size=K*hash_length

data=data-np.mean(data,axis=1,keepdims=True)

num_projections=int(sampling_ratio*data.shape[1])
weights=np.random.random((data.shape[1],embedding_size))
yindices=np.arange(weights.shape[1])[None,:]
xindices=weights.argsort(axis=0)[-num_projections:,:]
weights=np.zeros_like(weights,dtype=np.bool)
weights[xindices,yindices]= True
        
all_activations=(data@weights)
xindices=np.arange(data.shape[0])[:,None]
yindices=all_activations.argsort(axis=1)[:,-hash_length:]
hashes=np.zeros_like(all_activations,dtype=np.bool)
hashes[xindices,yindices]=True
dense_activations=all_activations
sparse_activations=hashes.astype(np.float32)*all_activations 
maxl1distance=2*hash_length
lowd_hashes=all_activations.reshape((-1,hash_length,K)).sum(axis=-1) > 0 

f=open('./data/NORB/NORBdenseflydata/flyhash_hashlength_100_K_20_sampleratio_0.1_NORB.csv','w',encoding='utf-8',newline="")
csv_writer=csv.writer(f)
csv_writer.writerows(sparse_activations)
f.close()


