function X= gen_birthstate_density(model,birthid,num_par)
j= birthid;
barX = model.bar_x{j};
xmin=barX(1,1); xmax=barX(1,2);
ymin=barX(2,1); ymax=barX(2,2);
wmin=barX(3,1); wmax=barX(3,2);
hmin=barX(4,1); hmax=barX(4,2);
X1=round(rand(1,num_par)*(xmax-xmin)+xmin);
X2=round(rand(1,num_par)*(ymax-ymin)+ymin);
X3=round(rand(1,num_par)*(wmax-wmin)+wmin);
X4=round(rand(1,num_par)*(hmax-hmin)+hmin);
X=[X1 ; X2 ; X3 ; X4];
end