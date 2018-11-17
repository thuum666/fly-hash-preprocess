% test fly hash together with t-sne using mnist_background dataset.
clc;clear;

for factor=[0 0.3 0.5 0.6 0.8 1]

load([pwd '/data/mnist_background_factor',num2str(factor),'.mat']);
mkdir([pwd,'/result/',num2str(factor)]);

k = 200;
for par = 1:6
    y1=hash_tsne(data,k,0.1);
    save([pwd,'/result/',num2str(factor),'/hash tsne-k',num2str(k),'-',num2str(par)],'y1');
end

for par = 1:6
    y2 = tsne(data);
    save([pwd,'/result/',num2str(factor),'/train-10000-origin tsne-',num2str(par)],'y2');
end
end
