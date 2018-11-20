function [L_new,N_new,q_new,X_new,w_new] = merge_targets(q,X,w,dthresh,qthresh)
x_dim= size(X{1},1);
L= length(q);
stillmerge= 1;
while stillmerge
    Xmean= zeros(x_dim,L);
    for i=1:L
        Xmean(:,i)= sum(repmat(w{i}',[x_dim 1]).*X{i},2);
    end
    
    distmatrixm= ones(L,L);
    pextmatrix= 10*ones(L,L);
    for i=1:L
        for j=i+1:L
            %distmatrixm(i,j)= norm(Xmean([1 2],i)-Xmean([1 2],j),inf);
            distmatrixm(i,j)= overlapratio(round(Xmean(:,i)),round(Xmean(:,j))); 
            pextmatrix(i,j)= q(i)+q(j);
        end
    end
    cm= distmatrixm >= dthresh;
    cq= pextmatrix <= qthresh;
    cj= cm.*cq;
    if any(any(cj))
        ctemp=cj.*pextmatrix;
        [n,m]= find(ctemp/max(max(ctemp))==1,1);
        X{n}= [X{n} X{m}];
        w{n}= [q(n)*w{n}; q(m)*w{m}]/(q(n)+q(m));
        q(n)= min(q(n)+q(m),0.999);
        q(m)= [];
        X(m)= [];
        w(m)= [];
        disp(['Two out of ' num2str(L) ' targets were merged']);
        L= L-1;
        if L==1
            stillmerge = 0; 
        end
        
    else
    stillmerge = 0;
    end
    
end
q_new= q;
X_new= X;
w_new= w;
L_new= L;
for j=1:L
    N_new(j)= length(w_new{j}); 
end
end