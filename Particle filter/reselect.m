function usetimes=reselect(Sample_Set,Sample_probability,N)


C_probability(1)=Sample_probability(1);
for i=2:1:N
    C_probability(i)=Sample_probability(i)+C_probability(i-1);
end

for i=1:1:N  
    Cumulative_probability(i)= C_probability(i)/C_probability(N);
end

Y=rand(1,N);

%每个采样点重复的次数
usetimes=zeros(1,N);
for i=1:N
    
   j=min(find(Cumulative_probability>=Y(i)));
   usetimes(j)=usetimes(j)+1;
      
end
        


    




