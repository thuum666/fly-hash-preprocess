# Fly-hash-preprocess
materials for fly hash preprocess to reproduce results in paper
## MNIST reproduce
  1. set "MNIST-reproduce" folder as the working folder
  2. run main.m to generate t-sne results, which is the base of all the following evaluation. The script contains loops so it may cost several hours to run. 
  3. run execute_accense.m to generate accense result, the accense script is based on Shekhar's work (10.1073/pnas.1321405111) with some minor tweaks.
  4. the figures of t-sne and accense clustering are generated with draw_tsne_result_with_noise_levels.m and draw_accense_result_with_noise_levels.m
  5. the dimensionality evaluation and clustering evaluation are performed with clustering_evaluation.m and DR_evaluation.m
  6. the F1 score of accense clustering result are calculated with evaluateF.m

## scRNA-seq reproduce
  1. set "RNA-reproduce" folder as the working folder
  2. run main.m
  3. for reproduction of different datasets, change the input "name" with names in "data" folder

## CyTOF reproduce
  1. set "cytof-reproduce" folder as the working folder
  2. run main.m
  3. for reproduction of different datasets, change the input "resname" with names in "sampledata" folder
  4. sampled data are provided here for reproduction. To get the raw and complete datasets, see "source data" folder. 
  
## Correspondence and bug report
  please contact yztanzy@gmail.com
