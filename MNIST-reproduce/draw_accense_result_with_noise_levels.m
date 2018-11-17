clear;clc;
for par=1:6
mkdir([pwd,'\result\figure_result\accense\',num2str(par)]);
for factor=[0 0.3 0.5 0.6 0.8 1]
load([pwd,'\data\mnist_background_factor',num2str(factor),'.mat'])
load([pwd,'\result\',num2str(factor),'\hash tsne-k200-',num2str(par),'.mat'])
load([pwd,'\result\',num2str(factor),'\accense\hash tsne-k200-',num2str(par),'-subpop.mat'])
[~,ydata,~,IND]=convert_subpop_struct(subpop,y1);
m=size(ydata,1);
figure;
scatter(ydata(:,1),ydata(:,2),5*ones(m,1),labels(IND),'filled');
saveas(gcf,[pwd,'\result\figure_result\accense\',num2str(par),'\hash tsne-',num2str(factor),'.png'],'png');

load([pwd,'\result\',num2str(factor),'\train-10000-origin tsne-',num2str(par),'.mat'])
load([pwd,'\result\',num2str(factor),'\accense\train-10000-origin tsne-',num2str(par),'-subpop.mat'])
[~,ydata,~,IND]=convert_subpop_struct(subpop,y2);
m=size(ydata,1);
figure;
scatter(ydata(:,1),ydata(:,2),5*ones(m,1),labels(IND),'filled');
saveas(gcf,[pwd,'\result\figure_result\accense\',num2str(par),'\origin tsne-',num2str(factor),'.png'],'png');
close all;
end
end


function [data,ydata,subGroupLabel,IND]=convert_subpop_struct(subpop,y)
data=[];
subGroupLabel=[];
IND=[];
for i=1:length(subpop)
    X=subpop{i}.X;
    ind=subpop{i}.ind;
    label=i*ones(subpop{i}.size,1);
    data=[data;X];
    subGroupLabel=[subGroupLabel;label];
    IND=[IND;ind];
    ydata=y(IND,:);
end
end