function [New_Sample_probability,Estimate,vx,vy,TargetPic,Sample_histgram]=evaluate(Sample_Set,Estimate,target_histgram,new_sita,loop,after_prop,H,S,V,N,image_boundary_x,image_boundary_y,v_count,vx,vy,Hx,Hy,Sample_probability)
TargetPic=after_prop;
Total_probability=0;
Sample_histgram=zeros(N,v_count);

for i=1:N
    %求每一个粒子确定的候选模板在HSV空间的颜色直方图
    Sample_histgram(i,:)=histgram((Sample_Set(i).x),(Sample_Set(i).y),Hx,Hy,H,S,V,image_boundary_x,image_boundary_y,v_count);  
    %求每一个粒子的权重
    New_Sample_probability(i)=weight(target_histgram,Sample_histgram(i,:),new_sita,v_count); %#ok<AGROW>
    %目的是为了归一化
    Total_probability=Total_probability+New_Sample_probability(i);
end

%权值归一化
New_Sample_probability=New_Sample_probability./Total_probability;
P_pro=New_Sample_probability;
all=0;
pp=N/30;
for i=1:1:pp
    for j=i+1:N
        k=i;
        if(P_pro(j)>P_pro(k))
            k=j;
        end
    end
    
    tmpo = P_pro(i);
    P_pro(i) = P_pro(k);
    P_pro(k) =tmpo;
    loca(i)=k;  %#ok<AGROW>
    all = all + New_Sample_probability(k);
end
%得到被跟踪目标在当前帧的预测位置
Estimate(loop).x=0;
Estimate(loop).y=0;
for i=1:1:pp
    Estimate(loop).x=Estimate(loop).x+double(Sample_Set(loca(i)).x)*New_Sample_probability(loca(i))/all;
    Estimate(loop).y=Estimate(loop).y+double(Sample_Set(loca(i)).y)*New_Sample_probability(loca(i))/all;
end
%对预测目标模板与目标模板进行比较，以得到实际的跟踪效果，在此基础上决定是否需要进行操作。
Estimate(loop).histgram=histgram(round(Estimate(loop).x),round(Estimate(loop).y),Hx,Hy,H,S,V,image_boundary_x,image_boundary_x,v_count);
Estimate(loop).probability=weight(target_histgram,Estimate(loop).histgram,new_sita,v_count);
                                                                                                                            
%计算目标移动的速度
a=round(Estimate(loop).x);
b=round(Estimate(loop-1).x);
vx(1)=vx(2);
vx(2)=vx(3);
vx(3)=a-b;
c=round(Estimate(loop).y);
d=round(Estimate(loop-1).y);
vy(1)=vy(2);
vy(2)=vy(3);
vy(3)=c-d;

%用椭圆表示被跟踪目标的轮廓
a1=2*(double(Hx))^0.5;
b1=2*(double(Hy))^0.5;
i=0;
for angle=pi/10000:pi/1000:2*pi 
    i=i+1;
    x(i)=round(cos(angle)*a1+ Estimate(loop).x); %#ok<AGROW> %椭圆的参数方程    
    y(i)=round(sin(angle)*b1+ Estimate(loop).y);    %#ok<AGROW>
end
for index_b=1:i
    if(x(index_b)<image_boundary_x)   %不超出范围
        if(y(index_b)<image_boundary_y)
            if(x(index_b)>0)
                if(y(index_b)>0)
                    TargetPic(y(index_b),x(index_b),1)=0;
                    TargetPic(y(index_b),x(index_b),2)=255;
                    TargetPic(y(index_b),x(index_b),3)=0;%循环画圆
                end
            end
        end
    end
end