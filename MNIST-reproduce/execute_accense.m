clear;clc;
for factor=[0 0.3 0.5 0.6 0.8 1]
load([pwd,'/data/mnist_background_factor',num2str(factor),'.mat']);
mkdir([pwd,'/result/',num2str(factor),'/accense/']);
k=200;
for par = 1:6
    load([pwd,'/result/',num2str(factor),'/','hash tsne-k',num2str(k),'-',num2str(par)]);
    subpop = ACCENSE_cluster(y1,data,data,[],[pwd '/mnist_dataset/result/accense']);
    save([pwd,'/result/',num2str(factor),'/accense/','hash tsne-k',num2str(k),'-',num2str(par),'-subpop'],'subpop');
end
for par = 1:6
    load([pwd,'/result/',num2str(factor),'/','train-10000-origin tsne-',num2str(par)]);
    subpop = ACCENSE_cluster(y2,data,data,[],[pwd '/mnist_dataset/result/accense']);
    save([pwd,'/result/',num2str(factor),'/accense/','train-10000-origin tsne-',num2str(par),'-subpop'],'subpop');
end
end