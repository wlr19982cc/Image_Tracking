clear;
clc;

%在HSV空间中，将三个颜色分量通过计算合成为一维特征向量(直方图)时，一维特征向量的大小为v_count
v_count=331;
%采样粒子的个数
N=2000;
%视频序列中的图像帧数
n=40;
%第一帧图像的序号
first=100;
%高斯分布方差
new_sita=0.2;
%目标三个连续时刻的移动速度（两维vx,vy）
vx=[0,0,0];
vy=[0,0,0];
%求取目标速度的时候用到变量runtime
runtime=3;
%存储结构体的指数
struct_index=0;
%产生随机粒子的方差
sigma_x=5;
sigma_y=5;
%前10帧图像与目标模板的相似度
pre_probability=zeros(1,10);
%判断是否进行重采样
resample_judge=0;

%得到目标模板的初始数据
I=imread('E:\文件\科学研究\SRTP\代码\粒子滤波\version3.0\仿真图片8\100.jpg');
%显示第一帧画面
imshow(I);
%%在第一帧中通过鼠标手动选定跟踪目标
rect = getrect();
x1 = rect(1); 
x2 = rect(1) + rect(3);
y1 = rect(2);
y2 = rect(2) + rect(4);

%得到初始跟踪目标的中心坐标点
x=round((x1+x2)/2);
y=round((y1+y2)/2);
%得到描述目标轮廓的椭圆的长短半轴的平方
hx=((x2-x1)/2)^2;
hy=((y2-y1)/2)^2;
%upper_hists=I(y1:y,x1:x2,:);
%lower_hists=I(y:y2,x1:x2,:);
%得到图形的边界
sizeimage=size(I);
image_boundary_x=int16(sizeimage(2)); % 宽
image_boundary_y=int16(sizeimage(1)); % 高

[H,S,V]=rgb_to_rank(I);
%初始化，得到粒子的初始分布，赋初始权值为1/N
[Sample_Set,Sample_probability,Estimate,target_histgram]=initialize(x,y,hx,hy,H,S,V,N,image_boundary_x,image_boundary_y,v_count,new_sita);
pre_probability(1)=Estimate(1).probability;


%从第二帧往后循环迭代的进行下去
for loop=2:n
    struct_index=struct_index+1;
    a=num2str(loop+first-1);
    %打开并显示图片
    b=[a,'.jpg'];
    b=['E:\文件\科学研究\SRTP\代码\粒子滤波\version3.0\仿真图片8\',b]; %#ok<AGROW>
    I=imread(b);
    [H,S,V]=rgb_to_rank(I);
    %产生随机粒子
    

    [Sample_Set,after_prop]=reproduce(Sample_Set,vx,vy,image_boundary_x,image_boundary_y,I,N,sigma_x,sigma_y,runtime);    
    %得出被跟踪目标的在当前帧的预测位置
    [Sample_probability,Estimate,vx,vy,TargetPic,Sample_histgram]=evaluate(Sample_Set,Estimate,target_histgram,new_sita,loop,after_prop,H,S,V,N,image_boundary_x,image_boundary_y,v_count,vx,vy,hx,hy,Sample_probability);
    %模板更新时和重采用判断时，都要用到归一化的权值Sample_probability 
    %kpl = Estimate(loop).probability
    
    
    %模板跟新
    if(loop<=10) %前10帧属于特殊情况，需要额外进行处理
        sum_probability=0;
        for p=1:loop-1
            sum_probability=sum_probability+pre_probability(p);
        end 
        mean_probability=sum_probability/(loop-1);
    else %直接求取均值
        mean_probability=mean(pre_probability);
    end
    
   %如果这一时刻的颜色直方图可能性比平均值的可能性大，则需要把这个颜色直方图代入颜色直方图模板计算
    if(Estimate(loop).probability>mean_probability+1)
        [target_histgram,pre_probability]=update_target(target_histgram,Sample_histgram,Sample_probability,pre_probability,Estimate,N,v_count,loop,resample_judge);
   
    %如果这一时刻的颜色直方图可能性比平均值的可能性小，可以不进行模板更新，但是要对pre_probability进行更新操作   
    else
        if(loop>10) 
             for k=1:9
                 pre_probability(k)=pre_probability(k+1);
             end
             pre_probability(10)=Estimate(loop).probability;
        else 
            pre_probability(loop)=Estimate(loop).probability;
        end
    end
     
    resample_judge=0;
        
    %判断是否需要重采样
    back_sum_weight=0;
    for judge=1:N
        back_sum_weight=back_sum_weight+(Sample_probability(judge))^2;
    end
    sum_weight=1/back_sum_weight;
    if(sum_weight<N)
        %重采样过程
        usetimes=reselect(Sample_probability,N);
        [Sample_Set,Sample_probability]=assemble(Sample_Set,usetimes,Sample_probability,N); %进行线性组合
        resample_judge=1;
    end
    
    
%得到目标运动的轨迹
if(struct_index==1)
    routine.x=round(Estimate(loop).x);
    routine.y=round(Estimate(loop).y);
else
    routine(struct_index).x=round(Estimate(loop).x); %#ok<SAGROW>
    routine(struct_index).y=round(Estimate(loop).y); %#ok<SAGROW>
end
i=1;
j=1;
while(j<=struct_index)
    for new_x=routine(j).x-i:routine(j).x+i
       for new_y=routine(j).y:routine(j).y+i
            TargetPic(new_y,new_x,1)=0;
            TargetPic(new_y,new_x,2)=0;
            TargetPic(new_y,new_x,3)=255;
       end
    end   
    j=j+1;
end
     imshow(TargetPic);


end



