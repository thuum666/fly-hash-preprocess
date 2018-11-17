% test fly hash together with t-sne using mnist_background dataset.
clc;clear;
tic;
factor=0.6; % choose which data set to use
k = 200; % the hash length

load([pwd '/data/mnist_background_factor',num2str(factor),'.mat']);
mkdir([pwd,'/demo_result/',num2str(factor)]);

disp('caculating hash-tsne, it may need several minutes, please wait...');
y1=hash_tsne(data,k,0.1);
save([pwd,'/demo_result/',num2str(factor),'/hash tsne'],'y1');
disp('finished.');

disp('caculating original-tsne, it may need several minutes, please wait...');
y2 = tsne(data);
save([pwd,'/demo_result/',num2str(factor),'/original tsne'],'y2');
disp('finished.');

[m,n]=size(data);

disp('drawing figures...');
figure;
subplot(1,2,1)
scatter(y1(:,1),y1(:,2),10*ones(m,1),labels,'filled');
title('hash tsne')
subplot(1,2,2)
scatter(y2(:,1),y2(:,2),10*ones(m,1),labels,'filled');
title('original tsne')
set(gcf,'Position',get(0,'ScreenSize'));
saveas(gcf,[pwd,'/demo_result/comparison_factor',num2str(factor),'.png'],'png');
toc;


