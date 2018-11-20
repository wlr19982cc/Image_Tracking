function img2=image_grab(img1,P)
[XMAX,YMAX,~]=size(img1);
xmin=max(1,P(1));
xmax=min(YMAX,P(1)+P(3));
ymin=max(1,P(2));
ymax=min(XMAX,P(2)+P(4));
img2=img1(ymin:ymax,xmin:xmax,:);
if numel(img2)==0
    disp('null image');
    disp(P);
    disp([ymin ymax]);
    disp([xmin xmax]);
    pause;
end
end