clear;clc;
qNum=100;
for par=1:6
    disp(par)
    factorind=0;
    for factor=[0 0.3 0.5 0.6 0.8 1]
        factorind=factorind+1;
        load([pwd,'\result\',num2str(factor),'\hash tsne-k200-',num2str(par),'.mat'])
        load([pwd,'\result\',num2str(factor),'\train-10000-origin tsne-',num2str(par),'.mat'])
        load([pwd,'\data\mnist_background_factor0.mat'])
        originData0=data;
        load([pwd,'\data\mnist_background_factor',num2str(factor),'.mat'])
        originData=data;
        for ii=1:50
            h1(ii)=distance(originData,y1,qNum); % change the input here for comparison between different spaces
            h2(ii)=distance(originData,y2,qNum);
        end
        H1(par,factorind)=mean(h1);
        H2(par,factorind)=mean(h2);
    end
end

function [H,P,F]=distance(X,Y,qNum)
% H define as harmonic mean of P(X to Y MAP) and F(Y to X MAP)
[m,~]=size(X);
qId=randperm(m,qNum);
P=MAP(Y,X,qId);
F=MAP(X,Y,qId);
H=harmmean([P,F]);
end
function [P]=MAP(Y,X,qId)
% mean average percision refer to DOI 10.1109/CVPR.2013.64
% define as Y's distance from X
[m,~]=size(X);
qNum=size(qId,2);
qind=zeros(1,m);
qind(qId)=1;
qind=logical(qind);
ind=~qind;
qx=X(qind,:);
x=X(ind,:);
qy=Y(qind,:);
y=Y(ind,:);
Idx = knnsearch(y,qy);
trueNeighbourInd=knnsearch(x,qx,'k',m*0.02);
for i=1:qNum
    result(i)=sum(trueNeighbourInd(i,:)==Idx(i));
end
P=sum(result)./qNum;
end