function w=weight(p,q,sita,m)
simi=0;

for i=1:m
    %其中q是目标模板的颜色直方图，p是以某一中心候选区域的颜色直方图
    simi=simi+(p(i)*q(i))^0.5; 
end

%d表征目标模板和候选区域的相似程度（越小，相似程度越高）
d=(1-simi)^0.5; 

%根据每一个候选区域与目标区域的相似程度给出权重
w=(1/(sita*(2*pi)^0.5))*exp(-(d^2)/(2*sita^2));  
