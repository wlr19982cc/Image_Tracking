%This function constrains the blobs (particles) to be inside the image region.
function [Y,indices]=Constrained(X)
M=size(X,2);
XMAX=240;YMAX=360;
X(1,:)=max(ones(1,M),X(1,:));
X(2,:)=max(ones(1,M),X(2,:));
X(3,:)=max(ones(1,M),X(3,:));
X(4,:)=max(ones(1,M),X(4,:));
X(3,:)=min(YMAX*ones(1,M),X(1,:)+X(3,:))-X(1,:);
X(4,:)=min(XMAX*ones(1,M),X(2,:)+X(4,:))-X(2,:);
indices=(X(3,:)>10) & (X(4,:)>10);
Y=X(:,indices);
end