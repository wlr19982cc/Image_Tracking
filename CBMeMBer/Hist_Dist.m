function Y=Hist_Dist(V1,V2)
Y=(1-sum((V1.*V2).^0.5));
%Y=(sum(V1(:,:,1)-V2(:,:,1))).^2;
end