clear;clc;
method='CalinskiHarabasz'; % change the method name for evaluating by different methods
for par=1:6
    disp(par);
    factorind=0;
    for factor=[0 0.3 0.5 0.6 0.8 1]
        factorind=factorind+1;
        load([pwd,'\result\',num2str(factor),'\hash tsne-k200-',num2str(par),'.mat'])
        load([pwd,'\result\',num2str(factor),'\train-10000-origin tsne-',num2str(par),'.mat'])
        %%%%%%%%%%%%
        load([pwd,'\result\',num2str(factor),'\accense\hash tsne-k200-',num2str(par),'-subpop.mat']);
        [~,ydata,subGroupLabel]=convert_subpop_struct(subpop,y1);
        E = evalclusters(ydata,subGroupLabel,method);
        result1(par,factorind)=E.CriterionValues;
        % disp(E.CriterionValues)
        
        load([pwd,'\result\',num2str(factor),'\accense\train-10000-origin tsne-',num2str(par),'-subpop.mat']);
        [~,ydata,subGroupLabel]=convert_subpop_struct(subpop,y2);
        E = evalclusters(ydata,subGroupLabel,method);
        % disp(E.CriterionValues)
        result2(par,factorind)=E.CriterionValues;
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