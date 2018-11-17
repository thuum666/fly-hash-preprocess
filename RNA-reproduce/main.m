clear;clc;close all;
name='4_Zeisel'; % choose different input dataset
mkdir(['result/',name]);
load(['data/',name,'.mat']);
in_X=full(in_X);
[m,n]=size(in_X);
y2=tsne(in_X);
% for k=[5000 10000]
% for s=[0.01 0.03 0.1 0.3]
for i=1:6
% i=0;
s=0.01;
k=3000;
y1=hash_tsne(in_X,k,s);

figure
subplot(1,2,1);scatter(y1(:,1),y1(:,2),20*ones(m,1),true_labs,'filled');
subplot(1,2,2);scatter(y2(:,1),y2(:,2),20*ones(m,1),true_labs,'filled');

savefig(gcf,['result/',name,'/',name,'-k',num2str(k),'-s',num2str(s),'-',num2str(i),'.fig']);
save(['result/',name,'/',name,'-k',num2str(k),'-s',num2str(s),'-',num2str(i),'.mat'],'y1','y2','true_labs');
end
