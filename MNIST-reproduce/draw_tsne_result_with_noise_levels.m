clear;clc

for par=1:6
mkdir([pwd,'\result\figure_result\tsne\',num2str(par)]);
for factor=[0 0.3 0.5 0.6 0.8 1]
load([pwd,'\data\mnist_background_factor',num2str(factor),'.mat'])
load([pwd,'\result\',num2str(factor),'\hash tsne-k200-',num2str(par),'.mat'])
load([pwd,'\result\',num2str(factor),'\train-10000-origin tsne-',num2str(par),'.mat'])
m=size(data,1);
figure;
scatter(y1(:,1),y1(:,2),5*ones(m,1),labels,'filled');
saveas(gcf,[pwd,'\result\figure_result\tsne\',num2str(par),'\hash tsne-',num2str(factor),'.png'],'png');
figure;
scatter(y2(:,1),y2(:,2),5*ones(m,1),labels,'filled');
saveas(gcf,[pwd,'\result\figure_result\tsne\',num2str(par),'\origin tsne-',num2str(factor),'.png'],'png');
close all;
end
end