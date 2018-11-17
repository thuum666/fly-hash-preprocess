function y=hash_tsne(data,k,s)
% k:hash length
% s:ratio of sampling
%     for k= 150%loop for different hash length


[m,n] = size(data);
% k = 8000; % length of hash tags
p = 20*k; % random projection
pn = round(n*s); % x% of channel in PN are sampled,change with channel number
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
[y] = tsne(KC);
%     end
end