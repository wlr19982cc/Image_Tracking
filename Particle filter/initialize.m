function [Sample_Set,Sample_probability,Estimate,target_histgram]=initialize(x,y,hx,hy,H,S,V,N,image_boundary_x,image_boundary_y,v_count,new_sita)
       %预设定每个粒子的初始位置（两维）
       for i=1:1:N
        Sample_Set(i).x=x;
        Sample_Set(i).y=y;    
       end

%得到在HSV空间的颜色直方图
target_histgram=histgram(x,y,hx,hy,H,S,V,image_boundary_x,image_boundary_y,v_count);

%预测目标的中心位置
Estimate(1).x=x;
Estimate(1).y=y;

%更新模板时使用
Estimate(1).histgram=target_histgram;
Estimate(1).probability=weight(Estimate(1).histgram,target_histgram,new_sita,v_count);


%粒子权值初始化
initial_probability=1/N;
    for i=1:N
     Sample_probability(i)=initial_probability;       
    end

