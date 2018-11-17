clear;clc;
factornum=0;
for factor=[0 0.3 0.5 0.6 0.8 1]
    disp(factor);
    load([pwd,'/data/mnist_background_factor',num2str(factor),'.mat']);
    factornum=factornum+1;
    for par=1:6
        knum=1;
        for k=200
            deleteind=[];
            load([pwd,'/result/',num2str(factor),'/accense/','hash tsne-k',num2str(k),'-',num2str(par),'-subpop']);
            %             load([pwd,'/mnist_background_dataset/result/',num2str(factor),'/accense/','train-10000-origin tsne-',num2str(par),'-subpop']);
            tmp=cellfun(@(x) labels(x.ind),subpop,'UniformOutput',false);
            for ii=1:length(tmp)
                if isempty(tmp{ii})||sum(~isnan(tmp{ii}))==0
                    deleteind=[deleteind,ii];
                end
            end
            tmp(deleteind)=[];
            % caculate contigency matric Cij, number of cells in i-th cluster
            % that belong to j-th population
            t=tabulate(labels);
            popn=t(end,1); % get the number of reference populations
            C=[];
            for i=1:length(tmp)
                tbl=[[0:9]',zeros(10,1)];
                tmp_tbl=tabulate(tmp{i});
                tbl(tmp_tbl(:,1)+1,2)=tmp_tbl(:,2);
                if tbl(end,1)~=popn
                    c=[tbl(:,2)',zeros(1,popn-tbl(end,1))];
                else
                    c=tbl(:,2)';
                end
                C(i,:)=c;
            end
            P=C./sum(C,2); % percision matrix
            %         R=C./t(:,2)'; % recall matrix
            R=C./sum(C,1);
            F=2*R.*P./(R+P); % F-measure, harmonic average of P and R
            F(isnan(F))=0;
            f=1-F; % minmize this term by Hungarian algorithm
            [m,n]=size(f);
            costmat=repmat(f,[1 m]);% dummy trick to allow several clusters be assigned to one pop
            [assignment,cost] = munkres(costmat);% assignment by Hungarian algorithm
            
            assignment=mod(assignment,n);
            assignment(assignment==0)=n;% replace 0 with the correct pop index
            pmat=diag(P(1:m,assignment));% P and R after assignment
            rmat=diag(R(1:m,assignment));
            smat=cell2mat(cellfun(@(x) length(x),tmp,'UniformOutput',false))'; % number of each cluster
            P_new=zeros(1,n);
            R_new=zeros(1,n);
            for j=1:n
                id=assignment==j;
                P_new(j)=sum(pmat(id).*smat(id))/sum(smat(id)); % P and R after degenerate
                R_new(j)=sum(rmat(id));
            end
            F_new=harmmean([P_new;R_new]);
            result(knum,par).P=P_new;
            result(knum,par).R=R_new;
            result(knum,par).F=F_new;
            F_new(isnan(F_new))=0;
            result(knum,par).F_mean=sum(F_new)./n;
            FResult(factornum,par)=sum(F_new)./n;
            knum=knum+1;
        end
    end
end