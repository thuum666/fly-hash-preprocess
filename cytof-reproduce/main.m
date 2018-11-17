% test fly hash together with t-sne using mnist_background dataset.
clc;clear;close all;

resname='cns'; % choose the name of input data set
rep=1; % useless in final version
s=5; % sample ratio
k = 150; % length of hash tags
mkdir([pwd,'/result/',resname]);

% load from exist mat
load([pwd,'/sampledata/',resname,'.mat']);

data=repmat(originData,[1 rep]); % allow repeated sampling in hash process

p = 20*k; % random projection

[m,n] = size(data);
pn = round(n/s); % x% of channel in PN are sampled,change with channel number
% center the mean %
PN = zscore(data,[],2);
%         PN=data;
% fin

% random projection %
% projection matrix generation %
P = zeros(n,p);
P(1:pn,:) = ones(pn,p);
for i = 1:p
    perm(:,i) = randperm(n);
end
P = P(perm);
% generation fin %
KC = PN*P;
% fin

% winner take all %
prc = prctile(KC,95,2);
KC(KC<prc)=0;
% fin

% tsne %
[y1,loss1] = tsne(KC);
figure
subplot(1,2,1);scatter(y1(:,1),y1(:,2),10*ones(m,1),'filled');
save([pwd,'/result/',resname,'/sample-hash tsne'],'y1','labels','individual','group');

[y2,loss2] = tsne(originData);
subplot(1,2,2);scatter(y2(:,1),y2(:,2),10*ones(m,1),'filled');
save([pwd,'/result/',resname,'/sample-origin tsne'],'y2','labels','individual','group');
