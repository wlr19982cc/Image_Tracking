function p=kernel_likelihood(v1,V2)
[~,n]=size(V2);
Sigma=0.5;
V1=repmat(v1,1,n);
Y=Hist_Dist(V1,V2);
p=sum(exp(-Y/2/Sigma^2))/(sqrt(2*pi)*Sigma*n);
if p>0.7
    p=0.90;
else
    p=0.01;
end