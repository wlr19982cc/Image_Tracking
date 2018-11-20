function v=hist_vector(img)
img2=rgb2hsv(img);
nH=3; nS=3; nV=10;
bh_matrix=(img2(:,:,1)*nH);
bs_matrix=(img2(:,:,2)*nS);
bv_matrix=(img2(:,:,3)*nV/256);
b_matrix=bh_matrix+bs_matrix*nH+bv_matrix*nH*nS;
[xdim,ydim]=size(b_matrix);
Reshaped_b=reshape(b_matrix,xdim*ydim,1);
[nbins,~]=hist(Reshaped_b,0.5:1:(nH*nS*nV-1.5));
v=nbins';
if sum(v)==0
    disp('all zero bins!!');
    pause;
else
    v=v/sum(v);
end
end