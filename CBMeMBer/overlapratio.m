function r=overlapratio(X1,X2)
    x1= X1(1); y1=X1(2); w1=X1(3); h1=X1(4);
    x2= X2(1); y2=X2(2); w2=X2(3); h2=X2(4);
    im1=zeros(240,360);
    im2=im1;
    im1(y1:(y1+h1),x1:(x1+w1))=1;
    im2(y2:(y2+h2),x2:(x2+w2))=1;
    im12=im1.*im2;
    r=sum(sum(im12))/min(h1*w1,h2*w2);
end