# Fly-hash-preprocess
  Materials for fly hash preprocess with a demonstration
# System requirements
  The scripts are based on Matlab R2018a with an up-to-date statistics and machine learning toolbox. The scripts may not be executed properly in previous versions of Matlab.
  The time cost of demo is tested with a multi-core workstation, however, it may not cost much more time on an ordinary PC since the demo code has not been optimized for multi-core processing.
  There is no specific requirement for operating systems. Win10 is recommended. 
# Installation guide
  Just put the code and data together under your Matlab workspace. 
# Instructions for demo
  ## MNIST
    1. Put the MNIST-demo folder under the workspace
    2. The default parameters are optimized already
    3. Run main.m
    4. Typical time cost is 236s
  The results will show up in a folder named "demo_result". The expected results are stored in "expected_result". The detailed t-SNE plots may be different each time due to the stochastic nature of t-SNE, however, the overall conclusion should be the same. 
  ## scRNA-seq
    1. The same with MNIST demo, use RNA-demo instead
    2. Typical time cost is 250s
  ## CyTOF
  Demo for cytof is not provided because fly-hash's improvement of cytof dataset emerges when the sample size is large, which will cost quite a long time and not suitable as a demo. The cytof datasets and scripts are provided in the reproducation part.
# Instructions for reproduction
  see "reproduction" branch.
# Correspondence and bug report
  please contact yztanzy@gmail.com
