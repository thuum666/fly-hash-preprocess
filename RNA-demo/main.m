clear;clc;close all;
tic;
name='Zeisel'; % choose different input dataset
mkdir('demo_result');
load(['data/',name,'.mat']);

k=3000;% hash length

in_X=full(in_X);
[m,n]=size(in_X);

disp('caculating hash-tsne, it may need several minutes, please wait...');
y1=hash_tsne(in_X,k,0.01);
save([pwd,'/demo_result/hash tsne'],'y1');
disp('finished.');

disp('caculating original-tsne, it may need several minutes, please wait...');
y2=tsne(in_X);
save([pwd,'/demo_result/original tsne'],'y2');
disp('finished.');

disp('drawing figures...');
figure;
colormap hsv;
subplot(1,2,1)
scatter(y1(:,1),y1(:,2),20*ones(m,1),true_labs,'filled');
title('hash tsne')
subplot(1,2,2)
scatter(y2(:,1),y2(:,2),20*ones(m,1),true_labs,'filled');
title('original tsne')
set(gcf,'Position',get(0,'ScreenSize'));
saveas(gcf,[pwd,'/demo_result/comparison_RNAseq.png'],'png');
toc;

