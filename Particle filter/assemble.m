function [New_Sample_Set,New_Sample_probability]=assemble(Sample_Set,usetimes,Sample_probability,N)

%找到usetimes中元素为0即要抛弃元素的位置
b=find(usetimes==0);
%找到usetimes中元素大于1即要进行复制的粒子的位置
c=find(usetimes>1);
%找到不用复制的粒子的位置
d=find(usetimes==1);


%对不需要复制的粒子直接进行替换
k=1;
length_d=length(d);
while(k<=length_d)
        New_Sample_Set(d(k)).x=Sample_Set(d(k)).x;
        New_Sample_Set(d(k)).y=Sample_Set(d(k)).y;
        k=k+1;
end

%分别对b,c数组进行索引
length_b=length(b);
length_c=length(c);%记录要复制粒子位置的数组长度

%对需要进行复制的粒子先进行一次替换
k=1;
while(k<=length_c)
        New_Sample_Set(c(k)).x=Sample_Set(c(k)).x;
        New_Sample_Set(c(k)).y=Sample_Set(c(k)).y;
        k=k+1;
end


i=1;
j=1;
while(i<=length_c)
    while(usetimes(c(i))>1&&j<=length_b)
        wi=Sample_probability(c(i))/(Sample_probability(c(i))+Sample_probability(b(j)));
        wj=Sample_probability(b(j))/(Sample_probability(c(i))+Sample_probability(b(j)));
        New_Sample_Set(b(j)).x=round(wi*Sample_Set(c(i)).x+wj*Sample_Set(b(j)).x);
        New_Sample_Set(b(j)).y=round(wi*Sample_Set(c(i)).y+wj*Sample_Set(b(j)).y);
        j=j+1;
        usetimes(c(i))=usetimes(c(i))-1;
    end
    i=i+1;
end
%新样本中每个粒子的权值重新分配为1/N
for i=1:N
    New_Sample_probability(i)=1/N;
end